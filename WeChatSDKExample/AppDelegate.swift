//
//  AppDelegate.swift
//  WeChatSDKExample
//
//  Created by Xin Hong on 16/4/25.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit
import WeChatSDK

struct WeChat {
    static let appID = "Your App ID"
    static let appSecret = "Your App Secret"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        WeChatSDK.registerApp(WeChat.appID)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}
