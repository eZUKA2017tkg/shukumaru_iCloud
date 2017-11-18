//
//  shouhinListViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/13.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class shouhinListViewController: UIViewController {
    
    
    @IBOutlet weak var enpitsuBtn: ButtomCustom!
    @IBOutlet weak var noteBtn: ButtomCustom!
    @IBOutlet weak var keshigomuBtn: ButtomCustom!
    @IBOutlet weak var hasamiBtn: ButtomCustom!
    @IBOutlet weak var enpitsukezuriBtn: ButtomCustom!
    
    
    @IBOutlet weak var hanamarusuu: UILabel!
    @IBOutlet weak var hanamarusuu2: UILabel!
    
    var enpitsuHantei = 0
    var noteHantei = 0
    var keshigomuHantei = 0
    var hasamiHantei = 0
    var enpitsukezuriHantei = 0
    
    var finishCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishCount = 0
        
        let store  = NSUbiquitousKeyValueStore.default()
        
        let shukudaiCount = Int(store.longLong(forKey: "宿題数"))
        
        var zyoutaiArray:Array = [Int(), Int()]
        
        
        if shukudaiCount > 0 {
            zyoutaiArray = store.array(forKey: "宿題リスト1/状況") as! [Int]
            finishCount += zyoutaiArray[1]
        }
        
        
        if shukudaiCount > 1 {
            zyoutaiArray = store.array(forKey: "宿題リスト2/状況") as! [Int]
            finishCount += zyoutaiArray[1]
        }
        
        if shukudaiCount > 2 {
            zyoutaiArray = store.array(forKey: "宿題リスト3/状況") as! [Int]
            finishCount += zyoutaiArray[1]
        }
        
        if shukudaiCount > 3 {
            zyoutaiArray = store.array(forKey: "宿題リスト4/状況") as! [Int]
            finishCount += zyoutaiArray[1]
            
        }
        
        
        hanamarusuu.text = (23 + finishCount).description
        hanamarusuu2.text = (98 + finishCount).description
        

        // Do any additional setup after loading the view.
        
        //通知センターの設定
        let center = NotificationCenter.default
        center.addObserver(self,selector: #selector(ubiquitousDataDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,object: nil)
        
        // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(shouhinListViewController.update), userInfo: nil, repeats: true)
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
                if Int(store.longLong(forKey: "子アラート判定")) == 1 {
                    alert()
                }
            }
        }
    }
    
    // アラートの表示
    func alert() {
        let store  = NSUbiquitousKeyValueStore.default()
        let myAlert = UIAlertController(title: "おんどくのじかんです", message: "でんわがめんにいきましょう!", preferredStyle: .alert)
        let myAction = UIAlertAction(title: "とじる", style: .default) {
            action in print("foo!!")
        }
        myAlert.addAction(myAction)
        present(myAlert, animated: true, completion: nil)
        
        store.removeObject(forKey: "子アラート判定")
        store.set(0, forKey: "子アラート判定")
        store.removeObject(forKey: "音読ボタン変更判定")
        store.set(1, forKey: "音読ボタン変更判定")
        store.synchronize()
    }
    
    func ubiquitousDataDidChange(notification: NSNotification) {
        //iCloudのデータが変更された時の処理
        //通知オブジェクトから渡ってくるデータを取得
        print("成功")
        
        if let info = notification.userInfo {
            //TableViewセルの数を指定
            
            print("成功")
            finishCount = 0
            
            let store  = NSUbiquitousKeyValueStore.default()
            
            let shukudaiCount = Int(store.longLong(forKey: "宿題数"))
            
            var zyoutaiArray:Array = [Int(), Int()]
            
            
            if shukudaiCount > 0 {
                zyoutaiArray = store.array(forKey: "宿題リスト1/状況") as! [Int]
                finishCount += zyoutaiArray[1]
            }
            
            
            if shukudaiCount > 1 {
                zyoutaiArray = store.array(forKey: "宿題リスト2/状況") as! [Int]
                finishCount += zyoutaiArray[1]
            }
            
            if shukudaiCount > 2 {
                zyoutaiArray = store.array(forKey: "宿題リスト3/状況") as! [Int]
                finishCount += zyoutaiArray[1]
            }
            
            if shukudaiCount > 3 {
                zyoutaiArray = store.array(forKey: "宿題リスト4/状況") as! [Int]
                finishCount += zyoutaiArray[1]
                
            }
            
            
            hanamarusuu.text = (23 + finishCount).description
            hanamarusuu2.text = (98 + finishCount).description
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enpitsuBtnTap(_ sender: Any) {

        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "かくにん", message: "えんぴつ とこうかんしますか?", preferredStyle:  UIAlertControllerStyle.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            // アラートを作成
            let alert = UIAlertController(
                title: "こうかんしました!",
                message: "",
                preferredStyle: .alert)
            
            // アラートにボタンをつける
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            // アラート表示
            self.present(alert, animated: true, completion: nil)
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func noteBtnTap(_ sender: Any) {
        
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "かくにん", message: "ノート とこうかんしますか?", preferredStyle:  UIAlertControllerStyle.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            // アラートを作成
            let alert = UIAlertController(
                title: "こうかんしました!",
                message: "",
                preferredStyle: .alert)
            
            // アラートにボタンをつける
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            // アラート表示
            self.present(alert, animated: true, completion: nil)
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func keshigomuBtnTap(_ sender: Any) {
        
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "かくにん", message: "けしごむ とこうかんしますか?", preferredStyle:  UIAlertControllerStyle.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            // アラートを作成
            let alert = UIAlertController(
                title: "こうかんしました!",
                message: "",
                preferredStyle: .alert)
            
            // アラートにボタンをつける
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            // アラート表示
            self.present(alert, animated: true, completion: nil)
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func hasamiBtnTap(_ sender: Any) {
        
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "かくにん", message: "はさみ とこうかんしますか?", preferredStyle:  UIAlertControllerStyle.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            // アラートを作成
            let alert = UIAlertController(
                title: "こうかんしました!",
                message: "",
                preferredStyle: .alert)
            
            // アラートにボタンをつける
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            // アラート表示
            self.present(alert, animated: true, completion: nil)
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func enpitsukezuriBtnTap(_ sender: Any) {
        
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "かくにん", message: "えんぴつけずり とこうかんしますか?", preferredStyle:  UIAlertControllerStyle.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            // アラートを作成
            let alert = UIAlertController(
                title: "こうかんしました!",
                message: "",
                preferredStyle: .alert)
            
            // アラートにボタンをつける
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            // アラート表示
            self.present(alert, animated: true, completion: nil)
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
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
