//
//  ConnectViewController.swift
//  keenbrace
//
//  Created by a a a a a on 15/9/24.
//  Copyright (c) 2015年 mike公司. All rights reserved.
//

import UIKit
import CoreBluetooth


class ConnectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CBCentralManagerDelegate{

    @IBOutlet weak var iconBluetooth: UIImageView!
    @IBOutlet weak var txtConnection: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
//    var temp:Array = ["蓝牙1", "蓝牙2"]

    var myCentreralManager:CBCentralManager? = nil
    var peripherals:[CBPeripheral] = []
    var RSSIs:[NSNumber] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refresh")
        
        //蓝牙部分
        self.myCentreralManager = CBCentralManager(delegate: self, queue: nil)
        
     }

    
    func centralManagerDidUpdateState(central: CBCentralManager) {

        switch central.state {
        case CBCentralManagerState.Unauthorized:
            print("the app is not authorized to use Bluetooth low energy")
        
        case CBCentralManagerState.PoweredOff:
            print("BlueTooth is currently powerd off")
        
        case CBCentralManagerState.PoweredOn:
            print("BlueTooth is power on and available to use")

        default:break
        }
        
        
        startScan()
        
        
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("we found one")
        self.peripherals.append(peripheral)
        self.RSSIs.append(RSSI)
        self.tableView.reloadData()
        print(RSSI)
    }
    
    
    
    @IBAction func refresh() {

        startScan()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "刷新中", style: .Plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.enabled = false
        
    }
    
    func startScan() {
        self.peripherals = []
        self.RSSIs = []
        self.myCentreralManager?.scanForPeripheralsWithServices(nil, options: nil)
        let timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "stopScan", userInfo: nil, repeats: false)
    }
    
    func stopScan() {
        self.myCentreralManager?.stopScan()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refresh")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peripherals.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        let peripheral = self.peripherals[indexPath.row]
        let RSSI = self.RSSIs[indexPath.row]
        cell.textLabel!.text = peripheral.identifier.UUIDString
        cell.detailTextLabel!.text = String(RSSI)
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
