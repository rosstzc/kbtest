//
//  GuideViewController.swift
//  keenbrace
//
//  Created by michaeltam on 15/10/12.
//  Copyright © 2015年 mike公司. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController, UIWebViewDelegate{
    
    var url:String = ""

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        print(url)

        self.webView.loadRequest(NSURLRequest(URL: NSURL(string:url)!))

        // Do any additional setup after loading the view.
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        NSLog("error\(error)")
    }

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
