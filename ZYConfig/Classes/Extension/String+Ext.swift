//
//  String+Ext.swift
//  JCTuChao-ios
//
//  Created by ifly on 20/9/2018.
//  Copyright © 2018 Ismail. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto // MD5 用到

extension String {
    
    /// 计算字符串宽度
    public func jcWidthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    /// 计算字符串宽度
    public func jcWidthForComment2(fontSize: CGFloat) -> CGFloat{
        
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect1 = NSString.init(string: self).size(withAttributes: [NSAttributedString.Key.font: font])
        return ceil(rect1.width)
    }
    /// 计算字符串高度
    public func jcHeightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
     /// 计算字符串高度
    public func jcHeightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }

    ///  使用正则表达式替换字符
    public func jcPregReplace(pattern: String, with: String,options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    /// md5 加密
    public func md5() -> String {
        let cStr = self.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    
    //MARK: - sha1 加密
    public func sha1() -> String {
        //UnsafeRawPointer
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        
        let newData = NSData.init(data: data)
        CC_SHA1(newData.bytes, CC_LONG(data.count), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output as String
    }
    
}
