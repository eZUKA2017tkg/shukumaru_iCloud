//
//  FirstViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/09/02.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import NCMB

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomTableViewPhoneCellDelegate {
    
    @IBOutlet var table: UITableView!
    
    var imgArray = Array<String>()
    var label2Array = Array<String>()
    var img2Array = Array<Int>()
    var buttonArray = Array<Int>()
    
    
    @IBOutlet weak var TodayLabel: UILabel!
    
    @IBOutlet weak var Shukudaisuu: UILabel!
    
    @IBOutlet weak var Shukudaisuu2: UILabel!
    
    @IBOutlet weak var Finish: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var shukudaiCount:Int = 0//宿題数を計算する値
        var finishCount:Int = 0 //終わった数を計算する値
        
        
        //宿題数の読み込み
        let obj5 = NCMBObject(className: "shukumaru")
        
        obj5?.objectId = "09Accleo9VZKpqVD"
        // 設定されたobjectIdを元にデータストアからデータを取得
        obj5?.fetchInBackground({ (error) in
            if error != nil {
                // 取得に失敗した場合の処理
            }else{
                // 取得に成功した場合の処理
                // (例)取得したデータの出力
                shukudaiCount = obj5?.object(forKey: "number") as! Int
                self.Shukudaisuu.text = shukudaiCount.description
                self.Shukudaisuu2.text = shukudaiCount.description
            }
        })

        img2Array = [Int](repeating: 0, count: label2Array.count)
        buttonArray = [Int](repeating: 0, count: label2Array.count)
        img2Array = [Int](repeating: 0, count: label2Array.count)
        buttonArray = [Int](repeating: 0, count: label2Array.count)
        
        for num in 0 ..< label2Array.count {
            finishCount += buttonArray[num]
        }
        Shukudaisuu.text = shukudaiCount.description
        Shukudaisuu2.text = shukudaiCount.description
        
        Finish.text = String(finishCount)
        
        let selectDate = Date()
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy" + "年" + "MM" + "月" + "d" + "日"
        let TodayDate = formatter.string(from: selectDate as Date)
        TodayLabel.text = TodayDate
        
        
        let todayFormatter:DateFormatter = DateFormatter()
        todayFormatter.dateFormat = "yyyy" + "MM" + "d"
        
    }
    
    //TableViewセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
    }
    
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableCellのIDでUITableViewCellのインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "phoneCustomCell", for: indexPath) as! phoneCustomCell

        cell.cellObject = setPhoneCell(icon: "", title: "", tapBtnStates: 0, hanamaruStates:0)
        
        cell.delegate = self
        
        return cell
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
