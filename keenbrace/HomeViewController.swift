//
//  ViewController.swift
//  keenbrace
//
//  Created by a a a a a on 15/9/24.
//  Copyright (c) 2015年 mike公司. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var btnConnectBT: UIButton!
    
    @IBOutlet weak var btnWarmUp: UIButton!
    
    @IBOutlet weak var btnHowToRun: UIButton!
    @IBOutlet weak var btnRelax: UIButton!
    
    @IBOutlet weak var btnStartToRun: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.tabBarItem.title = "34"
        // Do any additional setup after loading the view, typically from a nib.
        
        var image:UIImage
        
        
//        //修改导航条背景色
//        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()

        
        //导航栏 背景图片
        image = UIImage(named: "上栏@1x")!
        self.navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics:.Default)
        

        //导航栏左上角icon
        //create a new button
        image = UIImage(named: "K（未点亮）@1x")!
        let button: UIButton = UIButton(type: UIButtonType.System)
        //set background image for button
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        
        //add function for button
        button.addTarget(self, action: "fbButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        button.frame = CGRectMake(0, 0, 30, 30 )
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        
        
        //链接蓝牙按钮
        
        btnConnectBT.imageEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, 100)  //button image与上、左、下、右的距离。
        image = UIImage(named: "链接智能护膝@1x")!
        btnConnectBT.imageView?.frame = CGRectMake(0, 0, 3, 3)
        
        
  
          //背景图
//        image = UIImage(named: "链接智能护膝按钮（未按）@1x")!
//        btnConnectBT.setBackgroundImage(image, forState: UIControlState.Normal)
//        btnConnectBT.frame = CGRectMake(0, 0, 200, 40)
//       
        //icon 图
//        image = UIImage(named: "链接智能护膝@1x")!
//        var subView:UIImageView
//        subView = UIImageView.init(image: image)
//        subView.frame = CGRectMake(20, 30, 20, 20)
//        btnConnectBT.addSubview(subView)
        
        
    
    }
    
    
    func fbButtonPressed() {
        print("这里应该出发链接蓝牙的页面")
        
        self.performSegueWithIdentifier("segueConnectBlueTooth", sender: self)
    }
    

    @IBAction func btnIcon(sender: AnyObject) {
    }
    
    @IBAction func btnConnect(sender: AnyObject) {
    }
    
    
    @IBAction func btnWarmUp(sender: AnyObject) {
    }
    

    @IBAction func btnHowToRun(sender: AnyObject) {
    }
    
    
    @IBAction func btnRelax(sender: AnyObject) {
    }
    
    @IBAction func btnRun(sender: AnyObject) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

