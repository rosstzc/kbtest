//
//  ViewController.swift
//  keenbrace
//
//  Created by a a a a a on 15/9/24.
//  Copyright (c) 2015年 mike公司. All rights reserved.
//

import UIKit
import CoreBluetooth
//import
import Charts


class HomeViewController: UIViewController,UIActionSheetDelegate{

    
    @IBOutlet weak var btnConnectBT: UIButton!
    
    @IBOutlet weak var btnWarmUp: UIButton!
    
    @IBOutlet weak var btnHowToRun: UIButton!
    @IBOutlet weak var btnRelax: UIButton!
    
    @IBOutlet weak var btnStartToRun: UIButton!
    
    var user = NSUserDefaults.standardUserDefaults()
    var temp:AnyObject = ""

    //处理运动指导内容
    
    var guideArray:NSMutableArray = []
    var guideTitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //测试查询
        var query = AVQuery(className: "history")
        var history:AVObject
        history = query.getObjectWithId("5667a78900b0acaae45c6c55")
        let time = history.objectForKey("time")
        let objectId = history.objectId
        print(time)
//        print(history)

        //leancloud 后台查询
        query.getObjectInBackgroundWithId("5667a78900b0acaae45c6c55", block: {(object: AVObject?, error: NSError?) in
            if (error == nil ) {
//                print(object)
            
                //查询到某对象，然后修改
                object?.setObject("2222", forKey: "userid")
                //定义一个计数器
                object?.fetchWhenSave = true
                object?.incrementKey("upvotes") //每执行一次就自动加1
                
                object?.save()
            }
        })

        //知道某对象objectId，然后修改
        temp = AVObject(withoutDataWithClassName: "history", objectId: "5667c91300b09f857187d845")
        temp.setObject("333", forKey: "userid")
        //保存数组
        let array = ["111", "22", "333", "55"]
        temp.addUniqueObjectsFromArray(array, forKey: "tags")
        temp.save() //注意这是后台保存
        
        //删除某对象
//        temp.deleteInBackgroundWithBlock({(succeeded:Bool, error:NSError?)  in
//            if ((error) == nil) {
//                print("成功")
//                print(succeeded)
//            }
//            else {
//                print("失败")
//            }
//        })

        //
        let mypost = AVObject(className: "Post")
        mypost.setObject("作为一个程序员。。。", forKey: "content")
        mypost.setObject("111", forKey: "userid")
        mypost.save()
        
        //测试一对一外键
//        var comment = AVObject(className: "Comment")
//        comment.setObject(AVObject(withoutDataWithClassName: "Post", objectId: "56680dfe00b0d1db76dd3c35"), forKey: "post")
//        comment.setObject("我回家后是不写的", forKey: "content")
//        comment.setObject("222", forKey: "userid")
//        comment.save()
        
        
        
        
        //用户注册
//        let temp2 = AVUser()
//        temp2.username = "55"
//        temp2.password = "55"
//        temp2.email = "55@163.com"
//        temp2.signUp() //内建用户表，只能注册和登录
//        temp2.signUpInBackgroundWithBlock({(succeeded:Bool, error:NSError?)  in
//            print(succeeded)
//            print(error)
//            if ((error) == nil) {
//                print("成功")
//                print(succeeded)
//            }
//            else {
//                print("失败")
//            }
//        })

        //用户登录
        AVUser.logOut()
        AVUser.logInWithUsername("33", password: "33") //调试时不在后台运行
//        AVUser.logInWithUsernameInBackground("55", password: "55", block: {(object: AVUser?, error: NSError?) in
//            if (error == nil ) {
////                print(object)
//                
//            } else  {
//                print("登录失败")
//                print(error)
//            }
//        })
        
        
        
        
        
        
        //当前用户
        let currentUser = AVUser.currentUser()
        if currentUser != nil {
            print("有用户")
            print(currentUser.username)
            print(currentUser.objectId)
            
            //修改密码
//            currentUser.updatePassword("555234234234", newPassword: "123456", block: {(object, error: NSError?) in
//                if (error == nil ) {
//                    print(object)
//                } else  {
//                    print("修改密码失败")
//                }
//            })

        }else {
            print("没用户，去注册流程")
        }
        
