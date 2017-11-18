//
//  FirstViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/09/02.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import  SkyWay
import NCMB

class tableViewList: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomTableViewCellDelegate {

    var imgArray = Array<String>()
    var label2Array = Array<String>()
    var buttonArray = Array<Int>()
    var img2Array = Array<Int>()
    
    @IBOutlet weak var shukudaisuu2: UILabel!
    
    @IBOutlet weak var shukudaisuu: UILabel!
    
    @IBOutlet weak var finish: UILabel!
    
    @IBOutlet weak var finish2: UILabel!
    
    @IBOutlet weak var todayLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    var alartHantei = 0
    
    var reloadHantei = 0
    
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


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        imgArray = [String](repeating: "", count: label2Array.count)
    
        for n in 0..<label2Array.count {
    
            switch label2Array[n]{
    
            case "かんじドリル":
                imgArray[n] = "かんじドリルai"
                break
            case "けいさんドリル":
                imgArray[n] = "けいさんドリルai"
                break
            case "さくぶん":
                imgArray[n] = "さくぶんai"
                break
            case "おんどく":
                imgArray[n] = "おんどくai"
                break
            case "こくご":
                imgArray[n] = "こくごai"
                break
            case "さんすう":
                imgArray[n] = "さんすうai"
                break
            case "しゃかい":
                imgArray[n] = "しゃかいai"
                break
            case "りか":
                imgArray[n] = "りかai"
                break
            case "がいこくご":
                imgArray[n] = "そのたai"
                break
            default:
                break
            }
        }
        
        buttonArray = [Int](repeating: 0, count: label2Array.count)
        img2Array = [Int](repeating: 0, count: label2Array.count)
        
        var shukudaiCount:Int = 0//宿題数を計算する値
        var finishCount:Int = 0 //終わった数を計算する値
        
        shukudaiCount = label2Array.count
        
        for num in 0 ..< label2Array.count {
            finishCount += buttonArray[num]
        }
        shukudaisuu.text = String(shukudaiCount)
        shukudaisuu2.text = String(shukudaiCount)
        
        finish.text = String(finishCount)
        
        let selectDate = Date()
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy" + "年" + "MM" + "月" + "d" + "日"
        let TodayDate = formatter.string(from: selectDate as Date)
        todayLabel.text = TodayDate
        
        
        let todayFormatter:DateFormatter = DateFormatter()
        todayFormatter.dateFormat = "yyyy" + "MM" + "d"
        

        
        //通知センターの設定
        let center = NotificationCenter.default
        center.addObserver(self,selector: #selector(ubiquitousDataDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,object: nil)
        
        // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tableViewList.update), userInfo: nil, repeats: true)
        
    }
    
    func ubiquitousDataDidChange(notification: NSNotification) {
        //iCloudのデータが変更された時の処理
        //通知オブジェクトから渡ってくるデータを取得
        print("成功")
        
        if let info = notification.userInfo {
            //TableViewセルの数を指定
            
            print("成功")
            
            let store  = NSUbiquitousKeyValueStore.default()
            let shukudaiCount = Int(store.longLong(forKey: "宿題数"))
            
            buttonArray = []
            img2Array = []
            
            var zyoutaiArray:Array = [Int(), Int()]
            
            if shukudaiCount > 0 {
                zyoutaiArray = store.array(forKey: "宿題リスト1/状況") as! [Int]
                
                buttonArray.append(zyoutaiArray[0])
                img2Array.append(zyoutaiArray[1])
                
            }
            
            if shukudaiCount > 1 {
                zyoutaiArray = store.array(forKey: "宿題リスト2/状況") as! [Int]
                
                buttonArray.append(zyoutaiArray[0])
                img2Array.append(zyoutaiArray[1])
            }
            
            if shukudaiCount > 2 {
                zyoutaiArray = store.array(forKey: "宿題リスト3/状況") as! [Int]
                
                buttonArray.append(zyoutaiArray[0])
                img2Array.append(zyoutaiArray[1])
            }
            
            if shukudaiCount > 3 {
                zyoutaiArray = store.array(forKey: "宿題リスト4/状況") as! [Int]
                
                buttonArray.append(zyoutaiArray[0])
                img2Array.append(zyoutaiArray[1])
                
            }

            tableView.reloadData()
        }
    }
    
    
    //TableViewセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return label2Array.count
    }
    
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableCellのIDでUITableViewCellのインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.cellObject = setCell(icon: imgArray[indexPath.row], title: label2Array[indexPath.row], tapBtnStates: buttonArray[indexPath.row], hanamaruStates: img2Array[indexPath.row])
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
        
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
    
    
    func updateCellObject(object: setCell) {
            dump(object)
        shukudaiCount()
    }
    
    func shukudaiCount() {
        let finishText = finish.text
        var count:Int = Int(finishText!)!
        if count < label2Array.count {
        count += 1
        }
        finish.text = count.description
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
        
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
            return .landscape
        }
    }
}
