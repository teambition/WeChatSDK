#WeChatSDK
Swift version of WeChat SDK.

#API Version
[1.6.2](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=open1419319164&token=&lang=zh_CN)

##How To Get Started
###Carthage
Specify "WeChatSDK" in your ```Cartfile```:
```ogdl 
github "teambition/WeChatSDK"
```

###Usage
See [WeChatSDK Integration Guide](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN)

###For iOS 9
Add code to "Info.plist" in your project as follows:
```swift
<key>LSApplicationQueriesSchemes</key>
<array>
<string>weixin</string>
</array>
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```

## Minimum Requirement
iOS 8.0

## Release Notes
* [Release Notes](https://github.com/teambition/WeChatSDK/releases)

## License
WeChatSDK is released under the MIT license. See [LICENSE](https://github.com/teambition/WeChatSDK/blob/master/LICENSE.md) for details.

## More Info
Have a question? Please [open an issue](https://github.com/teambition/WeChatSDK/issues/new)!
