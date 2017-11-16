//
//  renrakuTableViewCell.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/15.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class setRenrakuCell {
    var iconView: String
    var title: String
    var date: String
    
    init(icon: String, title: String, date: String) {
        
        self.iconView = icon
        self.title = title
        self.date = date
    }
    
    
    
}

protocol CustomTableViewRenrakuCellDelegate: class {
    func updateRenrakuCellObject(object: setRenrakuCell)
}


class renrakuTableViewCell: UITableViewCell {
    
    weak var delegate: CustomTableViewRenrakuCellDelegate!
    
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cellObject: setRenrakuCell! {
        didSet {
            
            iconView?.image = UIImage(named: cellObject.iconView)
            
            titleLabel?.text = String(describing: cellObject.title)
            
            dateLabel?.text = String(describing: cellObject.date)
        }
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
