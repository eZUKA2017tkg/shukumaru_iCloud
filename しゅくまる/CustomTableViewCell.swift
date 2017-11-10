//
//  CustomTableViewCell.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/03.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myTextLabel: UILabel!
    
    @IBOutlet weak var myButton: ButtomCustom!
    
    @IBOutlet weak var hanamaru: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
