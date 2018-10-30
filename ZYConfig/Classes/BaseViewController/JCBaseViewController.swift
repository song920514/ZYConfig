//
//  JCBaseViewController.swift
//  JGTProject
//
//  Created by ifly on 2017/7/17.
//  Copyright © 2017年 szy. All rights reserved.
//

import UIKit

class JCBaseViewController: UIViewController {
    
   fileprivate var empView = JCEmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        self.empView = JCEmptyView(frame: self.view.frame)
        self.view.addSubview(empView)
        self.empView.isHidden = true

        //        DispatchQueue.global().async {
        //            // code
        //            DispatchQueue.main.async {
        //                // 主线程中'
        //            }
        //        }
    }
  
    /// 正在加载显示的背景
    ///
    /// - Parameter dataView: y隐藏的view
    func jcShowLoadingView(_ loading:String?,hiddenView dataView:UIView) -> Void {
        self.empView.isHidden = false
        dataView.isHidden = true
        if loading != nil {
             empView.jcSetEmptyState(JCEmpyState.Longing, img: UIImage.init(named: "loading"), withText: loading!)
        }else{
             empView.jcSetEmptyState(JCEmpyState.Longing, img: UIImage.init(named: "loading"), withText: "正在加载数据....")
        }
    }
    
    /// 加载失败显示的背景
    ///
    /// - Parameter dataView: 隐藏的view
    func jcShowErrorView(hiddenView dataView:UIView,nullString:String, isShow:Bool) -> Void {
        
        self.empView.isHidden = false
        dataView.isHidden = true
        if isShow == true {
            empView.jcSetEmptyState(JCEmpyState.Error, img: UIImage.init(named: "loading"), withText: nullString)
        }else{
             empView.jcSetEmptyState(JCEmpyState.NullDate, img: UIImage.init(named: "loading"), withText: nullString)
        }
        
    }
    /// 数据加载成功
    ///
    /// - Parameter dataView: 显示的view
    func jcShowSuccessView(_ dataView:UIView) -> Void {
        self.empView.isHidden = true
        dataView.isHidden = false
    }
    ///  数据加载button 加载方法
    func jcEmpViewRefreshCompletion(_ completion: @escaping (_ btnTilte:String)->Void) -> Void {
        
        self.empView.jcRefreshAction = {
            if $0 == "立即登录" {
                self.present(JCLogInViewController(), animated: true, completion: nil)
                return
            }
            completion($0)
        }
    }
    
    func jcSetEmpViewRefreshBtnTitel(_ title:String) -> Void {
        self.empView.jcSetEmptyRefreshBtnTitle(title)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //是否自动旋转,返回true可以自动旋转
    override var shouldAutorotate: Bool{
        return true
    }
    //返回支持的方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    //由模态推出的视图控制器 优先支持的屏幕方向
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
