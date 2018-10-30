//
//  RequestLoadingPlugin.swift
//  HFSTeacher
//
//  Created by LuoCangjian on 2018/5/21.
//  Copyright © 2018年 yunxiao. All rights reserved.
//

import Foundation
import Moya
import Result
import PKHUD

final class RequestLoadingPlugin: PluginType {
    
    public var isShowLoading: Bool = false

    public init(isShowLoading: Bool = false) {
        self.isShowLoading = isShowLoading
    }
    
    //开始发起请求
    func willSend(_ request: RequestType, target: TargetType) {
        //显示loading
        if isShowLoading {
            HUD.show(HUDContentType.progress)
        }
    }
    
    //收到请求
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        //隐藏loading
        if isShowLoading {
            HUD.hide()
        }
    }
}
