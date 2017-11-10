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
    
    
    @IBOutlet weak var calenderHeaderView: UIView!
    
    @IBOutlet weak var headerTitle: UILabel!

    @IBOutlet weak var headerPrevBtn: UIButton!
    
    @IBOutlet weak var headerNextBtn: UIButton!
    
    @IBOutlet weak var calenderCollectionView: UICollectionView!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        headerTitle.text = changeHeaderTitle()
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
            Btn?.setBackgroundImage(UIImage(named: "はなまるoff"), for: .normal)
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
