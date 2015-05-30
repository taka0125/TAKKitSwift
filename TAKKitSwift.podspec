Pod::Spec.new do |s|
  s.name             = "TAKKitSwift"
  s.version          = "1.1.0"
  s.summary          = "Util"
  s.homepage         = "https://github.com/taka0125/TAKKitSwift"
  s.license          = 'MIT'
  s.author           = { "Takahiro Ooishi" => "taka0125@gmail.com" }
  s.source           = { :git => "https://github.com/taka0125/TAKKitSwift.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/taka0125'
  s.ios.deployment_target = "8.0"
  s.requires_arc     = true
  s.default_subspecs = 'Core', 'UserDefaults'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Classes/Core/*.swift'
  end

  s.subspec 'UserDefaults' do |ss|
    ss.dependency 'TAKKitSwift/Core'
    ss.source_files = 'Classes/UserDefaults/*.swift'
    ss.resource_bundles = {
      'TAKUserDefaults' => ['Assets/UserDefaults/*']
    }
  end
end
