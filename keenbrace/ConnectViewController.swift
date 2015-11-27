//
//  ConnectViewController.swift
//  keenbrace
//
//  Created by a a a a a on 15/9/24.
//  Copyright (c) 2015年 mike公司. All rights reserved.
//

import UIKit
import CoreBluetooth


class ConnectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CBCentralManagerDelegate, CBPeripheralDelegate{

    @IBOutlet weak var iconBluetooth: UIImageView!
    @IBOutlet weak var txtConnection: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
//    var temp:Array = ["蓝牙1", "蓝牙2"]

    var myCentreralManager:CBCentralManager? = nil
    var peripherals:[CBPeripheral] = []
    var RSSIs:[NSNumber] = []
    var writeCharacteristic: CBCharacteristic!
    var user = NSUserDefaults.standardUserDefaults()

    var peripheralTemp:[CBPeripheral] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refresh")
        
        //蓝牙部分，实例化
        self.myCentreralManager = CBCentralManager(delegate: self, queue: nil)
        
        //先检查上次连接
        if user.valueForKey("peripheralIdentifier") != nil {
            let uuid = NSUUID.init(UUIDString: user.valueForKey("peripheralIdentifier") as! String)
            print("保存在userdefault的蓝牙设备id \(uuid)")
            let knownPeripheral = myCentreralManager?.retrievePeripheralsWithIdentifiers([uuid!])
            
            let temp:String = "FFE4"
            let cbuuid = CBUUID.init(string: temp)
            let service = myCentreralManager?.retrieveConnectedPeripheralsWithServices([cbuuid])
            
            if knownPeripheral != nil {
                for i in knownPeripheral! {
//                    myCentreralManager?.connectPeripheral(i, options: nil)
                }
            }
        }

     }

    
    @IBAction func startRun(sender: AnyObject) {
//        let heartRate: NSString = "5501010101010101"
        let heartRate: NSString = "51 00"
        let dataValue: NSData = heartRate.dataUsingEncoding(NSUTF8StringEncoding)!
        print ("打印字符串\(dataValue)")
        
        var temp:NSData = NSData.init(contentsOfFile: "55")!
        print (temp)
        //写入数据
        self.writeValue("FFE0", characteristicUUID: "FFE4", peripheral: peripheralTemp[0], data: dataValue)
        
    }
    
    
    func centralManagerDidUpdateState(central: CBCentralManager) {

        //这里应该判断手机蓝牙是否开启，

        switch central.state {
        case CBCentralManagerState.Unauthorized:
            print("the app is not authorized to use Bluetooth low energy")
        
        case CBCentralManagerState.PoweredOff:
            print("BlueTooth is currently powerd off")
        
        case CBCentralManagerState.PoweredOn:
            print("BlueTooth is power on and available to use")
            
            //如果在这里，可以触发一个函数调用alert提醒
        default:break
        }
        
        
        startScan()
        
        
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("we found one")
        self.peripherals.append(peripheral)
        self.RSSIs.append(RSSI)
        self.tableView.reloadData()
        print(peripheral.identifier)
        print(RSSI)
        print(self.peripherals.count)
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
        cell.textLabel!.text = peripheral.name
        cell.detailTextLabel!.text = String(RSSI)
//        cell.detailTextLabel!.text =
//        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        //如果已连接的蓝牙设备的NSUUID与表的某行蓝牙id相同，那么修改显示值

                let uuid = user.valueForKey("peripheralIdentifier")
        
                if ( uuid != nil) {
                    let peripheralId = NSUUID.init(UUIDString: uuid as! String)
                    //如果已连接的蓝牙设备的NSUUID与表的某行蓝牙id相同，那么修改显示值
        
                    if peripheral.identifier == peripheralId {
                        cell?.backgroundColor = UIColor.blueColor()
                        cell?.textLabel!.text = (cell?.textLabel!.text)! + " 已连接"
//                        cell.detailTextLabel!.text = String(RSSI) + " \(uuid)"
                    }
                }

        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //连接某个蓝牙设备
        let peripheral = self.peripherals[indexPath.row]
        myCentreralManager?.connectPeripheral(peripheral, options: nil)

//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        let uuid = user.valueForKey("peripheralIdentifier")
//        
//        if ( uuid != nil) {
//            let peripheralId = NSUUID.init(UUIDString: uuid as! String)
//            //如果已连接的蓝牙设备的NSUUID与表的某行蓝牙id相同，那么修改显示值
//
//            if peripheral.identifier == peripheralId {
//                cell?.backgroundColor = UIColor.blueColor()
//                cell?.textLabel!.text = "kkk"                
//            }
        
        


 
 
        
//        if(self.peripheralList.containsObject(self.deviceList.objectAtIndex(indexPath.row))){
//                         self.manager.cancelPeripheralConnection(self.deviceList.objectAtIndex(indexPath.row) as! CBPeripheral)
//                        self.peripheralList.removeObject(self.deviceList.objectAtIndex(indexPath.row))
//                         println("蓝牙已断开！")
//                     }
//        else{
//                         self.manager.connectPeripheral(self.deviceList.objectAtIndex(indexPath.row) as! CBPeripheral, options: nil)
//                         self.peripheralList.addObject(self.deviceList.objectAtIndex(indexPath.row))
//                         println("蓝牙已连接！ \(self.peripheralList.count)")
//                     }
        
    }
    
  
    
    // myself 查看已连接的设备
    
    
    
    
    //连接的结果会回调下面3个函数
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("CentalManagerDelegate didConnectPeripheral")
        print("Connected with \(peripheral.name)")
        print("peripheral identifier \(peripheral.identifier)")
        
        // Stop scanning
        myCentreralManager!.stopScan()
        print("Scanning stopped")
        
        peripheral.delegate  = self
        txtConnection.text = "已连接"
        let uuid = peripheral.identifier.UUIDString
        user.setObject(uuid, forKey: "peripheralIdentifier")
        user.setObject(true, forKey: "peripheralConnected")
        
