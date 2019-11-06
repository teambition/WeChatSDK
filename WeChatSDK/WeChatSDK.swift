//
//  WeChatSDK.swift
//  WeChatSDK
//
//  Created by Xin Hong on 16/4/25.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

// The functions in "WXApi" must be called in this framework at least once, otherwise the framework will not work outside this module.
// So most of the functions in class "WXApi" are encapsulated to struct "WeChatSDK", although it seems like redundant.
// Therefore, you can regard this struct as a convenient way to use WeChat apis.
public struct WeChatSDK {
    /// 检查用户是否安装微信，微信已安装为true，未安装为false
    public static var isWeChatInstalled: Bool {
        return WXApi.isWXAppInstalled()
    }

    /// 判断当前微信的版本是否支持OpenApi，支持为true，不支持为false
    public static var isWeChatSupport: Bool {
        return WXApi.isWXAppSupport()
    }

    /// 微信的itunes安装地址
    public static var weChatInstallUrl: String {
        return WXApi.getWXAppInstallUrl()
    }

    /// 当前微信SDK的版本号
    public static var version: String {
        return WXApi.getVersion()
    }

    /**
     向微信终端程序注册第三方应用。

     需要在每次启动第三方应用程序时调用。

     请保证在主线程中调用此函数

     - parameter appID:         微信开发者ID
     - parameter universalLink: 微信开发者Universal Link

     - returns: 成功返回true，失败返回false
     */
    @discardableResult
    public static func registerApp(_ appID: String, universalLink: String) -> Bool {
        return WXApi.registerApp(appID, universalLink: universalLink)
    }

    /**
     接受微信的log信息（byBlock）

     注意1: SDK会强引用这个block，注意不要导致内存泄漏

     注意2: 调用过一次startLog by block之后，如果再调用一次任意方式的startLoad，会释放上一次logBlock，不再回调上一个logBlock

     - parameter level:    打印log的级别
     - parameter logBlock: 打印log的回调block
     */
    public static func startLog(by level: WXLogLevel, logBlock: @escaping WXLogBolock) {
        WXApi.startLog(by: level, logBlock: logBlock)
    }

    /**
     接受微信的log信息（byDelegate）

     注意1: SDK会弱引用这个delegate，这里可加任意对象为代理，不需要与WXApiDelegate同一个对象

     注意2: 调用过一次startLog by delegate之后，再调用一次任意方式的startLoad，不会再回调上一个logDelegate对象

     - parameter level:       打印log的级别
     - parameter logDelegate: 打印log的回调代理
     */
    public static func startLog(by level: WXLogLevel, logDelegate: WXApiLogDelegate) {
        WXApi.startLog(by: level, logDelegate: logDelegate)
    }

    /**
     停止打印log，会清理block或者delegate为空，释放block
     */
    public static func stopLog() {
        WXApi.stopLog()
    }

    /**
     打开微信

     - returns: 成功返回true，失败返回false
     */
    @discardableResult
    public static func openWeChat() -> Bool {
        return WXApi.openWXApp()
    }

    /**
     处理旧版微信通过URL启动App时传递的数据

     需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。

     - parameter url:      微信启动第三方应用时传递过来的URL
     - parameter delegate: WXApiDelegate对象，用来接收微信触发的消息。

     - returns: 成功返回true，失败返回false
     */
    public static func handleOpen(_ url: URL, delegate: WXApiDelegate?) -> Bool {
        return WXApi.handleOpen(url, delegate: delegate)
    }

    /**
     处理微信通过Universal Link启动App时传递的数据
     
     需要在 application:continueUserActivity:restorationHandler:中调用。
     
     - parameter userActivity: 微信启动第三方应用时系统API传递过来的userActivity
     - parameter delegate:     WXApiDelegate对象，用来接收微信触发的消息。
     
     - returns: 成功返回true，失败返回false
     */
    public static func handleOpenUniversalLink(_ userActivity: NSUserActivity, delegate: WXApiDelegate?) -> Bool {
        return WXApi.handleOpenUniversalLink(userActivity, delegate: delegate)
    }

    /**
     发送请求到微信，等待微信返回onResp

     函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型SendAuthReq、SendMessageToWXReq、PayReq等。

     - parameter req:        具体的发送请求。
     - parameter completion: 调用结果回调block
     */
    public static func send(_ req: BaseReq, completion: ((Bool) -> Void)? = nil) {
        WXApi.send(req, completion: completion)
    }

    /**
     收到微信onReq的请求，发送对应的应答给微信，并切换到微信界面

     函数调用后，会切换到微信的界面。第三方应用程序收到微信onReq的请求，异步处理该请求，完成后必须调用该函数。可能发送的相应有GetMessageFromWXResp、ShowMessageFromWXResp等。

     - parameter resp:       具体的应答内容
     - parameter completion: 调用结果回调block
     */
    public static func send(_ resp: BaseResp, completion: ((Bool) -> Void)? = nil) {
        WXApi.send(resp, completion: completion)
    }

    /**
     发送Auth请求到微信，支持用户没安装微信，等待微信返回onResp

     函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持SendAuthReq类型。

     - parameter req:            具体的发送请求。
     - parameter viewController: 当前界面对象。
     - parameter delegate:       WXApiDelegate对象，用来接收微信触发的消息。
     - parameter completion:     调用结果回调block
     */
    public static func sendAuthReq(_ req: SendAuthReq, viewController: UIViewController, delegate: WXApiDelegate?, completion: ((Bool) -> Void)? = nil) {
        WXApi.sendAuthReq(req, viewController: viewController, delegate: delegate, completion: completion)
    }
    
    /**
     发送打开小程序的命令
     
     - parameter userName 用户名
     - parameter path 小程序中的路径
     - parameter type 小程序中的类型
     */
    public static func launchMiniProgram(_ userName: String, path: String?, type: WXMiniProgramType) {
        let launchMiniProgramReq = WXLaunchMiniProgramReq.object()
        launchMiniProgramReq.userName = userName
        launchMiniProgramReq.path = path
        launchMiniProgramReq.miniProgramType = type
        WXApi.send(launchMiniProgramReq, completion: nil)
    }
}
