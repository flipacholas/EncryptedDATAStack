#
# Be sure to run `pod lib lint EncryptedDATAStack.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EncryptedDATAStack'
  s.version          = '1.0.0'
  s.summary          = 'Set up your encrypted database with only 1 line of code!'

  s.description      = <<-DESC
Build your encrypted database with only 1 line of code. An extension of DATAStack with support of Encryption.
                       DESC

  s.homepage         = 'https://github.com/flipacholas/EncryptedDATAStack'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rodrigo Copetti' => 'rodrigo.copetti@outlook.com' }
  s.source           = { :git => 'https://github.com/flipacholas/EncryptedDATAStack.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/flipacholas'

  s.ios.deployment_target = '8.0'
  s.source_files = 'EncryptedDATAStack/Classes/**/*'
  
  # s.resource_bundles = {
  #   'EncryptedDATAStack' => ['EncryptedDATAStack/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'Foundation', 'CoreData'
    s.dependency 'EncryptedCoreData', '~> 3.1'
end
