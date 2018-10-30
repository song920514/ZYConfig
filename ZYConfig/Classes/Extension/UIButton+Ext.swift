//
//  UIButton+Ext.swift
//  JCTuChao-ios
//
//  Created by ifly on 13/9/2018.
//  Copyright © 2018 Ismail. All rights reserved.
//

import Foundation
import UIKit


extension UIButton{
    
    public class  func jcCustemRadiusbutton(_ title:String,tager:AnyObject,action:Selector) -> UIButton {
        
        let cutemBtn = UIButton(type: .custom)
        cutemBtn.setTitle(title, for: .normal)
        cutemBtn.setTitleColor(UIColor.white, for: .normal)
        cutemBtn.backgroundColor = UIColor.blue
        cutemBtn.layer.borderColor = UIColor.blue.cgColor
        cutemBtn.layer.masksToBounds = true
        cutemBtn.layer.cornerRadius = 5.0;
        cutemBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cutemBtn.addTarget(tager, action:action, for: .touchUpInside)
        
        return cutemBtn
        
    }
    
   public class func jcCustemButton(_ tilte:String,titleColor:UIColor,titleFont:Float ,backColor: UIColor,tager:AnyObject,action:Selector,isCorRadiusl:Bool) -> UIButton {
        
        let cutemBtn = UIButton(type: .custom)
        cutemBtn.backgroundColor = backColor
        cutemBtn.setTitle(tilte, for: .normal)
        cutemBtn.setTitleColor(titleColor, for: .normal)
        
        if isCorRadiusl==true {
            cutemBtn.layer.borderColor = titleColor.cgColor
            cutemBtn.layer.masksToBounds = true
            cutemBtn.layer.cornerRadius = 5.0
            cutemBtn.layer.borderWidth = 1
        }
        cutemBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(titleFont))
        cutemBtn.addTarget(tager, action: action, for: .touchUpInside)
        return cutemBtn
    }
    
}

