//
//  ExampleViewController.swift
//  WeChatSDKExample
//
//  Created by Xin Hong on 16/4/25.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit
import WeChatSDK

private let kWeChatSDKExampleCellID = "WeChatSDKExampleCell"

class ExampleViewController: UITableViewController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Helper
    fileprivate func setupUI() {
        navigationItem.title = "WeChatSDK"
        tableView.tableFooterView = UIView()
    }

    fileprivate func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in

        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ExampleViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 3
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Infos"
        case 1: return "Actions"
        default: return nil
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kWeChatSDKExampleCellID)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: kWeChatSDKExampleCellID)
        }
        cell?.detailTextLabel?.textColor = UIColor.purple

        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell?.textLabel?.text = "WeChat Installed"
            cell?.detailTextLabel?.text = "\(WeChatSDK.isWeChatInstalled)"
        case (0, 1):
            cell?.textLabel?.text = "WeChat Support Api"
            cell?.detailTextLabel?.text = "\(WeChatSDK.isWeChatSupport)"
        case (0, 2):
            cell?.textLabel?.text = "WeChat Install URL"
            cell?.detailTextLabel?.text = "\(WeChatSDK.weChatInstallUrl)"
        case (0, 3):
            cell?.textLabel?.text = "API Version"
            cell?.detailTextLabel?.text = "\(WeChatSDK.version)"
        case (1, 0):
            cell?.textLabel?.text = "Open WeChat"
        case (1, 1):
            cell?.textLabel?.text = "Sign in with WeChat"
        case (1, 2):
            cell?.textLabel?.text = "Share to WeChat"
        default:
            break
        }

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch (indexPath.section, indexPath.row) {
        case (0, 2):
            if let wechatURL = URL(string: WeChatSDK.weChatInstallUrl), UIApplication.shared.canOpenURL(wechatURL) {
                UIApplication.shared.openURL(wechatURL)
            }
        case (1, 0):
            if !WeChatSDK.isWeChatInstalled {
                showAlert(withTitle: "WeChat is not installed", message: nil)
            } else if !WeChatSDK.isWeChatSupport {
                showAlert(withTitle: "API is not supported", message: nil)
            } else {
                if WeChatSDK.openWeChat() {
                    print("Open WeChat App Successfully")
                } else {
                    showAlert(withTitle: "Failed to open WeChat", message: nil)
                }
            }
        case (1, 1):
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "your state code"
            if WeChatSDK.sendAuthReq(req, viewController: self, delegate: self) {

            } else {
                showAlert(withTitle: "Failed to Sign in", message: nil)
            }
        case (1, 2):
            let req = SendMessageToWXReq()
            req.bText = true
            req.text = "It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way—in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only."
            if WeChatSDK.send(req) {

            } else {
                showAlert(withTitle: "Failed to share", message: nil)
            }
        default:
            break
        }
    }
}

extension ExampleViewController: WXApiDelegate {
    func onResp(_ resp: BaseResp) {

    }

    func onReq(_ req: BaseReq) {

    }
}
