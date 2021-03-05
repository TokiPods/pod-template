#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = '${POD_NAME}'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ${POD_NAME}.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/${USER_NAME}/${POD_NAME}'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '${USER_NAME}' => '${USER_EMAIL}' }
  s.source           = { :git => 'https://github.com/${USER_NAME}/${POD_NAME}.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  #Framework模式
  s.subspec 'FrameworkMode' do |fm|
    fm.vendored_frameworks = '${POD_NAME}/${POD_NAME}SDK/*.framework'
  end
  
  #源码模式
  s.subspec 'SourceMode' do |sm|
    sm.source_files = [
        '${POD_NAME}/Classes/**/*'
        '${POD_NAME}/Interface/**/*.m'
      ]
    sm.public_header_files = [
        '${POD_NAME}/Classes/**/*.h'
      ]
  end

  #对外接口
  s.subspec 'Interface' do |interface|
    interface.source_files = [
      '${POD_NAME}/Interface/**/*.h',
    ]
    interface.public_header_files = [
      '${POD_NAME}/Interface/**/*.h'
    ]
  end

  #核心代码
  s.subspec 'Core' do |core|
    # FX=all pod install; 所有库都使用framework模式安装
    isAllFX = ENV['FX'] == "all" || ENV['${POD_NAME}_FX'] == "all"; 
    # FX=dependency pod install; 依赖库使用framework模式安装
    isDependencyFX = ENV['FX'] == "dependency" || ENV['${POD_NAME}_FX'] == "dependency"; 
    isDependency = !!__FILE__[".cocoapods/repos"];
    if isAllFX || (isDependency && isDependencyFX)
      core.dependency '${POD_NAME}/FrameworkMode'
    else
      core.dependency '${POD_NAME}/SourceMode'
      core.dependency '${POD_NAME}/Interface'
    end

    # core.resource_bundles = {
    #   '${POD_NAME}' => ['${POD_NAME}/Assets/*.png']
    # }

    # core.public_header_files = 'Pod/Classes/**/*.h'
    # core.frameworks = 'UIKit', 'MapKit'
    # core.dependency 'AFNetworking', '~> 2.3'
  end
  s.default_subspec = 'Core'
end
