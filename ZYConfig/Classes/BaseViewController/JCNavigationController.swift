//
//  JFNavigationController.swift
//  BaoKanIOS
//
//  Created by jianfeng on 15/12/20.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

import UIKit

class JCNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
//        navigationBar.barTintColor = JC_MAIN_COLOR
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)
        ]
        
    }
    
    
    /**
     拦截push操作
     
     - parameter viewController: 即将压入栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let backIetm = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
        backIetm.tintColor = UIColor.white
        viewController.navigationItem.backBarButtonItem = backIetm;

        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    
    //    MARK: 屏幕的旋转处理
    //是否自动旋转,返回true可以自动旋转
    override var shouldAutorotate: Bool{
        return self.viewControllers.last!.shouldAutorotate
    }
    //返回支持的方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return self.viewControllers.last!.supportedInterfaceOrientations
    }
    //由模态推出的视图控制器 优先支持的屏幕方向
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return self.viewControllers.last!.preferredInterfaceOrientationForPresentation
    }
    
}
