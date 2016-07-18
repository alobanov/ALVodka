Pod::Spec.new do |s|

  s.name         = "ALVodka"
  s.version      = "0.1"
  s.summary      = "Alert & notification view"
  s.homepage     = "https://github.com/alobanov/ALVodka"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Alexey Lobanov" => "lobanov.aw@gmail.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/alobanov/ALVodka.git" }
  s.source_files = "ALVodka/*.{h,m}"
  s.public_header_files = "ALVodka/*.{h}"
  s.framework    = "UIKit"
  s.requires_arc = true

end
