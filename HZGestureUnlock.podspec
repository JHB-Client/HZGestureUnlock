Pod::Spec.new do |s|
  s.name         = "HZGestureUnlock"
  s.version      = "0.0.1"
  s.summary      = "手势解锁"

  s.description  = <<-DESC
                      手势解锁的代码整理
                   DESC

  s.homepage     = "https://github.com/jihuaibin2015/HZGestureUnlock"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "jihuaibin2015" => "15158863897@163.com" }


  s.platform     = :ios

  s.source       = { :git => "https://github.com/jihuaibin2015/HZGestureUnlock.git", :tag => "0.0.1" }
  s.source_files  = "HZGestureUnlock/**/*.{h,m}"
  s.requires_arc = true
end

