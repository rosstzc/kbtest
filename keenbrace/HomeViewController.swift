//
//  ViewController.swift
//  keenbrace
//
//  Created by a a a a a on 15/9/24.
//  Copyright (c) 2015年 mike公司. All rights reserved.
//

import UIKit
import CoreBluetooth
//import
import Charts


class HomeViewController: UIViewController{

    
    @IBOutlet weak var btnConnectBT: UIButton!
    
    @IBOutlet weak var btnWarmUp: UIButton!
    
    @IBOutlet weak var btnHowToRun: UIButton!
    @IBOutlet weak var btnRelax: UIButton!
    
    @IBOutlet weak var btnStartToRun: UIButton!
    

    //处理运动指导内容
    
    var guideArray:NSMutableArray = []
    var guideTitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.tabBarItem.title = "34"
        // Do any additional setup after loading the view, typically from a nib.
        
        var image:UIImage
//        var subView:UIImageView

        
        
        
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

//                btnConnectBT.setTitle("智能", forState: .Normal) // 文字内容
//                btnConnectBT.titleLabel?.font = UIFont.systemFontOfSize(12)  //字体大小
        //不给力，实现不了图片size更换
//        image = UIImage(named: "发现（按下）@1x")!
//        btnConnectBT.setImage(image, forState:.Normal )
//        btnConnectBT.imageView?.frame = CGRectMake(100, 100, 100, 100)
        

//
//        链接蓝牙按钮内的icon图片
//        image = UIImage(named: "链接智能护膝@1x")!
//        subView = UIImageView.init(image: image)
//        subView.frame = CGRectMake(10, 24, 40, 40)
//        btnConnectBT.addSubview(subView)
//        
        
        
////        背景图
//                image = UIImage(named: "链接智能护膝按钮（未按）@1x")!
//                btnConnectBT.setBackgroundImage(image, forState: UIControlState.Normal)
//                btnConnectBT.frame = CGRectMake(0, 0, 200, 40)
//                btnConnectBT.imageEdgeInsets =  UIEdgeInsetsMake(0, 0, 100, 100)  //button image与上、左、下、右的距离。
//        
//     
    
        // 运动热身按钮的图片
//        image = UIImage(named: "运动前热身@1x")!
//        subView = UIImageView.init(image: image)
//        subView.frame = CGRectMake(10, 10, 50, 50)
//        btnWarmUp.addSubview(subView)
        
//        image = UIImage(named: "箭头@1x")!
//        subView = UIImageView.init(image: image)
//        subView.frame = CGRectMake(240, 23, 14, 24)
//        btnWarmUp.addSubview(subView)
        
//        image = UIImage(named: "首页内容框@1x")!

//        btnWarmUp.setBackgroundImage(image, forState: UIControlState.Normal)
//        btnWarmUp.frame = CGRectMake(3, 3, 200, 200)
        
        
        // 修改tab上图片过大的问题
//        image = UIImage(named: "home@1x")!
//        image.
        

        //在这类处理tabbar
//        var tabBarController = self.
        
    
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
        
        
        guideTitle = "跑步前如何热身？"
        guideArray = [
            ["跑步前的拉伸动作（图片简版）","https://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207981177&idx=1&sn=8c5797a1a326800e92b3a11b8f9c3daf#rd",1],
            ["跑步前的拉伸运动（GIF动图）","https://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207981177&idx=2&sn=bd95c1c98a5b87872e3998bdf0f16cfd#rd",1],
            ["跑步前热身动作（视频）","https://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207981177&idx=3&sn=bb80b7bfa24c3cb9bc8c12c422d4cb91#rd",1],
            ["健身前要记得做热身运动！（动图）","https://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207981177&idx=4&sn=d8bf4ba156a4c7d1f422f6c09e0a513c#rd",1],
        ]

        self.performSegueWithIdentifier("segueToGuide", sender: self)
    }
    

    @IBAction func btnHowToRun(sender: AnyObject) {
        
        guideTitle = "如何正确地跑步？"
        guideArray = [
   
        ]
        self.performSegueWithIdentifier("segueToGuide", sender: self)

    }
    
    
    @IBAction func btnRelax(sender: AnyObject) {
        
        guideTitle = "运动后如何拉伸？"
        guideArray = [

        ]
        self.performSegueWithIdentifier("segueToGuide", sender: self)

    }
    
    @IBAction func btnRun(sender: AnyObject) {
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueToGuide" {
            let nextVC = segue.destinationViewController as! GuideListTableViewController
            nextVC.guideArray = guideArray
            nextVC.guideTitle = guideTitle  
            
        }
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

