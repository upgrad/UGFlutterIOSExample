# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
xcodeproj 'UGFlutterIOSExample', 'StagingDebug' => :debug, 'StagingRelease' => :release

flutter_application_path = "../UGFlutter/flutter"

plugin 'cocoapods-integrate-flutter' , {
  :flutter_application_path => "#{flutter_application_path}"
}

target 'UGFlutterIOSExample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'UGFlutter', :path => '../UGFlutter/'
  pod 'Flutter', :path => "#{flutter_application_path}/.ios/Flutter/engine/"
  pod 'FlutterPluginRegistrant', :path => "#{flutter_application_path}/.ios/Flutter/FlutterPluginRegistrant/"
  pod 'path_provider', :path => "#{flutter_application_path}/.ios/Flutter/.symlinks/path_provider/ios"

  # Pods for UGFlutterIOSExample

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
