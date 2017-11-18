//
//  ThirdViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/09/03.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import UserNotifications

@available(iOS 10.0, *)
class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomTableViewRenrakuCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //通知センターの設定
        let center = NotificationCenter.default
        center.addObserver(self,selector: #selector(ubiquitousDataDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,object: nil)
        
        
        // Do any additional setup after loading the view.
        // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ThirdViewController.update), userInfo: nil, repeats: true)
    }
    
    //sectionごとの画像配列
    let imgArray:Array = [
        "再生ボタン", "再生ボタン", "再生ボタン", "再生ボタン", "再生ボタン"
    ]
    
    let label2Array:Array = [
        "10秒",
        "30秒",
        "20秒",
        "40秒",
        "1分5秒"
    ]
    
    let label3Array:Array = [
        "今日  -- : --",
        "昨日  -- : --",
        "○/◇ -- : --",
        "○/◇ -- : --",
        "○/◇ -- : --"
    ]
    
    //TableViewセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableCellのIDでUITableViewCellのインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "renrakuCustomCell", for: indexPath) as! renrakuTableViewCell
        
        cell.cellObject = setRenrakuCell(icon: "再生ボタン", title: label2Array[indexPath.row], date: label3Array[indexPath.row])
        
        cell.delegate = self as CustomTableViewRenrakuCellDelegate
        
        return cell
    }
    
    func updateRenrakuCellObject(object: setRenrakuCell) {
        dump(object)
    }

    
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
        }
        
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
        let myAlert = UIAlertController(title: "音読の時間です", message: "電話画面に移動しましょう", preferredStyle: .alert)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
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

