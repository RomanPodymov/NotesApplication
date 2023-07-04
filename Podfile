platform :ios, '14.0'

target 'NotesApplicationApp' do
  use_frameworks!

  pod 'JSONModel', '1.8.0'
  pod 'UIColor+Hex', '1.0.1'
  pod 'XMLDictionary', '1.4.1'
  pod 'BlocksKit', '2.2.5'
  pod 'PAPreferences', '0.5'
  pod 'SVProgressHUD', '2.2.5'
  pod 'AFNetworking', '3.2.1'
  pod 'PromiseKit', '8.0.0'
  pod 'PureLayout', '3.1.9'
  pod 'Hero', '1.6.2'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
  end
end
