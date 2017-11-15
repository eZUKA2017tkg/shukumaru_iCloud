//
//  SecondViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/09/02.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import NCMB
import UserNotifications


protocol TitleTableViewControllerDelegate {
    func updateTableView()
}


@available(iOS 10.0, *)
class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomTableViewTsuutiCellDelegate, TitleTableViewControllerDelegate {
    func updateTableView() {
        
    }

    
    var tableListCount = 0
    
    @IBOutlet weak var ondokuLabel: UILabel!
    @IBOutlet weak var ondokuZikanBtn: ButtomCustom!
    
    @IBOutlet weak var tableView: UITableView!
    
    var imgArray = Array<String>()
    var label2Array = Array<String>()
    
    var timeSet = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //通知センターの設定
        let center = NotificationCenter.default
        center.addObserver(self,selector: #selector(ubiquitousDataDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,object: nil)
        
        let store  = NSUbiquitousKeyValueStore.default()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 48
        
        if Int(store.longLong(forKey: "音読判定")) == 0 {
            ondokuLabel.text = "音読はありません"
            ondokuZikanBtn.isEnabled = false // ボタン無効
            ondokuZikanBtn.backgroundColor = UIColor(red: 207/255, green: 217/255, blue: 214/255, alpha: 1.0)
        }else if Int(store.longLong(forKey: "音読判定")) == 1 {
            ondokuLabel.text = "音読の時間を設定しましょう"
            ondokuZikanBtn.isEnabled = true // ボタン無効
            ondokuZikanBtn.backgroundColor =  UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
        }
        
        if store.string(forKey: "音読時間") != "" {
            let str = store.string(forKey: "音読時間")
            ondokuLabel.text = "音読の時間は " + str! + " です"
        }

        
        tableListCount += Int(store.longLong(forKey: "宿題終了判定"))
        if Int(store.longLong(forKey: "宿題終了判定"))  > 0 {
            for _ in 0 ..< Int(store.longLong(forKey: "宿題終了判定")) {
            imgArray.append("そのたai")
                label2Array.append("終わった宿題があります\nはなまるを付けてあげましょう")
            }
        }
        
        tableListCount += Int(store.longLong(forKey: "宿題選択判定"))
        if Int(store.longLong(forKey: "宿題選択判定")) == 1 {
            imgArray.append("そのたai")
            label2Array.append("宿題が登録されました")
        }
        
        tableListCount += Int(store.longLong(forKey: "帰宅判定"))
        if Int(store.longLong(forKey: "帰宅判定")) == 1 {
            imgArray.append("帰宅ai")
            label2Array.append("帰宅しました")
        }
        
        // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SecondViewController.update), userInfo: nil, repeats: true)
    }
    
    func getNowTime()-> String {
        // 現在時刻を取得
        let nowTime: Date = Date()
        // 成形する
        let format = DateFormatter()
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
            if str == store.string(forKey: "音読時間"){
                if Int(store.longLong(forKey: "親アラート判定")) == 1 {
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var TitleBar: UINavigationBar!
    
    @IBOutlet var table: UITableView!
    

    func ubiquitousDataDidChange(notification: NSNotification) {
        //iCloudのデータが変更された時の処理
        //通知オブジェクトから渡ってくるデータを取得
        print("成功")
        let store  = NSUbiquitousKeyValueStore.default()
        if let info = notification.userInfo {
            
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
            
            if Int(store.longLong(forKey: "音読判定プッシュ")) == 1 {
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
                content.body = "音読を聞いてあげる時間を設定しましょう"
                content.sound = UNNotificationSound.default()
                
                // 通知スタイルを指定
                let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
                // 通知をセット
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
                let store  = NSUbiquitousKeyValueStore.default()
                store.removeObject(forKey: "音読判定プッシュ")
                store.set(0, forKey: "音読判定プッシュ")
                store.synchronize()
            }
            
            if Int(store.longLong(forKey: "はなまる判定プッシュ")) == 1 {
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
                content.body = "終わった宿題にはなまるを付けてあげましょう"
                content.sound = UNNotificationSound.default()
                
                // 通知スタイルを指定
                let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
                // 通知をセット
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
                let store  = NSUbiquitousKeyValueStore.default()
                store.removeObject(forKey: "はなまる判定プッシュ")
                store.set(0, forKey: "はなまる判定プッシュ")
                store.synchronize()
            }

            
            imgArray = []
            label2Array = []
            tableListCount = 0

            let store  = NSUbiquitousKeyValueStore.default()
            
            if Int(store.longLong(forKey: "音読判定")) == 0 {
                ondokuLabel.text = "音読はありません"
                ondokuZikanBtn.isEnabled = false // ボタン無効
                ondokuZikanBtn.backgroundColor = UIColor(red: 207/255, green: 217/255, blue: 214/255, alpha: 1.0)
            }else if Int(store.longLong(forKey: "音読判定")) == 1 {
                ondokuLabel.text = "音読の時間を設定しましょう"
                ondokuZikanBtn.isEnabled = true // ボタン無効
                ondokuZikanBtn.backgroundColor =  UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
            }
            if store.string(forKey: "音読時間") != "" {
                let str = store.string(forKey: "音読時間")
                ondokuLabel.text = "音読の時間は " + str! + " です"
            }
            
            
            tableListCount += Int(store.longLong(forKey: "宿題終了判定"))
            if Int(store.longLong(forKey: "宿題終了判定"))  > 0 {
                for _ in 0 ..< Int(store.longLong(forKey: "宿題終了判定")) {
                    imgArray.append("そのたai")
                    label2Array.append("終わった宿題があります\nはなまるを付けてあげましょう")
                }
            }
            
            tableListCount += Int(store.longLong(forKey: "宿題選択判定"))
            if Int(store.longLong(forKey: "宿題選択判定")) == 1 {
                imgArray.append("そのたai")
                label2Array.append("宿題が登録されました")
            }
            
            tableListCount += Int(store.longLong(forKey: "帰宅判定"))
            if Int(store.longLong(forKey: "帰宅判定")) == 1 {
                imgArray.append("帰宅ai")
                label2Array.append("帰宅しました")
            }
            
            tableView.reloadData()
        }
        
    }
    
    //TableViewセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableListCount
    }
    
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableCellのIDでUITableViewCellのインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "tsuutiCustomCell", for: indexPath) as! tsuutiCustomCell
        
        cell.cellObject = setTsuutiCell(icon: imgArray[indexPath.row], title: label2Array[indexPath.row])
        
        cell.delegate = self
        
        return cell
    }
    
    func updateCellObject(object: setTsuutiCell) {
        dump(object)
        //shukudaiCount()
    }
    
    // ...途中省略
    var titleTableViewDelegate: TitleTableViewControllerDelegate!
    
    // ...途中省略
    

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

