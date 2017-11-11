//
//  phoneTabBarController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/10.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

class phoneTabBarController: UITabBarController {

    
    @IBOutlet weak var TabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //選択されていないボタンの色
        // fontの設定
        let fontFamily: UIFont! = UIFont.systemFont(ofSize: 10)
        
        // 選択時の設定
        let selectedColor:UIColor = UIColor.white
        let selectedAttributes = [NSFontAttributeName: fontFamily, NSForegroundColorAttributeName: selectedColor] as [String : Any]
        /// タイトルテキストカラーの設定
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: UIControlState.selected)
        /// アイコンカラーの設定
        UITabBar.appearance().tintColor = selectedColor
        
        
        // 非選択時の設定
        let nomalAttributes = [NSFontAttributeName: fontFamily, NSForegroundColorAttributeName: UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)] as [String : Any]
        /// タイトルテキストカラーの設定
        UITabBarItem.appearance().setTitleTextAttributes(nomalAttributes, for: .normal)
        /// アイコンカラー（画像）の設定
        var assets :Array<String> = ["宿題グレー", "音声グレー", "通話グレー", "マイページグレー"]
        for (idx, item) in self.tabBar.items!.enumerated() {
            item.image = UIImage(named: assets[idx])?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