        //重置密码
//        AVUser.requestPasswordResetForEmailInBackground("rosstzc@163.com", block: {(succeeded: Bool, error: NSError?) in
//            if (error == nil ) {
//            print(succeeded)
//            print("已发送重置")
//            } else  {
//            print("登录失败")
//            }
//        })

        
        //关注某个人
        if currentUser != nil {
            currentUser.follow("566926d300b0bf3713a0ebe8", andCallback: {(succeeded: Bool, error: NSError?) in
                if self.filterError(error) {
                    print("已关注该用户")
                }
            })
        }
        
        query = AVUser.followeeQuery(currentUser.objectId)
        temp = query.findObjects()
        print(temp.count)
        query = AVUser.followerQuery(currentUser.objectId)
        let temprr:[AnyObject] = query.findObjects()
        print(temp.count)
        for i in temprr {
            print(i.valueForKey("objectId"))
        }
        
//        currentUser.getFollowersAndFollowees({(dict: [NSObject], error: NSError?) in
//            if self.filterError(error) {
//                print("已关注该用户")
//            }
//        })
        
        //关注某个人
        //        currentUser.unfollow("566926d300b0bf3713a0ebe8", andCallback: {(succeeded: Bool, error: NSError?) in
        //            if self.filterError(error) {
        //                print("已取关该用户")
        //            }
        //        })
        //
        
        
        
 
        //一个用户喜欢多个微博，通过relationforkey来保存这些微博 （未验证成功）
        let relation = currentUser.relationforKey("likes")
        relation.addObject(mypost)
        currentUser.saveInBackground()
        
        //基本查询
        query = AVQuery(className: "Post")
        query.whereKey("userid", equalTo: "111")  //查询用户111发的所有微博
        query.limit = 20 //
        query.skip = 10
        query.orderByAscending("createAt")
        query.addAscendingOrder("userid") //如果上一个排序相等，就继续用这个排序
        
        let postArray = query.findObjects()  //所有数据
//        print(postArray.count  )
        
        //后台查询，不阻塞进程
        query.findObjectsInBackgroundWithBlock({(objects:[AnyObject]? , error:NSError?)  in
            if (error != nil) {
                print("错误")
            } else {
                print(objects?.count)
            }
        })

        // 查最新的一个值
        query.getFirstObjectInBackgroundWithBlock({(object:AnyObject? , error:NSError?)  in
            if (error != nil) {
                print("错误")
            } else {
//                print(object)
            }
        })
        
        //查询数值比较的结果
        query = AVQuery(className: "history")
        query.whereKey("upvotes", greaterThan: NSNumber(int: 50))
        query.findObjectsInBackgroundWithBlock({(objects:[AnyObject]? , error:NSError?)  in
            if (error != nil) {
                print("错误")
            } else {
                print(objects?.count)
            }
        })
        
        
        //查询包含不同值的对象
        query = AVQuery(className: "history")
        let userid = ["1111", "2222", "33"]
        query.whereKey("userid", containedIn: userid)
//        query.whereKey("userid", containsString: "11")  //查询属性包含某些字符的所有结果
        query.findObjectsInBackgroundWithBlock({(objects:[AnyObject]? , error:NSError?)  in
            if (error != nil) {
                print("错误")
            } else {
                print(objects?.count)
            }
        })
        
        // 找到包含某一个键（属性）的对象，（比如找到包含图片的微博）
        query = AVQuery(className: "history")
        query.whereKeyExists("upvotes")
        query.findObjectsInBackgroundWithBlock({(objects:[AnyObject]? , error:NSError?)  in
            if (error != nil) {
                print("错误")
            } else {
                print(objects?.count)
            }
        })
        
        
        //关系，要找到当前用户关注人发布的微博
//        let abc = AVStatus()
        
        
      //创建remind， 用户创建一个提醒
        var remind = AVObject(className: "Remind")
        remind.setObject("title111", forKey: "title")
        remind.setObject("detail111", forKey: "detail")
        remind.setObject(currentUser, forKey: "createBy") //类似建立索引
        var remindTimeArray = [[
            "time" : "time1",
            "interval" : "interval111"],
            [
                "time" : "time22",
                "interval" : "interval222"],
            [
                "time" : "time1",
                "interval" : "interval222"]]
        remind.setObject(remindTimeArray, forKey: "remindTimeArray")
//        remind.save()
     
