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
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var shukudaiCount:Int = 0//宿題数を計算する値
        var finishCount:Int = 0 //終わった数を計算する値

        let store  = NSUbiquitousKeyValueStore.default()
        shukudaiCount = Int(store.longLong(forKey: "宿題数"))
        
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
