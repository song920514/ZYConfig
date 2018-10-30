//
//  BasicService.swift
//  HFSTeacher
//  提供基础的网络封装
//  Created by LuoCangjian on 2018/5/19.
//  Copyright © 2018年 yunxiao. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import Alamofire

/// 网络请求完成后的回调
public typealias JCRequstSuccessCompletion = (_ jsonData:JSON?) -> ()

public typealias JCRequstFailureCompletion = (_ code: Int, _ message: String) -> ()

class NetworkService {
    /// 显示loading的插件
    fileprivate static let requestLoadingPlugin = RequestLoadingPlugin()
    /// 用于获取日志显示的时间
    fileprivate static let dateFormatter = DateFormatter()
    /// 设置请求超时的回调
    fileprivate static let requestTimeoutClosure = { (endpoint: Endpoint, closure: @escaping MoyaProvider<MultiTarget>.RequestResultClosure) in
        do {
            var urlRequest = try endpoint.urlRequest()
            urlRequest.timeoutInterval = 30 //设置请求超时时间
            closure(.success(urlRequest))
        } catch MoyaError.requestMapping(let url) {
            closure(.failure(MoyaError.requestMapping(url)))
        } catch MoyaError.parameterEncoding(let error) {
            closure(.failure(MoyaError.parameterEncoding(error)))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }
    /// 网络请求管理器
    fileprivate static let alamofireManager: Manager = {
        //配置netfox检测 https
        let configuration = URLSessionConfiguration.default
//        configuration.protocolClasses?.insert(NFXProtocol.classForCoder(), at: 0)
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        return Manager(configuration: configuration)
    }()

    /// 网络请求都通过该对象进行发送
    public static let provider: MoyaProvider<MultiTarget> = {
        return MoyaProvider<MultiTarget>(requestClosure:requestTimeoutClosure, manager: alamofireManager, plugins: [requestLoadingPlugin])
    }()
    
    /// 网络请求接口
    ///
    /// - Parameters:
    ///   - target: 网络请求配置(遵守HttpConfigProtol协议的枚举值)
    ///   - isShow: true - 显示loading   false - 不显示loading
    ///   - completionClosure: 网络请求完成后的回调
    public class func request<T: JCTargetType & TargetType>(target: T, isShowLoading: Bool = false, successCompletion:@escaping JCRequstSuccessCompletion,failureCompletion:@escaping JCRequstFailureCompletion) {
        
        //检查网络
        guard let manager = NetworkReachabilityManager() , manager.isReachable else {
            failureCompletion(InternalCode.networkUnreachable.rawValue,InternalCode.networkUnreachable.codeString)
            printFailure(path: target.path, paramDesc: String(describing: target), message: InternalCode.networkUnreachable.codeString)
            return
        }
        requestLoadingPlugin.isShowLoading = isShowLoading
        provider.request(MultiTarget(target)) { result in
            switch result {
            case let .success(response):
                do {
                    //如果数据返回成功则直接将结果转为JSON
                    let _ = try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    // 成功回调
                    self.parsingResponse(target, json, successCompletion,failureCompletion)
                    
                }  catch {
                    // JSON解析失败
                    failureCompletion(InternalCode.invalidJSON.rawValue, InternalCode.jsonMapping.codeString)
                    printFailure(path: target.path, paramDesc: String(describing: target), message: InternalCode.jsonMapping.codeString)
                }
            case let .failure(error):
                let code: InternalCode = ResponseStatusMessage.moyaError2InternalError(error)
                var message: String = code.codeString
                if case .alamofireRequestFailed = code {
                    message = error.errorDescription ?? code.codeString
                }
                failureCompletion(code.rawValue, message)
                printFailure(path: target.path, paramDesc: String(describing: target), message:message)
            }
        }
    }
    
    /// 解析响应数据
    ///
    /// - Parameters:
    ///   - target: 接口请求配置
    ///   - json: json数据
    ///   - completionClosure: 请求完成的回调
    fileprivate class func parsingResponse<T: JCTargetType & TargetType>(_ target: T, _ json: JSON, _ successCompletion:@escaping JCRequstSuccessCompletion,_ failureCompletion:@escaping JCRequstFailureCompletion) {
        guard json != JSON.null || json != JSON.null else {
            printFailure(path: target.path, paramDesc: String(describing: target), message: "JSON 数据为空！")
            failureCompletion(InternalCode.invalidJSON.rawValue, InternalCode.invalidJSON.codeString)
            return
        }
        successCompletion(json)
        self.printSuccess(path: target.path, paramDesc: String(describing: target), json: json)
    }
    
    
    /// 通过alamofire直接发送请求
    ///
    /// - Parameters:
    ///   - method: 请求方法
    ///   - URLString: 请求路径
    ///   - parameters: 请求参数
    ///   - encoding: 编码方式
    ///   - headers: 请求头信息
    ///   - completionClosure: 请求完成的回调
    public class func alamofireRequest(_ method: HTTPMethod,
                          URLString: URLConvertible,
                          parameters: [String : AnyObject]? = nil,
                          encoding: ParameterEncoding = URLEncoding.default,
                          headers: [String : String]? = nil,
                          _ successCompletion:@escaping JCRequstSuccessCompletion,
                          _ failureCompletion:@escaping JCRequstFailureCompletion){
        
        
        //检查网络
        guard let manager = NetworkReachabilityManager() , manager.isReachable else {
            failureCompletion(InternalCode.networkUnreachable.rawValue, InternalCode.networkUnreachable.codeString)
            return
        }
        NetworkService.alamofireManager
            .request(URLString, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    //检验 json
                    do {
                        let json = try JSON.init(data: data)
                        if json.exists() {
                            successCompletion( json)
                        } else {
                            failureCompletion(InternalCode.invalidJSON.rawValue, InternalCode.invalidJSON.codeString)
                        }
                    } catch {
                        failureCompletion(InternalCode.invalidJSON.rawValue, InternalCode.invalidJSON.codeString)
                    }
                case .failure(_):
                    failureCompletion(InternalCode.alamofireRequestFailed.rawValue, InternalCode.alamofireRequestFailed.codeString)
                }
        }
    }
    