       //关系查询，根据当前用户索引查所创建的提醒
        query = AVQuery(className: "Remind")
        query.whereKey("createBy", equalTo: currentUser)
        let reminds = query.findObjects()
        print(reminds.count)
        

        
        //checkin某个提醒(1对多关系)
        let check  = AVObject(className: "Checkin")
        remind = AVObject(withoutDataWithClassName: "Remind", objectId: "566940e460b25b793f326ed5")
        check.setObject(remind, forKey: "remind")
        check.setObject("我就是来checkin的", forKey: "content")
        check.setObject(currentUser, forKey: "createBy")
        check.save()
        remind.incrementKey("checks")
        remind.save()
        
        
        
        
        //checkin时同步发布一个时间线状态 （社交模块）
            //1 构建内容
        var status = AVStatus()
        var data:NSMutableDictionary
        data = [
            "type222" : "checkIn",
//            "data" : ["objectId: 333"],
        ]
            //用户发动态
        status.data = ["statusType":"remind", "objectIndex":"354"]
//        AVStatus.sendStatusToFollowers(status, andCallback: {(succeeded: Bool, error: NSError?) in
//            if self.filterError(error) {
//                print("已发动态")
//            }
//        })
        
        
            //查看已接收的动态(用官方的方法, 已验证ok)
        query = nil
        let query55 = AVStatus.inboxQuery("default")
        query55.limit=50
        query55.findObjectsInBackgroundWithBlock({(objects:[AnyObject]? , error:NSError?)  in
            if (error != nil) {
                print(error)
            } else {
                print(objects?.count)
//                print(objects)
            }
        })
        
        // 用自定义方式发送动态，已ok （处理那些我没有关注的人，但我们都关注了相同remind的人发的checkin，后来想了这个内容没必要进入用户timeline）
        let status2 = AVStatus()
        status2.data = ["statusType":"checkIn", "objectIndex":"354sdf"]
        
        let queryFollow = AVQuery(className: "FollowAtRemind")
        queryFollow.whereKey("remind", equalTo: "566a895800b0ee7f99657cce")
        
        let userQuery = AVUser.query()
        userQuery.whereKey("objectId", matchesKey: "uid", inQuery: queryFollow )
//        userQuery.whereKey("objectId", matchesQuery: queryFollow)  //第二个逻辑
        
//        status2.setQuery(userQuery)
//        status2.sendInBackgroundWithBlock({(succeeded: Bool, error: NSError?) in
//            if self.filterError(error) {
//                print("发送状态成功")
//            }
//        })

        
        // 1 先找关注该提醒的用户列表， 2 把列表作为status的条件，向这些用户发动态  （最可能的风险是后面关注的用户其信息流看不到之前其他用户的checkin；回答：后面关注的确实取不到，没关系，上面都说没必要）
        
        

        
         //查看已发送的动态
        let query66 = AVStatus.statusQuery()
        query66.whereKey("source", equalTo: currentUser)
        temp = query66.countObjects()
        print(temp)
        

        
            //2 受众群体
        query = nil
        query = AVUser.query()  //定义查询用户对象的容器
            //找到用户的粉丝列表
        let queryFollower = AVQuery(className: "follower")
        queryFollower.whereKey("user", equalTo: currentUser)
        
