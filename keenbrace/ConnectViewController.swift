//
//  ConnectViewController.swift
//  keenbrace
//
//  Created by a a a a a on 15/9/24.
//  Copyright (c) 2015年 mike公司. All rights reserved.
//

import UIKit



class ConnectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var iconBluetooth: UIImageView!
    @IBOutlet weak var txtConnection: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var temp:Array = ["蓝牙1", "蓝牙2"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        cell.textLabel!.text = temp[indexPath.row]
        cell.detailTextLabel?.text = temp[indexPath.row]
//        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
