
Pod::Spec.new do |s|

  s.name         = "CHNetworking"
  s.version      = "0.3.5" 
  s.summary      = "A Net Framework Base On AFNetworking 3.0.4"
  s.description  = "支持每个请求可以设置在请求体中(httpbody)传入参数." 
  s.homepage     = "https://github.com/chausson/CHNetworking.git"
  s.license      = "MIT"
  s.author       = { "Chausson" => "232564026@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/chausson/CHNetworking.git", :tag => "0.3.5"}
  s.source_files  = "CHNetworking/Classes/*.{h,m}","CHNetworking/Classes/CHModel/*.{h,m}"
  s.dependency "AFNetworking", "~> 3.0.4"
 
end

