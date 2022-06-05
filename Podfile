# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

workspace 'Entities'

target 'Entities' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Entities
  pod 'Moya', '~> 15.0'
  pod 'Swinject'
  pod 'ReachabilitySwift'
  pod 'SVProgressHUD'

  target 'EntitiesTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'EntCore' do
  project 'EntCore/EntCore.xcproj'
  use_frameworks!
  
  pod 'Swinject'
  pod 'Moya', '~> 15.0'
  pod 'ReachabilitySwift'
  pod 'SVProgressHUD'
  
  target 'EntCoreTests' do
    pod 'Swinject'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
