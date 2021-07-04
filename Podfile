deployment_target = '12.0'
platform :ios, deployment_target
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'

install! 'cocoapods',
         :generate_multiple_pod_projects => true

abstract_target 'Base' do
  pod 'Alamofire'
  pod 'Resolver'
  pod 'MaterialComponents/Cards'
  pod 'MaterialComponents/Buttons'
  pod 'MaterialComponents/Buttons+Theming'
  pod 'SDWebImage'

  target 'Times'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
    end
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
      end
    end
  end
end