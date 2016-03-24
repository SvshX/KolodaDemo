source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.2'

use_frameworks!

xcodeproj 'KolodaDemo'

target :KolodaDemo, :exclusive => true do

pod 'Koloda'
pod 'Alamofire', '~> 3.1.1'

end

post_install do |installer|
`find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
end