//        只读取某个服务
        let temp:String = "FEE0"
        let cbuuid = CBUUID.init(string: temp)
        peripheral.discoverServices(nil)
        
        tableView.reloadData()
        
        let service = myCentreralManager?.retrieveConnectedPeripheralsWithServices([cbuuid])
        //如果连接了，上面service是有值的
        
    }
    
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("fail to connect to \(peripheral).\(error!.localizedDescription)")
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("did Disconnect Peripheral")
        user.setObject(false, forKey: "peripheralConnected")

        txtConnection.text = "请连接设备"
        //如何连接断了，这里会触发的。 如果断了，就要想办法重新连接？
//        myCentreralManager?.connectPeripheral(peripheral, options: nil)

        
    }
    
    
    
    //当扫描到service时调用下面回调函数
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        print("didDiscoverService")
        
        if error == nil {
            print(peripheral.services)
            
            for service  in peripheral.services! as [CBService] {
//                service.UUID = CBUUID.
                
                var alert:UIAlertView
                print("service id is \(service.UUID)")
                
//                 5.查询每个service所包含的characteristics
//                 只取 “FFE0” 这个service id
                if service.UUID.UUIDString == "FFE0" {
                    var serviceUUID = [CBUUID(string: "FFE0")]
                    //                peripheral.discoverCharacteristics(serviceUUID, forService: service)
                    peripheral.discoverCharacteristics(nil, forService: service)
                }
//                peripheral.discoverCharacteristics(nil, forService: service)


            }
        }
    }
    
    //5. 回调函数
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if (error != nil){
            print("发现错误的特征：\(error!.localizedDescription)")
            return
        }
        
        //罗列出所有特性，看哪些是notify方式的，哪些是read方式的，哪些是可写入的。
        print("服务UUID：\(service.UUID)")
        
        for  i in service.characteristics! {
            print("characteristics: ",i)
            print(i.UUID.description)
            
            //特征的值被更新，用setNotifyValue:forCharacteristic 方法来订阅特征的值
            switch i.UUID.description {
                //添加获取keenbrace的特征
//                case ""
                case  "FF01":
                print("小米手环特性")
                peripheral.setNotifyValue(true, forCharacteristic: i)
                
                
                case "FFE4" :
                print("keenbrace 特性，设置接收设备发过来的信息")
                peripheral.setNotifyValue(true, forCharacteristic: i)
                
                case "FFE3" :
                print("keenbrace 特性，设备接收手机发来的信息")
//                peripheral.readValueForCharacteristic(i )
                self.writeCharacteristic = i
                
                self.peripheralTemp = []
                self.peripheralTemp.append(peripheral)

                
//                let heartRate: NSString = "0x550x01151113104060"
//                let dataValue: NSData = heartRate.dataUsingEncoding(NSUTF8StringEncoding)!
//                print ("打印字符串\(dataValue)")
//                //写入数据
//                self.writeValue(service.UUID.description, characteristicUUID: i.UUID.description, peripheral: peripheral, data: dataValue)
                
                

                
                case "FFF1":
                    //如果以通知的形式读取数据，则直接发到didUpdateValueForCharacteristic方法处理数据。
                    peripheral.setNotifyValue(true, forCharacteristic: i as CBCharacteristic)
                case "2A37":
                //通知关闭，read方式接受数据。则先发送到didUpdateNotificationStateForCharacteristic方法，再通过readValueForCharacteristic发到didUpdateValueForCharacteristic方法处理数据。
                    peripheral.readValueForCharacteristic(i )
                case "2A38":
                    peripheral.readValueForCharacteristic(i )
                case "Battery Level":
                    peripheral.setNotifyValue(true, forCharacteristic: i )
                
                //... from:http://2goo.info/weblog/detail/232351
                
                case "Manufacturer Name String":
                    peripheral.readValueForCharacteristic( i )
                case "6E400003-B5A3-F393-E0A9-E50E24DCCA9E":
                    peripheral.setNotifyValue(true, forCharacteristic: i )
                
                case "6E400002-B5A3-F393-E0A9-E50E24DCCA9E":
                    peripheral.readValueForCharacteristic(i )
                    self.writeCharacteristic = i 
                    let heartRate: NSString = "ZhuHai XY"
                    let dataValue: NSData = heartRate.dataUsingEncoding(NSUTF8StringEncoding)!
                    //写入数据
                    self.writeValue(service.UUID.description, characteristicUUID: i.UUID.description, peripheral: peripheral, data: dataValue)
            default:
                break
            }
        }
    }
    
    //写入数据
   func writeValue(serviceUUID: String, characteristicUUID: String, peripheral: CBPeripheral!, data: NSData!){
       peripheral.writeValue(data, forCharacteristic: self.writeCharacteristic, type: CBCharacteristicWriteType.WithResponse)
        print("手机向蓝牙发送的数据为:\(data)")
           }
    
    
    
    //6 获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if (error != nil ) {
            print("发送数据错误的特征：\(characteristic.UUID) 错误信息：\(error?.localizedDescription) 错误数据：\(characteristic.value)")
            return
        }
        
        
        switch characteristic.UUID.description {
            
            case "FFE4":
                print("获取keenbrace 发过来的信息")
                print("=\(characteristic.UUID)特征发来的数据是:\(characteristic.value)=")
            
            case "FFE1":
                print("=\(characteristic.UUID)特征发来的数据是:\(characteristic.value)=")
            
            case "2A37":
                         print("=\(characteristic.UUID.description):\(characteristic.value)=")
            
            case "2A38":
                         var dataValue: Int = 0
                         characteristic.value!.getBytes(&dataValue, range:NSRange(location: 0, length: 1))
                         print("2A38的值为:\(dataValue)")
            
            case "Battery Level":       //如果发过来的是Byte值，在Objective-C中直接.getBytes就是Byte数组了，在swift目前就用这个方法处理吧！
                         var batteryLevel: Int = 0
                         characteristic.value!.getBytes(&batteryLevel, range:NSRange(location: 0, length: 1))
                         print("当前为你检测了\(batteryLevel)秒！")
            
            case "Manufacturer Name String":         //如果发过来的是字符串，则用NSData和NSString转换函数
                         let manufacturerName: NSString = NSString(data: characteristic.value!, encoding: NSUTF8StringEncoding)!
                         print("制造商名称为:\(manufacturerName)")
            
            case "6E400003-B5A3-F393-E0A9-E50E24DCCA9E":
                         print("=\(characteristic.UUID)特征发来的数据是:\(characteristic.value)=")
            
            case "6E400002-B5A3-F393-E0A9-E50E24DCCA9E":
                         print("返回的数据是:\(characteristic.value)")
            
            default:
                    break
            
            
        }
        
        
    }
    
    
    
    // 7.这个是接收蓝牙通知，很少用。读取外设数据主要用上面那个方法didUpdateValueForCharacteristic。
    func peripheral(peripheral: CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic, error: NSError?){
             if error != nil {
                         print("更改通知状态错误：\(error!.localizedDescription)")
                     }
        
                 print("收到的特性数据：\(characteristic.value)")
                 //如果它不是传输特性,退出.
         //        if characteristic.UUID.isEqual(kCharacteristicUUID) {
         //            return
         //        }
                 //开始通知
                 if characteristic.isNotifying {
                         print("开始的通知\(characteristic)")
                         peripheral.readValueForCharacteristic(characteristic)
                     }else{
                         //通知已停止
                         //所有外设断开
                         print("通知\(characteristic)已停止设备断开连接")
                         self.myCentreralManager!.cancelPeripheralConnection(peripheral)
                     }
             }
    

         //用于检测中心向外设写数据是否成功
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
                 if(error != nil){
                         print("发送数据失败!error信息:\(error)")
                     }else{
                         print("发送数据成功\(characteristic)")
                     }
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
