//
//  AppDelegate.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/3/28.
//

import UIKit
import LeanCloud
import AVFoundation
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appid = "yEPJxTS3b6eA7FjMAyCeViTy-9Nh9j0Va"
    var appkey = "hfnvgJxJh1y8EQ7AyMkXl5x0"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        LCApplication.logLevel = .off
        do {
            try LCApplication.default.set(
                id: "yEPJxTS3b6eA7FjMAyCeViTy-9Nh9j0Va",
                key: "hfnvgJxJh1y8EQ7AyMkXl5x0",
                serverURL: "https://yepjxts3.lc-cn-e1-shared.com")
        } catch {
            print(error)
        }//LeanCloud
        
        let  session =  AVAudioSession .sharedInstance()
        do {
            try session.setActive( true )
            try session.setCategory( AVAudioSession.Category.playback )
        } catch {
            print (error)
        }//后台播放
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

