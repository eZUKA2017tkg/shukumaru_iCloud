//
//  selectViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/10.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import NCMB

class selectViewController: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func childBtnTap(_ sender: Any) {
        //宿題数の書き換え
        let obj5 = NCMBObject(className: "shukumaru")
        
        obj5?.objectId = "UmVEpBZ2hXIkWXlH"
        // 設定されたobjectIdを元にデータストアからデータを取得
        obj5?.fetchInBackground({ (error) in
            if error != nil {
                // 取得に失敗した場合の処理
            }else{
                // 取得に成功した場合の処理
                // (例)取得したデータの出力
                obj5?.setObject(0, forKey: "number")
                // データストアへの保存を実施
                obj5?.saveInBackground({ (error) in
                    if error != nil {
                        // 保存に失敗した場合の処理
                    }else{
                        // 保存に成功した場合の処理
                    }
                })
            }
        })
        
        //宿題リストの書き換え
        obj5?.objectId = "QIJ1U0hAlvvFRaLO"
        // 設定されたobjectIdを元にデータストアからデータを取得
        obj5?.fetchInBackground({ (error) in
            if error != nil {
                // 取得に失敗した場合の処理
            }else{
                // 取得に成功した場合の処理
                // (例)取得したデータの出力
                obj5?.setObject(["", "", 0, 0], forKey: "array")
                // データストアへの保存を実施
                obj5?.saveInBackground({ (error) in
                    if error != nil {
                        // 保存に失敗した場合の処理
                    }else{
                        // 保存に成功した場合の処理
                    }
                })
            }
        })
        
        //宿題リストの書き換え
        obj5?.objectId = "UQcpRuP6pOdVJCsP"
        // 設定されたobjectIdを元にデータストアからデータを取得
        obj5?.fetchInBackground({ (error) in
            if error != nil {
                // 取得に失敗した場合の処理
            }else{
                // 取得に成功した場合の処理
                // (例)取得したデータの出力
                    obj5?.setObject(["", "", 0, 0], forKey: "array")
                // データストアへの保存を実施
                obj5?.saveInBackground({ (error) in
                    if error != nil {
                        // 保存に失敗した場合の処理
                    }else{
                        // 保存に成功した場合の処理
                    }
                })
            }
        })
        
        //宿題リストの書き換え
        obj5?.objectId = "a3UE44UvNKJF8jJl"
        // 設定されたobjectIdを元にデータストアからデータを取得
        obj5?.fetchInBackground({ (error) in
            if error != nil {
                // 取得に失敗した場合の処理
            }else{
                // 取得に成功した場合の処理
                // (例)取得したデータの出力
                    obj5?.setObject(["", "", 0, 0], forKey: "array")
                // データストアへの保存を実施
                obj5?.saveInBackground({ (error) in
                    if error != nil {
                        // 保存に失敗した場合の処理
                    }else{
                        // 保存に成功した場合の処理
                    }
                })
            }
        })
        
        //宿題リストの書き換え
        obj5?.objectId = "g0Kkz4Ulv2kz2bzB"
        // 設定されたobjectIdを元にデータストアからデータを取得
        obj5?.fetchInBackground({ (error) in
            if error != nil {
                // 取得に失敗した場合の処理
            }else{
                // 取得に成功した場合の処理
                // (例)取得したデータの出力
                    obj5?.setObject(["", "", 0, 0], forKey: "array")
                // データストアへの保存を実施
                obj5?.saveInBackground({ (error) in
                    if error != nil {
                        // 保存に失敗した場合の処理
                    }else{
                        // 保存に成功した場合の処理
                    }
                })
            }
        })
        

    }
}
