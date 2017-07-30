#
# Be sure to run `pod lib lint FileManager-Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FileManager-Swift'
  s.version          = '0.2.0'
  s.summary          = 'FileManager for ios apps that involves downloading contents.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
FileManager for ios apps that involves downloading contents, Install library to project, never have to write and make your file manager, pod made entirely by code without using storyboard which makes it easier for anyone to use, implement, support all screen sizes and can work for projects that doesn't use storyboards!
                       DESC

  s.homepage         = 'https://github.com/Mahmoud333/FileManager-Swift'
#s.screenshots      = 'https://ibb.co/kW3dsv', 'https://ibb.co/d2tYQF','https://ibb.co/mbk2Ka'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mahmoud333' => 'mahmoud_smgl@hotmail.com' }
  s.source           = { :git => 'https://github.com/Mahmoud333/FileManager-Swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MahmoudSMGL'

  s.ios.deployment_target = '9.0'

  s.source_files = 'FileManager-Swift/Classes/**/*'
  
  s.resource_bundles = {
    #'FileManager-Swift' => ['FileManager-Swift/Assets/*.png', 'FileManager-Swift/Assets/icons.xcassets']
    #'FileManager-Swift' => ['FileManager-Swift/Assets/icons.xcassets']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
