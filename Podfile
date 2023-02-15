# Uncomment the next line to define a global platform for your project

platform :ios, '14.0'
inhibit_all_warnings!

target 'FANNI-iOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FANNI-iOS


  # Lint 
  pod 'SwiftLint', '~> 0.49.1'

	
	# Architecture
	pod 'ReactorKit', '~> 3.2.0'
	pod 'RxFlow', '~> 2.13.0'

	
	# Rx
	pod 'RxSwift', '~> 6.5.0'
	pod 'RxCocoa', '~> 6.5.0'
	pod 'RxDataSources', '~> 5.0.0'
	pod 'RxViewController', '~> 2.0.0'
	pod 'RxGesture', '~> 4.0.4'
	pod 'RxAlamofire', '~> 6.1.1'
  
	
	# UI 
	pod 'SnapKit', '~> 5.6.0'


  # Network
	pod 'Alamofire', '~> 5.6.2'
	pod 'Kingfisher', '~> 7.0'

	
	#Auth
	pod 'KakaoSDKCommon'
	pod 'RxKakaoSDKCommon'
	pod 'KakaoSDKAuth'
	pod 'RxKakaoSDKAuth'
	pod 'KakaoSDKUser'
	pod 'RxKakaoSDKUser'

	
  # Misc
 	pod 'URLNavigator', '~> 2.4.1'


  target 'FANNI-iOSTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FANNI-iOSUITests' do
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
  end
end

