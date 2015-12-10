//
//  GuideViewController.swift
//  keenbrace
//
//  Created by michaeltam on 15/10/12.
//  Copyright © 2015年 mike公司. All rights reserved.
//

import UIKit
//#import <UMSocialSinaSSOHandler.>


class GuideViewController: UIViewController, UIWebViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate{
    
    var url:String = ""
    var pageTitle:String = ""

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        print(url)

        self.webView.loadRequest(NSURLRequest(URL: NSURL(string:url)!))
        
        
        // 未实行（想实现点击保存图片）
        let gs:UITapGestureRecognizer = UITapGestureRecognizer()
        gs.numberOfTapsRequired = 1
        gs.delegate = self
        self.view.addGestureRecognizer(gs)
        

        
        //友盟代码
//        UMSocialData.setAppKey("565ea183e0f55a507b002037")
     
//        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "565ea183e0f55a507b002037", shareText: "words", shareImage: nil, shareToSnsNames: [UMShareToSina, UMShareToTencent,UMShareToQzone,UMShareToRenren,UMShareToWechatSession, UMShareToWechatTimeline], delegate: nil)
//        
        //微信
//        UMSocialWechatHandler.setWXAppId(<#T##app_Id: String!##String!#>, appSecret: <#T##String!#>, url: <#T##String!#>)
    
        //微博
//        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("3723943926", redirectURL: "http://sns.whalecloud.com/sina2/callback")

   
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func shareBtn(sender: AnyObject) {
        
        let msg:OSMessage = OSMessage()
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let action1:UIAlertAction = UIAlertAction(title: "分享到朋友圈", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            
//            //文本
//            msg.title = "朋友圈"

            
//            //图片
//            msg.image = UIImage(named: "运动后放松@1x")
//            msg.thumbnail = UIImage(named: "运动后放松@1x")
//            
            //链接
            msg.title = "朋友圈"
            msg.link = self.url
            msg.image = UIImage(named: "运动后放松@1x")
            
            OpenShare.shareToWeixinTimeline(msg, success: {message in print("成功")}, fail: {message in print("失败")})
        })
        
        let action2:UIAlertAction = UIAlertAction(title: "分享到微博", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            msg.title = self.pageTitle + " " + self.url
            msg.image = UIImage(named: "运动后放松@1x")
            OpenShare.shareToWeibo(msg, success: {message in print("成功")}, fail: {message in print("失败")})
        })
        
        
        //测试 微信登录
        let action3:UIAlertAction = UIAlertAction(title: "测试微信登录", style: UIAlertActionStyle.Default, handler: {(action) -> Void in

            
            //login scope: @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";//,post_timeline,sns
            OpenShare.WeixinAuth("snsapi_userinfo", success: {
                message  in print("成功")
                //成功登录后，获取到信息，然后进行处理. （因为不是自己app，还未完整测试）
                let name = (message[0]?.valueForKey("state"))! as! String
                let weixinUid = (message[0]?.valueForKey("code"))! as! String
                print(name)
                print(weixinUid)
                
                }, fail: {
                    message in print("失败")
            
            } )
        })
        
        
        //测试 微博登录
//        let action4:UIAlertAction = UIAlertAction(title: "测试微博登录", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
//            
//            OpenShare.WeiboAuth("all", redirectURI: "http:", success: {
//                message  in print("成功")
//                //成功登录后，获取到信息，然后进行处理. （因为不是自己app，还未完整测试）
//                }, fail: {
//                    message in print("失败")
//            } )
//        })
        
 
        let action5:UIAlertAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil )
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
//        actionSheet.addAction(action4)
        actionSheet.addAction(action5)

        presentViewController(actionSheet, animated: true, completion: nil)
    }

    
    
    @IBAction func test(sender: AnyObject) {
        let msg:OSMessage = OSMessage()
        //发给微信朋友
//        OpenShare.shareToWeixinSession(msg, success: {message in print("成功")}, fail: {message in print("失败")})
        
        //微信朋友圈
        msg.title = "这是标题"
//      msg.link = "http://baidu.com"
//      msg.image = UIImage(named: "运动后放松@1x")
        OpenShare.shareToWeixinTimeline(msg, success: {message in print("成功")}, fail: {message in print("失败")})
        
        //微信登录 （需要认证）
        
        
        //微博分享
//        msg.title = "这是微博分享"
//        msg.image = UIImage(named: "运动后放松@1x")
//        msg.link = "http://baidu.com"
//        OpenShare.shareToWeibo(msg, success: {message in print("成功")}, fail: {message in print("失败")})
//        
        
        //QQ分享
        msg.title = "这是QQ分享"
//        msg.image = UIImage(named: "运动后放松@1x")
//        msg.link = "http://baidu.com"
//        OpenShare.shareToQQZone(msg, success: {message in print("成功")}, fail: {message in print("失败")})
//        OpenShare.shareToQQFriends(msg, success: {message in print("成功")}, fail: {message in print("失败")})
//        OpenShare.shareToQQFavorites(msg, success: {message in print("成功")}, fail: {message in print("失败")})
    }
    

    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        NSLog("error\(error)")
    }
    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//        <#code#>
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
