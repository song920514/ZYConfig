#
# Be sure to run `pod lib lint ZYConfig.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

# https://cloud.tencent.com/developer/article/1336125 生成教程
#$ pod lib lint --allow-warnings
#若还是提示什么 'echo "2.3" > .swift-version' 的,就加这么一个东西。
#$ echo "2.3" > .swift-version 然后在进行验证,这是应该就可以了。若还是不行,回到配置文件中检查有没有写错配置信息~

#给仓库打标签 git tag -m 'first release' '1.0.1'
#推送tag到远端仓库 git push --tag
#pod trunk push ZYConfig.podspec  pod spec lint ZYConfig.podspec --allow-warnings

Pod::Spec.new do |s|
  s.name             = 'ZYConfig'
  s.version          = '0.1.1'
  s.summary          = '这是一个公有的swift 基类处理库.' # 这里必须修改，不修改的话下面的验证时会报错

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/song920514/ZYConfig'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'song920514@163.com' => 'song920514@163.com' }
  s.source           = { :git => 'https://github.com/song920514/ZYConfig.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ZYConfig/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZYConfig' => ['ZYConfig/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'SnapKit', '~>4.2.0'
  s.dependency 'SwiftyJSON', '~>4.2.0'
  s.dependency 'Moya', '~>11.0.2'

end
