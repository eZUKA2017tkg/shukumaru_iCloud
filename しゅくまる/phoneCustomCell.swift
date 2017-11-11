//
//  phoneCustomCell.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/10.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import NCMB

class setPhoneCell {
    var iconView: String
    var title: String
    var tapView: Int
    var hanamaruBtn = Int()
    
    init(icon: String, title: String, tapBtnStates: Int, hanamaruStates: Int) {
        
        self.iconView = icon
        self.title = title
        self.tapView = tapBtnStates
        self.hanamaruBtn = hanamaruStates
    }
    
}

protocol CustomTableViewPhoneCellDelegate: class {
    func updateCellObject(object: setPhoneCell)
}

class phoneCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tapView: ButtomCustom!

    @IBOutlet weak var hanamaruBtn: UIButton!
    
    weak var delegate: CustomTableViewPhoneCellDelegate!
    
    var indexPath = IndexPath()

    var cellObject: setPhoneCell! {
        didSet {
            
            iconView.image = UIImage(named: cellObject.iconView)
            titleLabel.text = cellObject.title as String
            print(cellObject.title)
            
            if cellObject.tapView == 0 {
                tapView?.setTitle("未", for: .normal)
                tapView?.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                tapView?.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
            }else if cellObject.tapView == 1 {
                tapView?.setTitle("済", for: .normal)
                tapView?.setTitleColor(UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0), for: .normal)
                tapView?.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            if cellObject.hanamaruBtn == 0 {
                hanamaruBtn?.setBackgroundImage(UIImage(named: "はなまるoff"), for: .normal)
            }else if cellObject.hanamaruBtn == 1 {
                hanamaruBtn?.setBackgroundImage(UIImage(named: "はなまる"), for: .normal)
            }

        }
        
    }

    @IBAction func hanamaruTap(_ sender: Any) {
       /*
        let store  = NSUbiquitousKeyValueStore.default()
        var hanteiArray = store.array(forKey: "宿題リスト1/タイトル")

        if titleLabel.text == (hanteiArray?[1] as! String) {
            
            var colorHanteiArray = store.array(forKey: "宿題リスト1/状況")
            
            if (colorHanteiArray?[0] as! Int) == 1 {
                
                hanamaruBtn?.setBackgroundImage(UIImage(named: "はなまる"), for: .normal)
                store.removeObject(forKey: "宿題リスト1/状況")
                store.set([1, 1], forKey: "宿題リスト1/状況")
                store.synchronize()
            }
            
        }else {
                hanteiArray = store.array(forKey: "宿題リスト2/タイトル")
                if titleLabel.text == (hanteiArray?[1] as! String) {
                    
                    var colorHanteiArray = store.array(forKey: "宿題リスト1/状況")
                    
                    if (colorHanteiArray?[0] as! Int) == 1 {
                        
                        hanamaruBtn?.setBackgroundImage(UIImage(named: "はなまる"), for: .normal)
                        store.removeObject(forKey: "宿題リスト2/状況")
                        store.set([1, 1], forKey: "宿題リスト2/状況")
                        store.synchronize()
                    }
                }else {
                    hanteiArray = store.array(forKey: "宿題リスト3/タイトル")
                    if titleLabel.text == (hanteiArray?[1] as! String) {
                        
                        var colorHanteiArray = store.array(forKey: "宿題リスト3/状況")
                        
                        if (colorHanteiArray?[0] as! Int) == 1 {
                            
                            hanamaruBtn?.setBackgroundImage(UIImage(named: "はなまる"), for: .normal)
                            store.removeObject(forKey: "宿題リスト3/状況")
                            store.set([1, 1], forKey: "宿題リスト3/状況")
                            store.synchronize()
                        }
                    }else {
                        hanteiArray = store.array(forKey: "宿題リスト4/タイトル")
                        if titleLabel.text == (hanteiArray?[1] as! String) {
                            
                            var colorHanteiArray = store.array(forKey: "宿題リスト4/状況")
                            
                            if (colorHanteiArray?[0] as! Int) == 1 {
                                
                                hanamaruBtn?.setBackgroundImage(UIImage(named: "はなまる"), for: .normal)
                                store.removeObject(forKey: "宿題リスト4/状況")
                                store.set([1, 1], forKey: "宿題リスト4/状況")
                                store.synchronize()
                            }
                    }
                }
            }
        }
               cellObject.hanamaruBtn = 1
        // DelegateでViewControllerに処理を渡す
        delegate?.updateCellObject(object: cellObject)
        */
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
