//
//  SecondViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/09/02.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import NCMB

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomTableViewTsuutiCellDelegate {
    
    var tableListCount = 0
    
    @IBOutlet weak var ondokuLabel: UILabel!
    @IBOutlet weak var ondokuZikanBtn: ButtomCustom!
    
    @IBOutlet weak var tableView: UITableView!
    
    var imgArray = Array<String>()
    var label2Array = Array<String>()

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

