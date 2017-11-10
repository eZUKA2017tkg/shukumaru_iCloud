//
//  FirstViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/09/02.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class TabFirstViewController: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet weak var kanjiDoriru: ButtomCustom!

    @IBOutlet weak var keisanDoriru: ButtomCustom!
    
    @IBOutlet weak var sakubun: ButtomCustom!
    
    @IBOutlet weak var ondoku: ButtomCustom!
    
    @IBOutlet weak var kokugo: ButtomCustom!
    
    @IBOutlet weak var sansuu: ButtomCustom!
    
    @IBOutlet weak var shakai: ButtomCustom!
    
    @IBOutlet weak var rika: ButtomCustom!
    
    @IBOutlet weak var gaikokugo: ButtomCustom!
    
    let date = Date()
    let calendar = Calendar.current
    
    
    //どのボタンを選択したかを記録
    var buttonHantei = [Int](repeating: 0, count: 9)
    
    var hantei = 0 //宿題の登録数を記録

    let kanjiON = UIImage(named: "かんじドリルon")
    let kanjiOFF = UIImage(named: "かんじドリル")
    
    @IBAction func kanjiTap(_ sender: Any) {
        if buttonHantei[0] == 0 && hantei < 4{
            kanjiDoriru.setBackgroundImage(kanjiON, for: .normal)
            buttonHantei[0] = 1
            hantei += 1
        }else if buttonHantei[0] == 1{
            kanjiDoriru.setBackgroundImage(kanjiOFF, for: .normal)
            buttonHantei[0] = 0
            hantei -= 1
        }else if buttonHantei[0] == 0{
            kanjiDoriru.setBackgroundImage(kanjiOFF, for: .normal)
        }
    }
    
    let keisanON = UIImage(named: "けいさんドリルon")
    let keisanOFF = UIImage(named: "けいさんドリル")

    @IBAction func keisanTap(_ sender: Any) {
        if buttonHantei[1] == 0 && hantei < 4{
            keisanDoriru.setBackgroundImage(keisanON, for: .normal)
            buttonHantei[1] = 1
            hantei += 1
        }else if buttonHantei[1] == 1{
            keisanDoriru.setBackgroundImage(keisanOFF, for: .normal)
            buttonHantei[1] = 0
            hantei -= 1
        }
        else if buttonHantei[1] == 0{
            keisanDoriru.setBackgroundImage(keisanOFF, for: .normal)
        }
    }
    
    let sakubunON = UIImage(named: "さくぶんon")
    let sakubunOFF = UIImage(named: "さくぶん")
    
    @IBAction func sakubunTap(_ sender: Any) {
        if buttonHantei[2] == 0 && hantei < 4{
            sakubun.setBackgroundImage(sakubunON, for: .normal)
            buttonHantei[2] = 1
            hantei += 1
        }else if buttonHantei[2] == 1{
            sakubun.setBackgroundImage(sakubunOFF, for: .normal)
            buttonHantei[2] = 0
            hantei -= 1
        }
        else if buttonHantei[2] == 0{
            sakubun.setBackgroundImage(sakubunOFF, for: .normal)
        }
    }
    
    let ondokuON = UIImage(named: "おんどくon")
    let ondokuOFF = UIImage(named: "おんどく")
    
    @IBAction func ondokuTap(_ sender: Any) {
        if buttonHantei[3] == 0 && hantei < 4{
            ondoku.setBackgroundImage(ondokuON, for: .normal)
            buttonHantei[3] = 1
            hantei += 1
        }else if buttonHantei[3] == 1{
            ondoku.setBackgroundImage(ondokuOFF, for: .normal)
            buttonHantei[3] = 0
            hantei -= 1
        }else if buttonHantei[3] == 0{
            ondoku.setBackgroundImage(ondokuOFF, for: .normal)
        }
    }
    
    
    let kokugoON = UIImage(named: "こくごon")
    let kokugoOFF = UIImage(named: "こくご")
    
    @IBAction func kokugoTap(_ sender: Any) {
        if buttonHantei[4] == 0 && hantei < 4{
            kokugo.setBackgroundImage(kokugoON, for: .normal)
            buttonHantei[4] = 1
            hantei += 1
        }else if buttonHantei[4] == 1{
            kokugo.setBackgroundImage(kokugoOFF, for: .normal)
            buttonHantei[4] = 0
            hantei -= 1
        }else if buttonHantei[4] == 0{
            kokugo.setBackgroundImage(kokugoOFF, for: .normal)
        }
    }
    

    let sansuuON = UIImage(named: "さんすうon")
    let sansuuOFF = UIImage(named: "さんすう")
    @IBAction func sansuuTap(_ sender: Any) {
        if buttonHantei[5] == 0 && hantei < 4{
            sansuu.setBackgroundImage(sansuuON, for: .normal)
            buttonHantei[5] = 1
            hantei += 1
        }else if buttonHantei[5] == 1{
            sansuu.setBackgroundImage(sansuuOFF, for: .normal)
            buttonHantei[5] = 0
            hantei -= 1
        }
        else if buttonHantei[5] == 0{
            sansuu.setBackgroundImage(sansuuOFF, for: .normal)
        }
    }
    
    let shakaiON = UIImage(named: "しゃかいon")
    let shakaiOFF = UIImage(named: "しゃかい")
    @IBAction func shakaiTap(_ sender: Any) {
        if buttonHantei[6] == 0 && hantei < 4{
            shakai.setBackgroundImage(shakaiON, for: .normal)
            buttonHantei[6] = 1
            hantei += 1
        }else if buttonHantei[6] == 1{
            shakai.setBackgroundImage(shakaiOFF, for: .normal)
            buttonHantei[6] = 0
            hantei -= 1
        }else if buttonHantei[6] == 0{
            shakai.setBackgroundImage(shakaiOFF, for: .normal)
        }
    }

    
    let rikaON = UIImage(named: "りかon")
    let rikaOFF = UIImage(named: "りか")
    
    @IBAction func rikaTap(_ sender: Any) {
        if buttonHantei[7] == 0 && hantei < 4{
            rika.setBackgroundImage(rikaON, for: .normal)
            buttonHantei[7] = 1
            hantei += 1
        }else if buttonHantei[7] == 1{
            rika.setBackgroundImage(rikaOFF, for: .normal)
            buttonHantei[7] = 0
            hantei -= 1
        }else if buttonHantei[7] == 0{
            rika.setBackgroundImage(rikaOFF, for: .normal)
        }
    }
    
    let gaikokugoON = UIImage(named: "そのたon")
    let gaikokugoOFF = UIImage(named: "そのた")
    
    @IBAction func gaikokugoTap(_ sender: Any) {
        if buttonHantei[8] == 0 && hantei < 4{
            gaikokugo.setBackgroundImage(gaikokugoON, for: .normal)
            buttonHantei[8] = 1
            hantei += 1
        }else if buttonHantei[8] == 1{
            gaikokugo.setBackgroundImage(gaikokugoOFF, for: .normal)
            buttonHantei[8] = 0
            hantei -= 1
        }else if buttonHantei[8] == 0{
            gaikokugo.setBackgroundImage(gaikokugoOFF, for: .normal)
        }
    }
    
    @IBOutlet weak var OKbutton: ButtomCustom!
    
    //sectionごとの配列数の決定
    var label2Array = Array<String>()
    
    func ataiwatashi() {
        //配列数の決定と初期化
        if hantei == 1 {
            
            label2Array = [String](repeating:"", count:1)
            
        }else if hantei == 2 {
            
            label2Array = [String](repeating:"", count:2)
            
        }else if hantei == 3 {
            
            label2Array = [String](repeating:"", count:3)
            
        }else if hantei == 4 {
            
            label2Array = [String](repeating:"", count:4)
            
        }
        
        var num = 0
        
        if buttonHantei[0] == 1 {
            label2Array[num] = "かんじドリル"
            if num < label2Array.count {
                num += 1
            }
        }
        if buttonHantei[1] == 1 {
            label2Array[num] = "けいさんドリル"
            if num < label2Array.count {
                num += 1
            }
        }
        if buttonHantei[2] == 1 {
            label2Array[num] = "さくぶん"
            if num < label2Array.count {
                num += 1
            }
        }
        if buttonHantei[3] == 1 {
            label2Array[num] = "おんどく"
            if num < label2Array.count {
                num += 1
            }
        }
        if buttonHantei[4] == 1 {
            label2Array[num] = "こくご"
            if num < label2Array.count {
                num += 1
            }
        }
        if buttonHantei[5] == 1 {
            label2Array[num] = "さんすう"
            if num < label2Array.count {
                num += 1
            }
        }
        if buttonHantei[6] == 1 {
            label2Array[num] = "しゃかい"
            if num < label2Array.count {
                num += 1
            }
        }
        if buttonHantei[7] == 1 {
            label2Array[num] = "りか"
            if num < label2Array.count {
                num += 1
            }
        }
        if buttonHantei[8] == 1 {
            label2Array[num] = "がいこくご"
            if num < label2Array.count {
                num += 1
            }
        }

    }
    
    /// 画面遷移するかの判定処理
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "mySegue") {
        return true;
        }else {
            return false
        }
    }
    
    /// 画面遷移時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mySegue") {
            ataiwatashi()
            let secondViewController:tableViewList = segue.destination as! tableViewList
            secondViewController.label2Array = self.label2Array
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
