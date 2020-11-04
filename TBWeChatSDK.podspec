#
#  Created by teambition-ios on 2020/7/27.
#  Copyright © 2020 teambition. All rights reserved.
#     

Pod::Spec.new do |s|
  s.name             = 'TBWeChatSDK'
  s.version          = '0.3.2'
  s.summary          = 'Swift version of WeChat SDK.'
  s.description      = <<-DESC
  Swift version of WeChat SDK.
                       DESC

  s.homepage         = 'https://github.com/teambition/WeChatSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'teambition mobile' => 'teambition-mobile@alibaba-inc.com' }
  s.source           = { :git => 'https://github.com/teambition/WeChatSDK.git', :tag => s.version.to_s }

  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'

  s.source_files = 'WeChatSDK/*.swift', 'WeChatSDK/lib/*.h'
  s.vendored_libraries = 'WeChatSDK/lib/libWeChatSDK.a'

  s.library = 'c++'
  s.frameworks = 'WebKit'

end
