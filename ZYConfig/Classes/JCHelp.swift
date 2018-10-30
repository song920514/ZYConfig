//
//  JCHellp.swift
//  JCTuChao-ios
//
//  Created by ifly on 17/9/2018.
//  Copyright © 2018 Ismail. All rights reserved.
//

import Foundation

open class JCHelp {
    
  //MARK: -时间转时间戳函数
   public static func jcTimeToTimeStamp(time: String) -> Double {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let last = dfmatter.date(from: time)
        let timeStamp = last?.timeIntervalSince1970
        return timeStamp!
    }
    
    //MARK: -根据后台时间戳返回几分钟前，几小时前，几天前
    public static func jcUpdateTimeToCurrennTime(time: String) -> String {
        
        if time.isEmpty {
            return " "
        }
        
        let timeStamp = self.jcTimeToTimeStamp(time: time)
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 7 {
            return "\(days)天前"
        }
        //不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="MM-dd HH:mm"
        return dfmatter.string(from: date as Date)
    }
    ///  获取几天前的日期
    public static func jcGetDayAgo(_ dayNum:TimeInterval) -> String{
        
        let lastDay = Date.init(timeInterval: (-24*60*60)*dayNum, since: Date.init())
        let fmt = DateFormatter.init()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt.string(from: lastDay)
    }
    

}
