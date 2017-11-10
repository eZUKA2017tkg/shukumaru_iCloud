//
//  CalenderCell.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/06.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit



class CalenderCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!

    @IBOutlet weak var hanamaruBtn: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
    }
}
