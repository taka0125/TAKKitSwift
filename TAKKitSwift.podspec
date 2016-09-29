Pod::Spec.new do |s|
  s.name             = "TAKKitSwift"
  s.version          = "3.0.1"
  s.summary          = "Util"
  s.homepage         = "https://github.com/taka0125/TAKKitSwift"
  s.license          = 'MIT'
  s.author           = { "Takahiro Ooishi" => "taka0125@gmail.com" }
  s.source           = { :git => "https://github.com/taka0125/TAKKitSwift.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/taka0125'
  s.requires_arc     = true

  s.ios.deployment_target = "8.0"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

  s.subspec 'Core' do |ss|
    ss.source_files = 'Pod/Classes/Core/*.swift'
    ss.ios.source_files = 'Pod/Classes/Core/ios/*.swift'
  end

  s.subspec 'UserDefaults' do |ss|
    ss.platform = :ios
    ss.dependency 'TAKKitSwift/Core'
    ss.source_files = 'Pod/Classes/UserDefaults/*.swift'
    ss.resource_bundles = {
      'TAKUserDefaults' => ['Pod/Assets/UserDefaults/*']
    }
  end

  s.subspec 'Photo' do |ss|
    ss.platform = :ios
    ss.dependency 'TAKKitSwift/Core'
    ss.frameworks = 'Photos', 'AVFoundation'
    ss.source_files = 'Pod/Classes/Photo/*.swift'
  end

  s.subspec 'Twitter' do |ss|
    ss.platform = :ios
    ss.dependency 'TAKKitSwift/Core'
    ss.dependency 'STTwitter'
    ss.frameworks = 'Accounts'
    ss.source_files = 'Pod/Classes/Twitter/*.swift'
  end
end
