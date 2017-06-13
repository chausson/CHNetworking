
Pod::Spec.new do |s|
    
  s.name         = "CHNetworking"
  s.version      = "0.5.0" 
  s.summary      = "The Network Base On AFNetworking 3.0.4"
  s.description  = "下载文件接收方法错误导致无法使用下载api" 
  s.homepage     = "https://github.com/chausson/CHNetworking.git"
  s.license      = "MIT"
  s.author       = { "Chausson" => "232564026@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/chausson/CHNetworking.git", :tag => s.version }
  s.source_files  = "CHNetworking/Classes/*.{h,m}","CHNetworking/Classes/CHModel/*.{h,m}"
  s.dependency "AFNetworking", "~> 3.0.4"
 
end

