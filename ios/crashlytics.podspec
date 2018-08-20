#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'crashlytics'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for (Firebase) Crashlytics on Android and iOS.'
  s.description      = <<-DESC
Flutter plugin for (Firebase) Crashlytics on Android and iOS.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Fabric'
  s.dependency 'Crashlytics'
  
  s.ios.deployment_target = '8.0'
end

