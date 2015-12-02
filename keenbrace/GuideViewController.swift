//
//  GuideViewController.swift
//  keenbrace
//
//  Created by michaeltam on 15/10/12.
//  Copyright © 2015年 mike公司. All rights reserved.
//

import UIKit


class GuideViewController: UIViewController, UIWebViewDelegate, UIGestureRecognizerDelegate{
    
    var url:String = ""

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        print(url)

        self.webView.loadRequest(NSURLRequest(URL: NSURL(string:url)!))
        
        let gs:UITapGestureRecognizer = UITapGestureRecognizer()
        gs.numberOfTapsRequired = 1
        gs.delegate = self
        self.view.addGestureRecognizer(gs)
        
        //友盟代码
        UMSocialData.setAppKey("565ea183e0f55a507b002037")
        
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "565ea183e0f55a507b002037", shareText: "words", shareImage: nil, shareToSnsNames: ["UMShareToSina", "UMShareToWechatSession"], delegate: nil)
        
        // Do any additional setup after loading the view.
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
