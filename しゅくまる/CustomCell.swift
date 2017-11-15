//
//  CustomCell.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/09.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class setCell {
    var iconView: String
    var title: String
    var tapBtn: Int
    var hanamaruView = Int()
    
    init(icon: String, title: String, tapBtnStates: Int, hanamaruStates: Int) {
        
        self.iconView = icon
        self.title = title
        self.tapBtn = tapBtnStates
        self.hanamaruView = hanamaruStates
    }
    
    
    
}

protocol CustomTableViewCellDelegate: class {
    func updateCellObject(object: setCell)
}


class CustomCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tapBtn: ButtomCustom!
    @IBOutlet weak var hanamaruView: UIImageView!
    
    weak var delegate: CustomTableViewCellDelegate!
    
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cellObject: setCell! {
        didSet {
            
            iconView.image = UIImage(named: cellObject.iconView)
            
            titleLabel.text = String(describing: cellObject.title)
            
            let store  = NSUbiquitousKeyValueStore.default()
            
            if cellObject.tapBtn == 0 {

                if titleLabel.text == "おんどく" {
                    print("成功")
                    if store.string(forKey: "音読時間") == "" {
                        print("aaaa")
                        tapBtn!.setTitle("-- : --", for: .normal)
                        tapBtn!.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
                        tapBtn!.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                    }else {
                        tapBtn.setTitle(store.string(forKey: "音読時間"), for: .normal)
                        tapBtn.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
                        tapBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                    }
                    
                    if Int(store.longLong(forKey: "音読ボタン変更判定")) == 1 {
                        tapBtn?.setTitle("これから!", for: .normal)
                        tapBtn?.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                        tapBtn?.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
                    }
                    
                }else if titleLabel.text != "おんどく" {
                    tapBtn?.setTitle("これから!", for: .normal)
                    tapBtn?.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                    tapBtn?.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
                }

                
            }else if cellObject.tapBtn == 1 {
                tapBtn?.setTitle("おわった!", for: .normal)
                tapBtn?.setTitleColor(UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0), for: .normal)
                tapBtn?.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            if cellObject.hanamaruView == 0 {
                hanamaruView?.image = UIImage(named: "")
            }else if cellObject.hanamaruView == 1 {
                hanamaruView?.image = UIImage(named: "はなまる")
            }
        }
        
    }
    
    
    @IBAction func tapBtnAction(_ sender: Any) {

        if cellObject.tapBtn == 0 {
            
        let store  = NSUbiquitousKeyValueStore.default()
            if titleLabel.text != "おんどく" || Int(store.longLong(forKey: "音読ボタン変更判定")) == 1{
        tapBtn?.setTitle("おわった!", for: .normal)
        tapBtn?.setTitleColor(UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0), for: .normal)
        tapBtn?.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if cellObject.tapBtn == 0 {
            var hanteiArray = store.array(forKey: "宿題リスト1/タイトル")
            if titleLabel.text == (hanteiArray?[1] as! String) {
                store.removeObject(forKey: "宿題リスト1/状況")
                store.set([1, 0], forKey: "宿題リスト1/状況")
                store.synchronize()
            }else {
                hanteiArray = store.array(forKey: "宿題リスト2/タイトル")
                if titleLabel.text == (hanteiArray?[1] as! String) {
                    store.removeObject(forKey: "宿題リスト2/状況")
                    store.set([1, 0], forKey: "宿題リスト2/状況")
                    store.synchronize()
                }else {
                    hanteiArray = store.array(forKey: "宿題リスト3/タイトル")
                    if titleLabel.text == (hanteiArray?[1] as! String) {
                        store.removeObject(forKey: "宿題リスト3/状況")
                        store.set([1, 0], forKey: "宿題リスト3/状況")
                        store.synchronize()
                    }else {
                        hanteiArray = store.array(forKey: "宿題リスト4/タイトル")
                        if titleLabel.text == (hanteiArray?[1] as! String) {
                            store.removeObject(forKey: "宿題リスト4/状況")
                            store.set([1, 0], forKey: "宿題リスト4/状況")
                            store.synchronize()
                        }
                    }
                }
            }
        }
            
            var count = Int(store.longLong(forKey: "宿題終了判定"))
            count += 1
            store.removeObject(forKey: "宿題終了判定")
            store.set(count, forKey: "宿題終了判定")
            store.synchronize()
                store.removeObject(forKey: "はなまる判定プッシュ")
                store.set(1, forKey: "はなまる判定プッシュ")
                store.synchronize()
        
        cellObject.tapBtn = 1
        // DelegateでViewControllerに処理を渡す
        delegate?.updateCellObject(object: cellObject)
        }
        }
    }
    
}
