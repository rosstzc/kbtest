//
//  UserInfoViewController.swift
//  keenbrace
//
//  Created by michaeltam on 15/10/13.
//  Copyright © 2015年 mike公司. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var height: UILabel!

    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var introduce: UITextView!
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var iconMale: UIImageView!
    @IBOutlet weak var iconFemale: UIImageView!
    
    
    var user = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true   //隐藏低栏


        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "背景图@1x")!)
        // Do any additional setup after loading the view.
        
        //初始化一下用户资料
        if user.valueForKey("name") == nil {
            user.setObject("", forKey: "name")
        }
        if user.valueForKey("height") == nil {
            user.setObject("", forKey: "height")
        }
        if user.valueForKey("weight") == nil {
            user.setObject("", forKey: "weight")
        }
        if user.valueForKey("gender") == nil {
            user.setObject("", forKey: "gender")
        }

        
        
        name.text = user.valueForKey("name") as? String
        height.text = (user.valueForKey("height") as? String)! + "cm"
        weight.text = (user.valueForKey("weight") as? String)! + "kg"
        birth.text = user.valueForKey("birth") as? String
        introduce.text =  user.valueForKey("introduce") as? String
        introduce.editable = false
        
        let temp = user.valueForKey("avatar") as? NSData
        if temp != nil {
            avatar.image = UIImage.init(data: temp!)
            avatar.clipsToBounds = true
            avatar.layer.cornerRadius = avatar.frame.size.width / 2
            avatar.clipsToBounds = true
        }

        
        if let row = user.valueForKey("gender") as? String{
            
            if row == "男" {
                print("male")
                iconMale.image = UIImage(named: "男（按下）")
                iconFemale.image = UIImage(named: "Girl 未按")
                
                
            }else if row == "女" {
                print("female")
                iconMale.image = UIImage(named: "男（未按）")
                iconFemale.image = UIImage(named: "Girl（按下）")
                
            }else if row == "不限" {
                print("none")
                iconMale.image = UIImage(named: "男（未按）")
                iconFemale.image = UIImage(named: "Girl 未按")
            }else {
                iconMale.image = UIImage(named: "男（未按）")
                iconFemale.image = UIImage(named: "Girl 未按")
                
            }
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sugue:UIStoryboardSegue) {
        print("close")
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
    

    override func viewWillAppear(animated: Bool) {
        print("view will appear")
        self.viewDidLoad()
        
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
