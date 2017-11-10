//
//  ButtonCustom.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/10/17.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

@IBDesignable
class ButtomCustom: UIButton {
    @IBInspectable var textColor: UIColor?
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

}
