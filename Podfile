platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

abstract_target 'Abstract' do

    # Helpers
    pod 'FSHelpers+Swift', :git => 'https://github.com/fs/FSHelper.git', :branch => 'master'
    pod 'KRDeviceInfo', :git => 'https://github.com/NikolaevSergey/KRDeviceInfo.git', :branch => 'master'
   
    pod 'Fabric'
    pod 'Crashlytics'
   
    #TARGETS
    target 'Froxii' do
    end

    target 'FroxiiTests' do
    end

    target 'FroxiiUITests' do
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
        end
    end
end
