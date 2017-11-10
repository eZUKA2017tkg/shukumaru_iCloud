//
//  shukudaiTableCell.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/10/17.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    
    //sectionごとの画像配列
    let imgArray:NSArray = [
        "宿題", "宿題", "宿題"
    ]
    
    let label2Array:NSArray = [
        "けいさんドリル",
        "おんどく",
        "しゃかい"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //TableViewセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableCellのIDでUITableViewCellのインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        let img = UIImage(named: imgArray[indexPath.row] as!String)
        
        //Tag番号1でUIImageViewインスタンスの生成
        let imageView1 = cell.viewWithTag(1) as! UIImageView
        imageView1.image = img
        
        //Tag番号2でUILabelインスタンスの生成
        let label1 = cell.viewWithTag(2) as! UILabel
        label1.text = String(describing: label2Array[indexPath.row])
        
        //Tag番号3でUIButtonインスタンスの生成
        let button1 = cell.viewWithTag(3) as! UIButton
        
        //Tag番号4でUIImageViewインスタンスの生成
        let imageView2 = cell.viewWithTag(4) as! UIImageView
        
        return cell
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            //Dispose of any resources that can be recreated.
        }
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

