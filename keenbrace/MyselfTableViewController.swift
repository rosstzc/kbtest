//
//  MyselfTableViewController.swift
//  keenbrace
//
//  Created by michaeltam on 15/10/13.
//  Copyright © 2015年 mike公司. All rights reserved.
//

import UIKit

class MyselfTableViewController: UITableViewController {

    @IBOutlet weak var cellInfo: UITableViewCell!
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var txtUserName: UILabel!
    
    @IBOutlet weak var txtGender: UILabel!
    
    @IBOutlet weak var imageGender: UIImageView!
    
    var user = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let avatar = user.valueForKey("avatar") as? UIImage
        if avatar !== nil {
            imageUser.image = avatar
        }
        
        
        
        let row = user.valueForKey("gender") as? NSInteger
        if row == 0 {
            imageGender.image = UIImage(named: "男性@1x")
            txtGender.text = "男"
        } else if row == 1 {
            imageGender.image = UIImage(named: "女性@1x")
            txtGender.text = "女"

        }else if row  == 2 {
            imageGender.image = UIImage(named: "")
            txtGender.text = ""

            
        }

        self.hidesBottomBarWhenPushed = true   //隐藏低栏

    }
    
    override func viewWillAppear(animated: Bool) {
        viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
//
//
//        return cell
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
