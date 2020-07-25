

Pod::Spec.new do |s|


s.name         = "QTRuntimeHelper"
s.version      = "0.1"
s.summary      = "QTRuntimeHelper"


s.description  = "QTRuntimeHelper"

s.homepage     = "https://github.com/HelloBie/QTRuntimeHelper.git"

s.license      = "MIT"

s.author             = { "不不不紧张" => "1005903848@qq.com" }

s.source       = { :git => "https://github.com/HelloBie/QTRuntimeHelper.git", :tag => "#{s.version}" }


s.ios.frameworks = 'Foundation'

s.platform     = :ios, "8.0"
s.source_files  = 'QTRuntimeHelper/QTRuntimeHelper/QTRuntimeHelper/*'

end