    fileprivate class func printSuccess(path: String, paramDesc: String, json: JSON) {
        printLog("Log Start ==========================================")
        printLog("请求路径：" + path)
        printLog("请求参数：" + paramDesc)
        printLog("服务器返回的数据：" + String(describing: json))
        printLog("Log End ==========================================\n\n")
    }
    
    fileprivate class func printFailure(path: String, paramDesc: String, message: String, json: JSON? = nil) {
        printLog("Log Start ==========================================")
        printLog("请求路径：" + path)
        printLog("请求参数：" + paramDesc)
        printLog("错误信息描述：" + message)
        if let json = json {
            printLog("服务器返回的数据：" + String(describing: json))
        }
        printLog("Log End ==========================================\n\n")
    }
    
    fileprivate class func printNormal(path: String, paramDesc: String, message: String, json: JSON? = nil) {
        printLog("Log Start ==========================================")
        printLog("请求路径：" + path)
        printLog("请求参数：" + paramDesc)
        printLog("状态信息描述：" + message)
        
        if let json = json {
            printLog("服务器返回的数据：" + String(describing: json))
        }
        printLog("Log End ==========================================\n\n")
    }
    
    
    
    fileprivate class func printLog<T>(_ message: T, file: String = #file, line: Int = #line) {
        #if DEBUG || TARGET_IPHONE_SIMULATOR || TARGET_OS_SIMULATOR
            dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss.SSS"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let date = dateFormatter.string(from: Date())
            let fileName = (((file as NSString).lastPathComponent) as NSString).deletingPathExtension
            print("[\(fileName)] [\(line)] [\(date)] \(message)")
        #endif
    }
}
