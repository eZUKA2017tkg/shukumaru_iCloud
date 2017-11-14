//
//  TabFourthViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/10/17.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92.0/255, green: 192.0/255, blue: 210.0/255, alpha: 1.0)
    }
    
    class func lightRed() -> UIColor {
        return UIColor(red: 195.0/255, green: 123.0/255, blue: 175.0/255, alpha: 1.0)
    }
}

class TabFourthViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    let dateManager = DateManeger()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 0.0
    var selectedDate = NSDate()
    var today = Date()
    let weekArray = ["にち", "げつ", "か", "すい", "もく", "きん", "ど"]
    
    let now = Date() // 現在日時の取得
    let todayDateFormatter = DateFormatter()
    
    
    @IBOutlet weak var calenderHeaderView: UIView!
    
    @IBOutlet weak var headerTitle: UILabel!

    @IBOutlet weak var headerPrevBtn: UIButton!
    
    @IBOutlet weak var headerNextBtn: UIButton!
    
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    @IBOutlet weak var hanamaruCounter: UILabel!
    
    @IBOutlet weak var hanamaruCounter2: UILabel!
    
    var finishCount = 0
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        headerTitle.text = changeHeaderTitle()
        
        finishCount = 0
        
        let store  = NSUbiquitousKeyValueStore.default()
        
        var shukudaiCount = Int(store.longLong(forKey: "宿題数"))
        
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
        
        todayDateFormatter.dateFormat = "d" // 日付フォーマットの設定
        
        hanamaruCounter.text = finishCount.description
        hanamaruCounter2.text = finishCount.description
        
        //通知センターの設定
        let center = NotificationCenter.default
        center.addObserver(self,selector: #selector(ubiquitousDataDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,object: nil)
    }
    
    func ubiquitousDataDidChange(notification: NSNotification) {
        //iCloudのデータが変更された時の処理
        //通知オブジェクトから渡ってくるデータを取得
        print("成功")
        let store  = NSUbiquitousKeyValueStore.default()
        if let info = notification.userInfo {
            //TableViewセルの数を指定
            print("成功")
            
            finishCount = 0
            
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
            
            
            hanamaruCounter.text = finishCount.description
            hanamaruCounter2.text = finishCount.description
            
            calenderCollectionView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //collectionView_1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    //collectionView_2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //sectionごとにcellの総数を数える
        if section == 0 {
            return 7
        }else {
            return dateManager.daysAcquisition() //ここは月によって異なる
        }
    }
    
    //collectionView_3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CalenderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CalenderCell
        
        //テキストカラー
        if indexPath.row % 7 == 0 {
            cell.textLabel?.textColor = UIColor.lightRed()
        }else if indexPath.row % 7 == 6 {
            cell.textLabel?.textColor = UIColor.lightBlue()
        }else {
            cell.textLabel?.textColor = UIColor.gray
        }
        
        let Btn = cell.hanamaruBtn
        //テキスト配置
        
        if indexPath.section == 0 {
            cell.textLabel?.text = weekArray[indexPath.row]
            Btn?.setBackgroundImage(UIImage(named: "nil"), for: .normal)
        }else {
            cell.textLabel?.text = dateManager.conversionDateFormat(indexPath: indexPath)

            Btn?.setBackgroundImage(UIImage(named: "nil"), for: .normal)
            Btn?.setTitle("", for: .normal)
            if finishCount > 0 {
                let kakuninformatter: DateFormatter = DateFormatter()
                kakuninformatter.dateFormat = "M"
                if kakuninformatter.string(from: now as Date) == kakuninformatter.string(from: selectedDate as Date + 1) {
                if cell.textLabel.text == todayDateFormatter.string(from: now) {
                print("成功")
                    Btn?.setBackgroundImage(UIImage(named: "はなまるカレンダー"), for: .normal)
                    Btn?.setTitle(finishCount.description, for: .normal)
                    Btn?.setTitleColor(UIColor(red: 216/255, green: 40/255, blue: 45/255, alpha: 1.0), for: .normal)
                    }
                }
            }
            //月によって1日の場所は異なる
            
        }
        
        let ordinalityOfFirstDay2 = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: dateManager.firstDateOfMonth())
        
        let dateRange = NSCalendar.current.range(of: .day, in: .month, for: dateManager.firstDateOfMonth())
        
        if indexPath.section == 1 {
        if (ordinalityOfFirstDay2! - 1) > indexPath.row {
            cell.textLabel.text = ""
            Btn?.setBackgroundImage(UIImage(named: "nil"), for: .normal)
        }
        if (ordinalityOfFirstDay2! - 2 + (dateRange?.count)!) < indexPath.row {
            cell.textLabel.text = ""
                        Btn?.setBackgroundImage(UIImage(named: "nil"), for: .normal)
        }
        }
        
        return cell
    }
    
    //cellのサイズを変更
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:  IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 1.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height: CGFloat
        if indexPath.section == 0 {
        height = width * 0.3
        }else {
            height = width * 0.8
        }
        
        return CGSize(width: width, height: height)
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    //headerの月を変更
    func changeHeaderTitle() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy" + "年" + "M" + "月"
        let selectMonth = formatter.string(from: selectedDate as Date)
        return selectMonth
    }
    
    //PrevBtnタップ時
    @IBAction func tappedHeaderPrevBtn(_ sender: Any) {
        
        selectedDate = dateManager.prevMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle()
    }
    
    @IBAction func tappedHeaderNextBtn(_ sender: Any) {
        selectedDate = dateManager.nextMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle()
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
