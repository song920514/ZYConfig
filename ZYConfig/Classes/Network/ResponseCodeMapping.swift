//
//  ResponseCodeMapping.swift
//  HFSTeacher
//  所有服务的状态码映射
//  Created by LuoCangjian on 2018/5/19.
//  Copyright © 2018年 yunxiao. All rights reserved.
//

import Foundation
import Moya

protocol ResponseCodeProtocol {
    var codeString: String {get}
}
/// 网络框架内容错误描述
public enum InternalCode: Int, ResponseCodeProtocol {
    case unKnown                        = 8001  //未知错误
    case invalidJSON                    = 8002  //Json无效
    case networkUnreachable             = 8003  //无网络
    case alamofireRequestFailed         = 8004  //Alamofire 请求失败
    case imageMapping                   = 8005  //将数据映射为图片失败
    case jsonMapping                    = 8006  //将数据映射为JSON失败
    case stringMapping                  = 8007  //将数据映射为String失败
    case objectMapping                  = 8008  //将数据映射到可解码对象失败
    case statusCode                     = 8009  //状态码不在给定范围内
    case requestMapping                 = 8010  //未能将端点映射到URL请求
    case encodableMapping               = 8011  //无法将可编码对象编码为数据
    case parameterEncoding              = 8012  //未能为URL请求编码参数
    case systemUnderMaintenance         = 8013  //服务器维护中，请稍后重试，如有疑问请联系客服

    var codeString: String {
        switch self {
        case .unKnown:                  return "请求错误，但无对应状态码"
        case .invalidJSON:              return "json数据无效"
        case .networkUnreachable:       return "无网络链接"
        case .alamofireRequestFailed:   return "Alamofire请求失败"
        case .imageMapping:             return "将数据映射为图片失败"
        case .jsonMapping:              return "将数据映射为JSON失败"
        case .stringMapping:            return "将数据映射为String失败"
        case .objectMapping:            return "将数据映射到可解码对象失败"
        case .statusCode:               return "状态码不在给定范围内"
        case .requestMapping:           return "未能将端点映射到URL请求"
        case .encodableMapping:         return "无法将可编码对象编码为数据"
        case .parameterEncoding:        return "未能为URL请求编码参数"
        case .systemUnderMaintenance:   return "服务器维护中，请稍后重试，如有疑问请联系客服"
        }
    }
}

class ResponseStatusMessage {    
    /// Moya错误信息转换为好分数错误信息
    ///
    /// - Parameter error: moya错误信息
    /// - Returns: 好分数错误码
    public class func moyaError2InternalError(_ error: MoyaError) -> InternalCode {
        switch error {
        case .imageMapping(_):
            return InternalCode.imageMapping
        case .jsonMapping(_):
            return InternalCode.jsonMapping
        case .stringMapping(_):
            return InternalCode.stringMapping
        case .objectMapping(_, _):
            return InternalCode.objectMapping
        case .statusCode(_):
            return InternalCode.statusCode
        case .requestMapping:
            return InternalCode.requestMapping
        case .encodableMapping(_):
            return InternalCode.encodableMapping
        case .parameterEncoding(_):
            return InternalCode.parameterEncoding
        case .underlying(_, _):
            return InternalCode.alamofireRequestFailed
        }
    }
}
