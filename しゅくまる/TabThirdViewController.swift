//
//  TabThirdViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/10/17.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class TabThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TabThirdViewController.update), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return .landscape
        }
    }

}
