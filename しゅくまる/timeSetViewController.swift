//
//  timeSetViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/14.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class timeSetViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var ondokuTimeSet: UIDatePicker!
    
    var dateStr = ""
    var  dateFomatter = DateFormatter()
    var returnDate = ""
    
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 遷移先が、AViewControllerだったら……
        if let controller = viewController as? SecondViewController {
            // AViewControllerのプロパティvalueの値変更。
            if returnDate != "" {
            controller.ondokuLabel.text = "音読の時間は " + returnDate + " です"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateFomatter.timeStyle = .short
        ondokuTimeSet.addTarget(self, action: #selector(updateStr), for: .valueChanged)
        let  now = Date()
        
        ondokuTimeSet.date = now
        
        // BViewController自身をDelegate委託相手とする。
        navigationController?.delegate = self as UINavigationControllerDelegate
        
        // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeSetViewController.update), userInfo: nil, repeats: true)
        
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


    
    func updateStr() {
        dateStr = dateFomatter.string(from: ondokuTimeSet.date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func okBtnTap(_ sender: Any) {
        
        let store  = NSUbiquitousKeyValueStore.default()
        store.removeObject(forKey: "音読時間")
        store.removeObject(forKey: "親アラート判定")
        store.set(1, forKey: "親アラート判定")
        store.removeObject(forKey: "子アラート判定")
        store.set(1, forKey: "子アラート判定")
        store.removeObject(forKey: "音読ボタン変更判定")
        store.set(0, forKey: "音読ボタン変更判定")
        store.set(dateFomatter.string(from: ondokuTimeSet.date), forKey: "音読時間")
        store.synchronize()
        
        returnDate = dateFomatter.string(from: ondokuTimeSet.date)
        
        
        let alert: UIAlertController = UIAlertController(title: "設定しました", message: "", preferredStyle:  UIAlertControllerStyle.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
