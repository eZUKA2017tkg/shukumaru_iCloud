//
//  CustomUICollectionViewCell.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/07.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class CustomUICollectionViewCell: UICollectionViewCell {
    
        let cell:CalenderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CalenderCell
    
}
