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
    @IBOutlet weak var hanamaruBtn: UIImageView!
    
    weak var delegate: CustomTableViewPhoneCellDelegate!
    
    var indexPath = IndexPath()

    var cellObject: setPhoneCell! {
        didSet {
            
            let obj5 = NCMBObject(className: "shukumaru")
            var titleArray:Array = [String(), String()]
            var zyoukyouArray:Array = [Int(), Int()]
            
            obj5?.objectId = "M680bXcsyKaAAkei"
            // 設定されたobjectIdを元にデータストアからデータを取得
            obj5?.fetchInBackground({ (error) in
                if error != nil {
                    // 取得に失敗した場合の処理
                }else{
                    // 取得に成功した場合の処理
                    // (例)取得したデータの出力
                    titleArray = obj5!.object(forKey: "array") as! [String]
                    self.iconView.image = UIImage(named: titleArray[0] as String)
                    self.titleLabel.text = String(describing: titleArray[1] as String)
                    print(titleArray[0])
                    print(titleArray[1])
                }
            })
            
            obj5?.objectId = "Wv8z88sLcvg0N1ra"
            // 設定されたobjectIdを元にデータストアからデータを取得
            obj5?.fetchInBackground({ (error) in
                if error != nil {
                    // 取得に失敗した場合の処理
                }else{
                    // 取得に成功した場合の処理
                    // (例)取得したデータの出力
                    zyoukyouArray = obj5!.object(forKey: "array") as! [Int]
                    if zyoukyouArray[0] == 0 {
                        self.tapView?.setTitle("未", for: .normal)
                        self.tapView?.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                        self.tapView?.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
                    }else if zyoukyouArray[0] == 1 {
                        self.tapView?.setTitle("済", for: .normal)
                        self.tapView?.setTitleColor(UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0), for: .normal)
                        self.tapView?.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    }
                    if zyoukyouArray[1] == 0 {
                        self.hanamaruBtn?.image = UIImage(named: "はなまるoff")
                    }else if zyoukyouArray[1] == 1 {
                        self.hanamaruBtn?.image = UIImage(named: "はなまる")
                    }
                }
            })
    
        }
        
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
