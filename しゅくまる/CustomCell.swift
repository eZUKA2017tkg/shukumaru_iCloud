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
            
            if cellObject.tapBtn == 0 {
                tapBtn?.setTitle("これから!", for: .normal)
                tapBtn?.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                tapBtn?.backgroundColor = UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0)
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
        
        tapBtn?.setTitle("おわった!", for: .normal)
        tapBtn?.setTitleColor(UIColor(red: 48/255, green: 148/255, blue: 137/255, alpha: 1.0), for: .normal)
        tapBtn?.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cellObject.tapBtn = 1
        
        hanamaruView?.image = UIImage(named: "はなまる")
        cellObject.hanamaruView = 1
        
        // DelegateでViewControllerに処理を渡す
        delegate?.updateCellObject(object: cellObject)
    }
    
}
