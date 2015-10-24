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
    @IBOutlet weak var introduction: UILabel!
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var iconMale: UIImageView!
    @IBOutlet weak var iconFemale: UIImageView!
    
    
    var user = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "背景图@1x")!)
        // Do any additional setup after loading the view.
        
        name.text = user.valueForKey("name") as? String
        height.text = user.valueForKey("height") as? String
        weight.text = user.valueForKey("weight") as? String
        //通过格式转换呈现生日日期
        let birthDate:NSDate  = (user.valueForKey("birth") as? NSDate)!
        let dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let dateStr = dformatter.stringFromDate(birthDate)
        birth.text = dateStr
        introduction.text = user.valueForKey("name") as? String
        
    
        
        avatar.image = user.valueForKey("avatar") as? UIImage
        
        let row = user.valueForKey("gender") as! NSInteger
        if row == 0 {
            print("male")
            iconMale.image = UIImage(named: "男（按下）")
            iconFemale.image = UIImage(named: "Girl 未按")

            
        }else if row == 1 {
            print("female")
            iconMale.image = UIImage(named: "男（未按）")
            iconFemale.image = UIImage(named: "Girl（按下）")

        }else if row == 2 {
            print("none")
            iconMale.image = UIImage(named: "男（未按）")
            iconFemale.image = UIImage(named: "Girl 未按")
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
