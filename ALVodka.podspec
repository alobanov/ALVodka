Pod::Spec.new do |s|
    s.name             = 'ALVodka'
    s.version          = '0.2'
    s.summary          = 'Advanced Swift framework for showing alerts and notifications'
    s.description  = <<-EOS
    Advanced Swift framework for showing alerts and notifications [more](https://github.com/alobanov/ALVodka).
    EOS

    s.homepage         = 'https://github.com/alobanov/ALVodka'
    s.license          = 'MIT'
    s.author           = 'Aleksey Lobanov'
    s.social_media_url = 'https://twitter.com/alobanov'
    s.source           = { :git => 'https://github.com/alobanov/ALVodka.git', :tag => s.version }

    s.ios.deployment_target = '8.0'

    s.source_files  = 'Vodka/**/*'
    # s.watchos.exclude_files = 'Sources/ImageLoadingView.swift'
end
