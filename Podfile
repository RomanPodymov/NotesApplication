platform :ios, '14.0'

target 'NotesApplicationApp' do
  use_frameworks!

  pod 'JSONModel', '1.8.0'
  pod 'UIColor+Hex', '1.0.1'
  pod 'XMLDictionary'
  pod 'BlocksKit'
  pod 'PAPreferences'
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
