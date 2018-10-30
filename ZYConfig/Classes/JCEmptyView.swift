//
//  KKEmptyView.swift
//  JGTProject
//
//  Created by ifly on 2017/8/7.
//  Copyright © 2017年 szy. All rights reserved.
//

import UIKit
import SnapKit

typealias JCEmpyAction = (_ refreshBtnTitle:String) -> Void

enum  JCEmpyState{
    case Longing
    case Error
    case Sussuess
    case NullDate
}

class JCEmptyView: UIView {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    fileprivate var jcImgView = UIButton()
    fileprivate var jcTextLbl = UILabel()
    fileprivate var jcActionBtn = UIButton()
    
    
    private var refreshBtnTitle = "重新加载"
    
    /// 重新加载按钮事件
    var jcRefreshAction:JCEmpyAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(jcImgView)
        
//        let tapOne = UITapGestureRecognizer(target: self, action: #selector(btnAction))
//        tapOne.numberOfTapsRequired = 1
//        tapOne.numberOfTouchesRequired = 1
//        self.addGestureRecognizer(tapOne)
        
        jcImgView.setImage(UIImage.init(named: "loading"), for: .normal)
        jcImgView.setImage(UIImage.init(named: "loading"), for: .highlighted)
        
        self.addSubview(jcTextLbl)
        jcTextLbl.textAlignment = .center;
        jcTextLbl.font = UIFont.boldSystemFont(ofSize: 18)
        jcTextLbl.numberOfLines = 0
        jcTextLbl.sizeToFit()
        jcTextLbl.textColor = UIColor.gray
        
        jcActionBtn = UIButton.init(type: .custom)
        jcActionBtn.setTitle(refreshBtnTitle, for: UIControl.State.normal)
        self.addSubview(jcActionBtn)
        jcActionBtn.setTitleColor(UIColor.init(red: 30/255.0, green: 144/255.0, blue: 255/255.0, alpha: 1), for: .normal)
        jcActionBtn.layer.borderWidth = 1;
        jcActionBtn.layer.borderColor = UIColor.init(red: 30/255.0, green: 144/255.0, blue: 255/255.0, alpha: 1).cgColor
        jcActionBtn.layer.cornerRadius = 6
        jcActionBtn.layer.masksToBounds = true
        jcActionBtn.addTarget(self, action: #selector(btnAction), for: UIControl.Event.touchUpInside)
        
        jcImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-100)
            make.size.equalTo(CGSize(width: 120, height: 120))
        }
        
        jcTextLbl.snp.makeConstraints { (make) in
            make.top.equalTo(jcImgView.snp.bottom).offset(5)
            make.left.equalTo(self).offset(40)
            make.right.equalTo(self.snp.right).offset(-40)
//            make.height.equalTo(40)
        }
        
        jcActionBtn.snp.makeConstraints { (make) in
            make.top.equalTo(jcTextLbl.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize.init(width: 200, height: 44))
        }
    }
    
    /// 设置提示类型
    ///
    /// - Parameters:
    ///   - emptyState: 描述类型
    ///   - img: t显示的图片
    ///   - text: 描述文字
    func jcSetEmptyState(_ emptyState:JCEmpyState, img:UIImage?, withText text:String) -> Void {
        
        jcImgView.setImage(img, for: .normal)
        jcImgView.setImage(img, for: .highlighted)
        jcTextLbl.text = text
        
        switch emptyState {
        case .Longing:
            jcActionBtn.isHidden = true
        case .Sussuess:
            jcActionBtn.isHidden = true
        case .Error:
            jcActionBtn.isHidden = false
        case .NullDate:
             jcActionBtn.isHidden = true
        }
    
    }
    
    func jcSetEmptyRefreshBtnTitle(_ title:String) -> Void {
        jcActionBtn.setTitle(title, for: .normal)
        refreshBtnTitle = title
    }
    
    @objc fileprivate func btnAction(){
        if (self.jcRefreshAction != nil) {
            self.jcRefreshAction!(refreshBtnTitle)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
