//
//  FirstViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/09/02.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import NCMB
import UserNotifications

@available(iOS 10.0, *)
class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomTableViewPhoneCellDelegate {
    
    @IBOutlet var table: UITableView!
    
    var imgArray = Array<String>()
    var label2Array = Array<String>()
    var img2Array = Array<Int>()
    var buttonArray = Array<Int>()
    
      var refreshControl:UIRefreshControl!
    
    
    @IBOutlet weak var TodayLabel: UILabel!
    
    @IBOutlet weak var Shukudaisuu: UILabel!
    
    @IBOutlet weak var Shukudaisuu2: UILabel!
    
    @IBOutlet weak var Finish: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var reloadView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var shukudaiCount:Int = 0//宿題数を計算する値
        var finishCount:Int = 0 //終わった数を計算する値
    
        //通知センターの設定
        let center = NotificationCenter.default
        center.addObserver(self,selector: #selector(ubiquitousDataDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,object: nil)

        let store  = NSUbiquitousKeyValueStore.default()
        shukudaiCount = Int(store.longLong(forKey: "宿題数"))
        
        Shukudaisuu.text = shukudaiCount.description
        Shukudaisuu2.text = shukudaiCount.description
        
        
        let selectDate = Date()
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy" + "年" + "MM" + "月" + "d" + "日"
        let TodayDate = formatter.string(from: selectDate as Date)
        TodayLabel.text = TodayDate
        
        
        let todayFormatter:DateFormatter = DateFormatter()
        todayFormatter.dateFormat = "yyyy" + "MM" + "d"
        
        var titleArray:Array = [String(), String()]
        var zyoutaiArray:Array = [Int(), Int()]
        
        
        if shukudaiCount > 0 {
            titleArray = store.array(forKey: "宿題リスト1/タイトル") as! [String]
            

            imgArray.append(titleArray[0])
            label2Array.append(titleArray[1])
            zyoutaiArray = store.array(forKey: "宿題リスト1/状況") as! [Int]

            img2Array.append(zyoutaiArray[0])
            buttonArray.append(zyoutaiArray[1])
            
        }
        
        
        if shukudaiCount > 1 {
            titleArray = store.array(forKey: "宿題リスト2/タイトル") as! [String]
            
            
            imgArray.append(titleArray[0])
            label2Array.append(titleArray[1])
            zyoutaiArray = store.array(forKey: "宿題リスト2/状況") as! [Int]
            
            img2Array.append(zyoutaiArray[0])
            buttonArray.append(zyoutaiArray[1])
        }
        
        if shukudaiCount > 2 {
            titleArray = store.array(forKey: "宿題リスト3/タイトル") as! [String]
            
            
            imgArray.append(titleArray[0])
            label2Array.append(titleArray[1])
            zyoutaiArray = store.array(forKey: "宿題リスト3/状況") as! [Int]
            
            img2Array.append(zyoutaiArray[0])
            buttonArray.append(zyoutaiArray[1])
        }
        
        if shukudaiCount > 3 {
            titleArray = store.array(forKey: "宿題リスト4/タイトル") as! [String]
            
            
            imgArray.append(titleArray[0])
            label2Array.append(titleArray[1])
            zyoutaiArray = store.array(forKey: "宿題リスト4/状況") as! [Int]
            
            img2Array.append(zyoutaiArray[0])
            buttonArray.append(zyoutaiArray[1])
            
        }
        
        for num in 0 ..< label2Array.count {
            finishCount += img2Array[num]
        }
        
        Finish.text = String(finishCount)
        shukudaiToCount()

        // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(FirstViewController.update), userInfo: nil, repeats: true)
    
    }
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    @IBOutlet weak var image10: UIImageView!
    @IBOutlet weak var image11: UIImageView!
    @IBOutlet weak var image12: UIImageView!

    
    func shukudaiToCount() {
        var count:Int = 0
        for num in 0 ..< label2Array.count {
            count += img2Array[num]
        }
        Finish.text = count.description
        
        if count != 0 {
        if 12/label2Array.count*count >= 3 {
            image1.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
            image2.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
            image3.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
        }
        if 12/label2Array.count*count >= 4 {
            image4.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
        }
        if 12/label2Array.count*count >= 6 {
            image5.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
            image6.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
        }
        if 12/label2Array.count*count >= 8 {
            image7.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
            image8.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
        }
        if 12/label2Array.count*count >= 9 {
            image9.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
        }
        if 12/label2Array.count*count >= 10 {
            image10.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
        }
        if 12/label2Array.count*count >= 12 {
            image11.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
            image12.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
        }
        }
        
    }
    

