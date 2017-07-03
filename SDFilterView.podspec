#
#  Be sure to run `pod spec lint SDFilterView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SDFilterView"
  s.version      = "0.0.1"
  s.summary      = "类似于美团的下拉菜单"


  s.homepage     = "https://github.com/chenkefeng/SDFilterView"
  s.screenshots  = "SDFilterView.gif"
  
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "陈克锋" => "chenkefeng@kuaicto.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/chenkefeng/SDFilterView.git", :tag => "#{s.version}" }

  s.source_files  = "SDFilterViewDemo/SDFilterView/**/*.{h,m}"

  s.public_header_files = "SDFilterViewDemo/SDFilterView/SDFilterViewManager.h"


  s.requires_arc = true


end
