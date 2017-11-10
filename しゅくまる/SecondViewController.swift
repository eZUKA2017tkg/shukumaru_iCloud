//
//  SecondViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/09/02.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var TitleBar: UINavigationBar!
    
    @IBOutlet var table: UITableView!
    
    
    //sectionごとの画像配列
    let imgArray:NSArray = [
        "", "", ""
    ]
    
    let label2Array:NSArray = [
        "けいさんドリル",
        "おんどく",
        "しゃかい"
    ]

    
    //TableViewセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return label2Array.count
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableCellのIDでUITableViewCellのインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        let img = UIImage(named: imgArray[indexPath.row] as!String)
        
        //Tag番号1でUIImageViewインスタンスの生成
        let imageView1 = cell.viewWithTag(1) as! UIImageView
        imageView1.image = img
        
        
        table.tableFooterView = UIView(frame: .zero)
        
        return cell
        
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
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
        return .portrait
        }
    }
}