            //找到用户关注的提醒的粉丝列表 （）
        
        
        
//        query.whereKey(<#T##key: String!##String!#>, containedIn: <#T##[AnyObject]!#>)
//        status.setQuery(AVUser.getFollowers(<#T##AVUser#>))
//
//        
//        query = AVStatus.inboxQuery()
        
        
        
        
        //给某个checkin点赞  (逻辑：1. 先从like表查看是否有该用户的点赞记录。 2.如果有就删除该条记录，并且check表累计likes减1。 3. 如果没有，就在like表创建记录，并且check表的like累计加1 )
        let like = AVObject(className: "Like")
        let checkIn1 = AVObject(withoutDataWithClassName: "Checkin", objectId: "566a12b200b07a18dec58f2c")
        let query1 = AVQuery(className: "Like")
        query1.whereKey("uid", equalTo: currentUser)
        query1.whereKey("cid", equalTo: checkIn1)
        let temp33:NSArray = query1.findObjects()
        if temp33.count >= 1 {
            print("已赞,取消赞")
            let oid = temp33[0].valueForKey("objectId") as! String
            let likeTemp = AVObject(withoutDataWithClassName: "Like", objectId: oid)
            likeTemp.deleteInBackground()
            checkIn1.incrementKey("likes", byAmount: -1)
            checkIn1.save()
            
        } else {
            like.setObject(checkIn1, forKey: "cid")
            like.setObject(currentUser, forKey: "uid")
            like.saveInBackgroundWithBlock({(succeeded: Bool, error: NSError?) in
                if self.filterError(error) {
                    checkIn1.incrementKey("likes")  //刷新累计值
                    checkIn1.save()
                    print("保存对象与文件成功。 对象是 : \(like)")
                }
            })
        }
        
        
  
        
        
        
        // 评论某个checkin（先只做点赞）
//        let comment2 = AVObject(className: "Comment")
//        let remind2 = AVObject(withoutDataWithClassName: "Remind", objectId: "566940e460b25b793f326ed5")
//        comment2.setObject(remind2, forKey: "remind")
//        
//        let checkIn2 = AVObject(withoutDataWithClassName: "Checkin", objectId: "566a12b200b07a18dec58f2c")
//        comment2.setObject(checkIn2, forKey: "checkin")
//        comment2.setObject("对某个动态进行评论", forKey: "content")
//        
//        comment2.setObject(currentUser, forKey: "createBy")
//        comment2.saveInBackgroundWithBlock({(succeeded: Bool, error: NSError?) in
//            if self.filterError(error) {
//                print("保存对象与文件成功。 student : \(comment2)")
//            }
//        })
        

        
        //评论某个评论（先只做点赞）
        
        
        //修改某个remind
        remind = nil
        remind = AVObject(withoutDataWithClassName: "Remind", objectId: "566a895800b0ee7f99657cce")
        remind.setObject("title22", forKey: "title")
        remind.setObject("detail222", forKey: "detail")
        remindTimeArray = [[
            "time" : "time1",
            "interval" : "interval111"],
            [
                "time" : "time22",
                "interval" : "interval222"],
            [
                "time" : "time1",
                "interval" : "interval222"]]
        remind.setObject(remindTimeArray, forKey: "remindTimeArray")
        remind.save()
        

        
        //关注（取消关注）某remind. 逻辑更点赞差不多
        remind = nil
        remind = AVObject(withoutDataWithClassName: "Remind", objectId: "566a895800b0ee7f99657cce")
        
        query = nil
        query = AVQuery(className: "FollowAtRemind")
        query.whereKey("uid", equalTo: currentUser)
        query.whereKey("rid", equalTo: remind)
        
        if query.countObjects() >= 1 {
            print("已取关某remind")
            let queryFollow:NSArray = query.findObjects()
            let followOid = queryFollow[0].objectId
            let followTemp = AVObject(withoutDataWithClassName: "FollowAtRemind", objectId: followOid)
//            followTemp.deleteInBackground()
        }else {
            let followAtRemind = AVObject(className:"FollowAtRemind")
            followAtRemind.setObject(currentUser, forKey: "uid")
            followAtRemind.setObject(remind, forKey: "rid")
            followAtRemind.save()
//            print("已关注")
        }


   
        
        //查询我关注remind的列表
        query = nil
        query = AVQuery(className: "FollowAtRemind")
        query.whereKey("uid", equalTo: currentUser)
        query.includeKey("rid")  //关联查询,查关注的提醒列表，然后把每个提醒内容索引上
        let result:NSArray = query.findObjects()
        print(query.countObjects())
        for i in result {
            print(i.valueForKey("rid")?.valueForKey("title"))
        }
        
        
        
        //查看关注的提醒的checkin动态 + 关注的人的checkin动态
        
                //方案1：查询提醒列表，然后把关注的每个提醒id写入数组并作为条件，在查询checkin表时使用条件（使用containedIn）。 找到关注用户列表+关注提醒的粉丝列表，然后用这个结果查checkin表，并排序
        
                //方案2： 如果采用社交模块，可能逻辑是 1. 用户发checkin时同步创建一个state（内容是cid）， 2自定义向受所有粉丝发state + 自定义向该提醒的所有粉丝发state
        
        
        
        


        
        //查看关注的人的checkin动态
                //参考
//            // 先找到当前登录用户关注的用户列表
//            AVQuery *followeeQuery = [AVQuery queryWithClassName:@"UserFollow"];
//            [followeeQuery whereKey:@"follower" equalTo:[AVUser currentUser]];
//            
//            // 找到这些被关注者发布的微博
//            AVQuery *postQuery = [AVQuery queryWithClassName:@"Post"];
//            [postQuery whereKey:@"author" matchesKey:@"followee" inQuery:followeeQuery];
//            [postQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
//            // 得到当前用户关注的人发布的微博
//            }];
        
        
        
