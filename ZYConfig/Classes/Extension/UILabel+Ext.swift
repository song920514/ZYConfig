//
//  UILabel+Ext.swift
//  JCTuChao-ios
//
//  Created by ifly on 17/9/2018.
//  Copyright © 2018 Ismail. All rights reserved.
//

import Foundation
import UIKit


extension UILabel{
    
   public static func jcCustem(_ font:UIFont, textColor:UIColor, text:String) ->UILabel{
        let jcLbl = UILabel()
        jcLbl.font = font
        jcLbl.textColor = textColor
        jcLbl.text = text
        return jcLbl
    }
    
    
    
}
