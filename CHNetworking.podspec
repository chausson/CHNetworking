
Pod::Spec.new do |s|

  s.name         = "CHNetworking"
  s.version      = "0.4.6" 
  s.summary      = "A Net Framework Base On AFNetworking 3.0.4"
  s.description  = "恢复误删错误引用类的问题" 
  s.homepage     = "https://github.com/chausson/CHNetworking.git"
  s.license      = "MIT"
  s.author       = { "Chausson" => "232564026@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/chausson/CHNetworking.git", :tag => "0.4.6"}
  s.source_files  = "CHNetworking/Classes/*.{h,m}","CHNetworking/Classes/CHModel/*.{h,m}"
  s.dependency "AFNetworking", "~> 3.0.4"
 
end

