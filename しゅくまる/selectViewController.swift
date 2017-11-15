//
//  selectViewController.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/10.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import NCMB
import  UserNotifications

@available(iOS 10.0, *)
class selectViewController: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let store  = NSUbiquitousKeyValueStore.default()
        store.removeObject(forKey: "帰宅判定")
        store.set(0, forKey: "帰宅判定")
        store.removeObject(forKey: "帰宅判定")
        store.set(0, forKey: "帰宅判定プッシュ")
        store.removeObject(forKey: "音読時間")
        store.set("", forKey: "音読時間")
        store.synchronize()
        store.synchronize()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }



    @IBAction func childBtnTap(_ sender: Any) {
        
        let store  = NSUbiquitousKeyValueStore.default()
        
        store.removeObject(forKey: "宿題数")
        
        store.removeObject(forKey: "宿題リスト1/タイトル")
        
        store.removeObject(forKey: "宿題リスト1/状況")
        
        
        store.removeObject(forKey: "宿題リスト2/タイトル")
        
        
        store.removeObject(forKey: "宿題リスト2/状況")
        
        
        store.removeObject(forKey: "宿題リスト3/タイトル")
        
        
        store.removeObject(forKey: "宿題リスト3/状況")
        
        
        store.removeObject(forKey: "宿題リスト4/タイトル")
        
        
        store.removeObject(forKey: "宿題リスト4/状況")
        
        store.removeObject(forKey: "帰宅判定")
        
        store.removeObject(forKey: "帰宅判定プッシュ")
        
        store.removeObject(forKey: "宿題選択判定")
        
        store.removeObject(forKey: "音読判定")
        
                store.removeObject(forKey: "音読判定プッシュ")
                store.removeObject(forKey: "はなまる判定プッシュ")
        
        store.removeObject(forKey: "音読時間")
        
        store.removeObject(forKey: "宿題終了判定")
        
        store.removeObject(forKey: "親アラート判定")
        store.removeObject(forKey: "子アラート判定")
        
        store.removeObject(forKey: "音読ボタン変更判定")
        store.removeObject(forKey: "アイコンバッジ")

        
        store.synchronize()
        
        
        
        store.set(0, forKey: "宿題数")
        
            store.set(["", ""], forKey: "宿題リスト1/タイトル")
            store.set([0, 0], forKey: "宿題リスト1/状況")
        
            store.set(["", ""], forKey: "宿題リスト2/タイトル")
            store.set([0, 0], forKey: "宿題リスト2/状況")
        
            store.set(["", ""], forKey: "宿題リスト3/タイトル")
            store.set([0, 0], forKey: "宿題リスト3/状況")
        
            store.set(["", ""], forKey: "宿題リスト4/タイトル")
            store.set([0, 0], forKey: "宿題リスト4/状況")
        
        store.set(1, forKey: "帰宅判定")
        store.set(1, forKey: "帰宅判定プッシュ")
        store.set(0, forKey: "宿題選択判定")
        store.set(0, forKey: "音読判定")
        store.set("", forKey: "音読時間")
        store.set(0, forKey: "宿題終了判定")
                store.set(0, forKey: "音読判定プッシュ")
                store.set(0, forKey: "はなまる判定プッシュ")
        store.set(0, forKey: "親アラート判定")
        store.set(0, forKey: "子アラート判定")
        store.set(0, forKey: "音読ボタン変更判定")
        store.set(1, forKey: "アイコンバッジ")
        
        store.synchronize()

    }
    
    @IBAction func oyaBtntap(_ sender: Any) {
        
        
    }
}
