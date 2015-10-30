//
//  ModUserInfoTableViewController.swift
//  keenbrace
//
//  Created by michaeltam on 15/10/15.
//  Copyright © 2015年 mike公司. All rights reserved.
//

import UIKit

class ModUserInfoTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {


    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var name: UITextField!
//    @IBOutlevareak var gender: UITextField!
    @IBOutlet weak var pickerGender: UIPickerView!
    @IBOutlet weak var pickerBirth: UIDatePicker!

    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var introduction: UITextField!
    var user = NSUserDefaults.standardUserDefaults()
    
    var genderSelection = ["男", "女", "不限"]
    
    
    @IBOutlet weak var avatar: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerGender.delegate = self
        pickerGender.dataSource = self
        

        pickerBirth.datePickerMode = UIDatePickerMode.Date

        navigationBar.frame = CGRectMake(0, 0, 100, 60)
        
        name.text = user.valueForKey("name") as? String
        var row = user.valueForKey("gender") as? NSInteger
        if row == nil {
            row = 2
        }
        pickerGender.selectRow(row!, inComponent: 0, animated: true)
        
        height.text = user.valueForKey("height") as? String
        weight.text = user.valueForKey("weight") as? String
        if (user.valueForKey("avatar") != nil) {
            avatar.image = UIImage(data: user.valueForKey("avatar") as! NSData, scale: 1.0)
        }

//        print(avatar.image)
        
        
        let date = user.valueForKey("birth") as? NSDate
        //日期选择器
        if date != nil {
            pickerBirth.setDate(date!, animated: true)
            pickerBirth.locale = NSLocale(localeIdentifier: "zh_CN")
            
        }
        
        introduction.text = user.valueForKey("name") as? String

        
        
        
//        self.tableView.sectionHeaderHeight = 100
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
     //日期的datePicker
      func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
            return 1
    }
    

     func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return genderSelection.count

        
    }
    
     func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return genderSelection[row]
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            
           launchCamera()
        }
        
    }

    //处理图片，代理逻辑
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
       avatar.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    //触发拍照
    func launchCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.allowsEditing   = true
            
            picker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.On
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front) {
                picker.cameraDevice = UIImagePickerControllerCameraDevice.Front
            }
            self.presentViewController(picker, animated: true, completion: {() ->Void in })
        }
        else {
            print("no camera")
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    @IBAction func save(sender: AnyObject) {
        
        user.setObject(name.text, forKey: "name")
        let row = pickerGender.selectedRowInComponent(0)
        user.setObject(row, forKey: "gender")
        user.setObject(height.text, forKey: "height")
        user.setObject(weight.text, forKey: "weight")
        user.setObject(pickerBirth.date, forKey: "birth")
        
        if (avatar.image != nil) {
            let temp = UIImagePNGRepresentation(avatar.image!) //
            print("save image")
            user.setObject(temp, forKey: "avatar")
            
        }
        
        
        user.setObject(introduction.text, forKey: "introduction")
        user.synchronize()
        
//        print(user.valueForKey("avatar") as! UIImage)
//        self.performSegueWithIdentifier("testt", sender: self)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    @IBAction func cancel(sender: AnyObject) {
        
        print("")
        self.dismissViewControllerAnimated(true, completion: nil)

        
        
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