        //查看所有提醒checkin动态
           // 已ok， 但如果把上面的加上就不好弄了
        
        //查看某个checkin的赞列表
           //已ok
        
        //查看某个checkin的所有评论  (下个版本弄评论)
        
        
        //设置某个提醒不打扰我
           //已ok
        
       
        
        //向用户推送信息
        
        
        //同步提醒时间。 每次打开首页，检验用户关注(创建)提醒的修改时间与服务器时间差异，若不同就向服务器同步数据
        //1）当某提醒被修改以后（特别是提醒时间被修改），服务器创建一个临时推送列表
        //2) 在推送发出前，如果用户使用app同步了数据，那么清除推送
        
        // 发私信 （以后）
        
        // 与timeline相关的各种动态思考， 关注的人（关注某remind、赞remind、checkin、转发remind、转发checkin、赞checkin），关注的提醒（checkin、转发checkin、），
        
        
        
        /////////////////////////上面是leancloud的测试
        
        
        
        self.title = "首页"
        self.tabBarItem.title = "34"
        // Do any additional setup after loading the view, typically from a nib.
        
        var image:UIImage
//        var subView:UIImageView

        
        
        
//        //修改导航条背景色
//        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()

        
        //导航栏 背景图片
        image = UIImage(named: "上栏@1x")!
        self.navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics:.Default)
        

        //导航栏左上角icon
        //create a new button
        image = UIImage(named: "K（未点亮）@1x")!
        let button: UIButton = UIButton(type: UIButtonType.System)
        //set background image for button
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        
        //add function for button
        button.addTarget(self, action: "fbButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        button.frame = CGRectMake(0, 0, 30, 30 )
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        
        
        //链接蓝牙按钮

//                btnConnectBT.setTitle("智能", forState: .Normal) // 文字内容
//                btnConnectBT.titleLabel?.font = UIFont.systemFontOfSize(12)  //字体大小
        //不给力，实现不了图片size更换
//        image = UIImage(named: "发现（按下）@1x")!
//        btnConnectBT.setImage(image, forState:.Normal )
//        btnConnectBT.imageView?.frame = CGRectMake(100, 100, 100, 100)
        

//
//        链接蓝牙按钮内的icon图片
//        image = UIImage(named: "链接智能护膝@1x")!
//        subView = UIImageView.init(image: image)
//        subView.frame = CGRectMake(10, 24, 40, 40)
//        btnConnectBT.addSubview(subView)
//        
        
        
////        背景图
//                image = UIImage(named: "链接智能护膝按钮（未按）@1x")!
//                btnConnectBT.setBackgroundImage(image, forState: UIControlState.Normal)
//                btnConnectBT.frame = CGRectMake(0, 0, 200, 40)
//                btnConnectBT.imageEdgeInsets =  UIEdgeInsetsMake(0, 0, 100, 100)  //button image与上、左、下、右的距离。
//        
//     
    
        // 运动热身按钮的图片
//        image = UIImage(named: "运动前热身@1x")!
//        subView = UIImageView.init(image: image)
//        subView.frame = CGRectMake(10, 10, 50, 50)
//        btnWarmUp.addSubview(subView)
        
//        image = UIImage(named: "箭头@1x")!
//        subView = UIImageView.init(image: image)
//        subView.frame = CGRectMake(240, 23, 14, 24)
//        btnWarmUp.addSubview(subView)
        
//        image = UIImage(named: "首页内容框@1x")!

//        btnWarmUp.setBackgroundImage(image, forState: UIControlState.Normal)
//        btnWarmUp.frame = CGRectMake(3, 3, 200, 200)
        
        
        // 修改tab上图片过大的问题
//        image = UIImage(named: "home@1x")!
//        image.
        

        //在这类处理tabbar
//        var tabBarController = self.
        
    
    }
    
    //for leanCloud
    func filterError(error: NSError?) -> Bool{
        if error != nil {
            print("%@", error!)
            return false
        } else {
            return true
        }
    }
    
    
    
    
    func fbButtonPressed() {
        print("这里应该出发链接蓝牙的页面")
        
        self.performSegueWithIdentifier("segueConnectBlueTooth", sender: self)
    }
    

    @IBAction func btnIcon(sender: AnyObject) {
    }
    
    @IBAction func btnConnect(sender: AnyObject) {
        
        
    }
    
    
    @IBAction func btnWarmUp(sender: AnyObject) {
        
        
        guideTitle = "跑步前如何热身？"
        guideArray = [
            ["跑步前的拉伸动作（图片简版）","https://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207981177&idx=1&sn=8c5797a1a326800e92b3a11b8f9c3daf#rd",1],
            ["跑步前的拉伸运动（GIF动图）","https://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207981177&idx=2&sn=bd95c1c98a5b87872e3998bdf0f16cfd#rd",1],
            ["跑步前热身动作（视频）","https://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207981177&idx=3&sn=bb80b7bfa24c3cb9bc8c12c422d4cb91#rd",1],
            ["健身前要记得做热身运动！（动图）","https://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207981177&idx=4&sn=d8bf4ba156a4c7d1f422f6c09e0a513c#rd",1],
        ]

        self.performSegueWithIdentifier("segueToGuide", sender: self)
    }
    

    @IBAction func btnHowToRun(sender: AnyObject) {
        
        guideTitle = "如何正确地跑步？"
        guideArray = [
            ["如何拥有正确的跑步姿势？ ","http://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=208835151&idx=1&sn=80190602843f8ef1cb6c92deef37a9f4#rd",1],
              ["罗曼诺夫博士教你正确的“姿势跑步法” ","http://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=208835151&idx=2&sn=4cf22e9391fd50445afdfab7f7cc0086#rd",1],
              ["跑步技术分解训练-徐国锋 ","http://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=208835151&idx=3&sn=a51fbb22b46b2199214aec90ce75ec6a#rd",1],
              ["超级二货跑步姿势，纯娱乐，切勿模仿 ：》 ","http://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=208835151&idx=5&sn=18b364df8fce64801a5687e1f92931ed#rd",1],
   
        ]
        self.performSegueWithIdentifier("segueToGuide", sender: self)

    }
    
    
    @IBAction func btnRelax(sender: AnyObject) {
        
        guideTitle = "运动后如何拉伸？"
        guideArray = [
            ["跑步后拉伸动作（图片简版） ","http://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207973751&idx=1&sn=768af0583434f0c5b22a03985e758d92#rd",1],

            ["越锻炼腿越粗怎么破？运动后拉伸方法论（附图文视频详解） ","http://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207973751&idx=2&sn=52606d94532606eb9b9c540a5d27b482#rd",1],

            ["健身知识科普】运动后的肌肉拉伸全攻略","http://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207973751&idx=3&sn=419f131ce591e507868e7bdf98a691e3#rd",1],

            ["五个小动作教你跑后拉伸（视频）","http://mp.weixin.qq.com/s?__biz=MzAxOTQwMjE4NQ==&mid=207973751&idx=4&sn=d47aee9dd5a970044ddf007dac1faa67#rd",1],


        ]
        self.performSegueWithIdentifier("segueToGuide", sender: self)

    }
    
    @IBAction func btnRun(sender: AnyObject) {
        
        //判断是否连接了蓝牙
//        let connected = user.valueForKey("connection") as? Bool
//        if connected == nil {
//            let actionSheet = UIAlertController(title: "未连接智能护膝", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//            
//            let action1:UIAlertAction = UIAlertAction(title: "去连接设备", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
//                self.performSegueWithIdentifier("startToRun", sender: self)
//                
//            })
//            let action2:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: {(action) -> Void in
//                
//            })
//            actionSheet.addAction(action1)
//            actionSheet.addAction(action2)
//
//            presentViewController(actionSheet, animated: true, completion: nil)
//        
//        }
//        
        
        
        //如果已连接就出actionSheet
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let action1:UIAlertAction = UIAlertAction(title: "跑步", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            self.performSegueWithIdentifier("startToRun", sender: self)

        })
        
        let action2:UIAlertAction = UIAlertAction(title: "步行", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            self.performSegueWithIdentifier("startToRun", sender: self)

        })
        let action3:UIAlertAction = UIAlertAction(title: "爬山", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            self.performSegueWithIdentifier("startToRun", sender: self)

        })
        let action4:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: {(action) -> Void in
            
        })
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(action4)
        presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueToGuide" {
            let nextVC = segue.destinationViewController as! GuideListTableViewController
            nextVC.guideArray = guideArray
            nextVC.guideTitle = guideTitle  
            
        }
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

