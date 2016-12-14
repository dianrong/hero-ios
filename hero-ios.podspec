#
# Be sure to run `pod lib lint hero-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'hero-ios'
  s.version          = '1.1.4'
  s.summary          = 'A short description of hero-ios.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://www.hero-mobile.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '刘国平' => 'guoping.liu@dianrong.com' }
  s.source           = { :git => 'https://code.dianrong.com/scm/mf/hero-ios.git', :tag => s.version.to_s }
  s.social_media_url = 'http://www.hero-mobile.com'

  s.ios.deployment_target = '7.0'

  s.source_files = 'hero-ios/Classes/*'

  # s.resource_bundles = {
  #   'hero-ios' => ['hero-ios/Assets/*.png']
  # }

  s.public_header_files = 'hero-ios/Classes/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MJRefresh'
end
