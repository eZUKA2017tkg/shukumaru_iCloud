//
//  tsuutiCustomCell.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/14.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import NCMB

class setTsuutiCell {
    var iconView: String
    var title: String
    
    init(icon: String, title: String) {
        
        self.iconView = icon
        self.title = title
    }
}

protocol CustomTableViewTsuutiCellDelegate: class {
    func updateCellObject(object: setTsuutiCell)
}

class tsuutiCustomCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    weak var delegate: CustomTableViewTsuutiCellDelegate!
    
    var indexPath = IndexPath()
    
    var cellObject: setTsuutiCell! {
        didSet {
            iconView.image = UIImage(named: cellObject.iconView)
            
            titleLabel.text = String(describing: cellObject.title)
                // 行間の変更(正確には行自体の高さを変更している。)
            let LineSpaceStyle = NSMutableParagraphStyle()
            LineSpaceStyle.lineSpacing = 10.0
            let lineSpaceAttr = [NSParagraphStyleAttributeName: LineSpaceStyle]
            titleLabel.attributedText = NSMutableAttributedString(string: titleLabel.text!, attributes: lineSpaceAttr)
            
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
