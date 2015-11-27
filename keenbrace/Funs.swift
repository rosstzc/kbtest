//
//  Funs.swift
//  keenbrace
//
//  Created by michaeltam on 15/11/26.
//  Copyright © 2015年 mike公司. All rights reserved.
//

import Foundation
import UIKit


func dateFromString(timeString:String) -> NSDate{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let time = dateFormatter.dateFromString(timeString)
    return time!
}

func stringFromDate(time:NSDate) -> String{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let timeString = dateFormatter.stringFromDate(time)
    return timeString
}