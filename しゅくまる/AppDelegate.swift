//
//  AppDelegate.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/09/02.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit
import NCMB
import UserNotifications

@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{

    var window: UIWindow?
    var backgroundTaskID : UIBackgroundTaskIdentifier = 0
    
    //********** APIキーの設定 **********
    let applicationkey = "0efb074d147e0932cf61a8d21d04a1957208ee011dfdff1270f150ef066344eb"
    let clientkey      = "565e9597c867325a65135ddc37352080ed9132d0808e218df7d9bd86cc5a6f5a"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        //********** SDKの初期化 **********
        NCMB.setApplicationKey(applicationkey, clientKey: clientkey)
        //▼▼▼起動時に処理される▼▼▼
        
                signal(SIGPIPE, SIG_IGN)
        //▲▲▲起動時に処理される▲▲▲
        
        // background fetch
    
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        self.backgroundTaskID = application.beginBackgroundTask(){
            [weak self] in
            application.endBackgroundTask((self?.backgroundTaskID)!)
            self?.backgroundTaskID = UIBackgroundTaskInvalid

        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        application.endBackgroundTask(self.backgroundTaskID)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

