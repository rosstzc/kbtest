//
//  ViewController.swift
//  keenbrace
//
//  Created by a a a a a on 15/9/24.
//  Copyright (c) 2015年 mike公司. All rights reserved.
//

import UIKit
import CoreData
import Charts

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChartViewDelegate   {
    
    var runs:[History] = []
//    var run:History? = nil

    @IBOutlet weak var runTotalDistance: UILabel!
    @IBOutlet weak var runCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var barChartView: BarChartView!
    var months:[String]!
    var dates:[String]! = []

    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        barChartView.delegate = self
        super.viewDidLoad()
//        self.hidesBottomBarWhenPushed = true   //隐藏低栏

        
        self.title = "运动历史"
        //导航栏 背景图片
        let image = UIImage(named: "上栏@1x")!
        self.navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics:.Default)
        
        
        //录入调试数据
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        let run = NSEntityDescription.insertNewObjectForEntityForName("History", inManagedObjectContext: context) as! History
        run.cadence = "160"
        run.date = NSDate()
        run.distance = "100"
        run.score = "80"
        run.speed = "5:30"
        run.time = "10:20:00"
        
        do {
            try context.save()
            
            //测试lean cloud
            let history:AVObject = AVObject(className: "history")
            history.setObject("1111", forKey: "userid")
            history.setObject(run.cadence, forKey: "cadence")
            history.setObject(run.distance, forKey: "distance")
            history.setObject(run.score, forKey: "score")
            history.setObject(run.speed, forKey: "speed")
            history.setObject(run.time, forKey: "time")
            history.setObject(run.date, forKey: "date")
            let uuid  = NSUUID().UUIDString
            history.setObject(uuid , forKey: "historyid")
//            history.save()
            
            //后台保存
            history.saveInBackgroundWithBlock({(succeeded:Bool, error:NSError?)  in
                if ((error) == nil) {
                    print("成功")
                    print(succeeded)
                }
                else {
                    print("失败")
                }
            })

            
            //
            
            

        } catch {
            print(error)
        }
        

        //从coredata读取数据
        let request =  NSFetchRequest(entityName: "History")
        self.runs = (try! context.executeFetchRequest(request)) as! [History]
        print(runs.count)
        
        
        runCount.text = String(runs.count)
        var distance:Int  = 0
        var scores:[Double] = []
        var date:String
        for i in runs {
            distance = distance + Int(i.distance!)!
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM月dd日 HH:mm"
            date = dateFormatter.stringFromDate(i.date!)
            print(date)
            dates.append(date)
            
            scores.append(Double(i.score!)!)
        }
        runTotalDistance.text = String(distance)
        
        //倒序重排
        dates = dates.reverse()
        scores = scores.reverse()
        
        setChart(dates, values: scores)
        

        
        //评价图表模块
//        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec","ree", "eee"]
//        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0, 6.0, 9.0]

        
//        setChart(months, values: unitsSold)
    
    }
    
    
    
    func setChart(dataPoints:[String], values:[Double]) {
        barChartView.noDataText = "还没有运动记录"
        var dataEntiries: [BarChartDataEntry] = []
        
        
        for i in 0..<dataPoints.count  {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntiries.append(dataEntry)
        }
        
        let chartDataSett = BarChartDataSet(yVals: dataEntiries, label: "运动评价")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSett)
        barChartView.data = chartData
        
        //动态效果
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration:2.0, easingOption:.EaseInBounce  )
        
        
        barChartView.setVisibleXRangeMaximum(8)
        //y轴的最大值
        barChartView.leftAxis.customAxisMax = 100
        barChartView.rightAxis.customAxisMax = 100
        
        
        
    }
    
    //点击某值
//    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
//        print("\(entry.value) in \(months[entry.xIndex])")
//    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        let request =  NSFetchRequest(entityName: "History")
        self.runs = (try! context.executeFetchRequest(request)) as! [History]
        
        let sortedResults = runs.sort({
            $0.date!.compare($1.date!) == NSComparisonResult.OrderedDescending
        })
        runs = sortedResults
        print(runs.count)
        return runs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        }
        let run = runs[indexPath.row]
        
        let score = cell?.viewWithTag(10) as! UILabel
        let cadence = cell?.viewWithTag(11) as! UILabel
        let distance = cell?.viewWithTag(12) as! UILabel
        let time = cell?.viewWithTag(13) as! UILabel
        let date = cell!.viewWithTag(14) as! UILabel

        score.text = run.score
        cadence.text = run.cadence
        distance.text = run.distance
        time.text = run.time
        date.text = date2(run.date!)
//
        return cell!
    }
    
    
    func date2(date1:NSDate) -> String {
    
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        let date2 = dateFormatter.stringFromDate(date1)
        return date2
        
    }
    
    func dateFromString(dataStr: String) -> NSDate? {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let date = dateFormatter.dateFromString(dataStr)
        return date
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