    func ubiquitousDataDidChange(notification: NSNotification) {
        //iCloudのデータが変更された時の処理
        //通知オブジェクトから渡ってくるデータを取得
                    print("成功")
        let store  = NSUbiquitousKeyValueStore.default()
        if let info = notification.userInfo {
            //TableViewセルの数を指定
            
            if Int(store.longLong(forKey: "帰宅判定プッシュ")) == 1 {
                if #available(iOS 10.0, *) {
                    // iOS 10
                    let center = UNUserNotificationCenter.current()
                    center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                        if error != nil {
                            return
                        }
                        
                        if granted {
                            print("通知許可")
                            
                            let center = UNUserNotificationCenter.current()
                            center.delegate = self as? UNUserNotificationCenterDelegate
                            
                        } else {
                            print("通知拒否")
                        }
                    })
                    
                } else {
                    // iOS 9以下
                    let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                    UIApplication.shared.registerUserNotificationSettings(settings)
                }
                
                
                //　通知設定に必要なクラスをインスタンス化
                let trigger: UNNotificationTrigger
                let content = UNMutableNotificationContent()
                var notificationTime = DateComponents()
                
                // トリガー設定
                // 設定したタイミングを起点として1分後に通知したい場合
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                
                // 通知内容の設定
                content.title = ""
                content.body = "○○ちゃんが帰宅しました"
                content.sound = UNNotificationSound.default()
                
                // 通知スタイルを指定
                let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
                // 通知をセット
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
                let store  = NSUbiquitousKeyValueStore.default()
                store.removeObject(forKey: "帰宅判定プッシュ")
                store.set(0, forKey: "帰宅判定プッシュ")
                store.synchronize()
            }
        
            imgArray = []
            label2Array = []
            img2Array = []
            buttonArray = []
            
            print("成功")
            loadView()
            viewDidLoad()
            
        }

    }
    
    //TableViewセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return label2Array.count
    }
    
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableCellのIDでUITableViewCellのインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "phoneCustomCell", for: indexPath) as! phoneCustomCell

        cell.cellObject = setPhoneCell(icon: imgArray[indexPath.row], title: label2Array[indexPath.row], tapBtnStates: img2Array[indexPath.row], hanamaruStates:buttonArray[indexPath.row])
        
        cell.delegate = self
        
        return cell
    }
    
    func getNowTime()-> String {
        // 現在時刻を取得
        let nowTime: Date = Date()
        // 成形する
        let format = DateFormatter()
        format.timeStyle = .short
        format.dateFormat = "H:mm"
        let nowTimeStr = format.string(from: nowTime)
        // 成形した時刻を文字列として返す
        return nowTimeStr
    }
    
    func update() {
        // 現在時刻を取得
        let str = getNowTime()
        // アラーム鳴らすか判断
        myAlarm(str: str)
    }
    
    func myAlarm(str: String) {
        // 現在時刻が設定時刻と一緒なら
        let store  = NSUbiquitousKeyValueStore.default()
        if store.string(forKey: "音読時間") != "" {
            print(str)
            print(store.string(forKey: "音読時間") as! String)
            if str == store.string(forKey: "音読時間") {
                print("成功")
                if Int(store.longLong(forKey: "親アラート判定")) == 1 {
                    print("成功")
                    alert()
                }
            }
        }
    }
    
    // アラートの表示
    func alert() {
        let store  = NSUbiquitousKeyValueStore.default()
        let myAlert = UIAlertController(title: "音読の時間です", message: store.string(forKey: "音読時間"), preferredStyle: .alert)
        let myAction = UIAlertAction(title: "閉じる", style: .default) {
            action in print("foo!!")
        }
        myAlert.addAction(myAction)
        present(myAlert, animated: true, completion: nil)
        
        store.removeObject(forKey: "親アラート判定")
        store.set(0, forKey: "親アラート判定")
        store.synchronize()
    }
    
    func updateCellObject(object: setPhoneCell) {
        dump(object)
        //shukudaiCount()
    }

    
    //画面を自動回転させない
    override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    
    //画面の向きを指定
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
        return .portrait
    }

    }
}
