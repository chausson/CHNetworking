
    
  s.name         = "CHNetworking"
  s.version      = "0.5.2" 
  s.summary      = "The Network Base On AFNetworking 3.1.0"
  s.description  = "将引用AFNetworking从3.0.4升级到3.1.0" 
  s.homepage     = "https://github.com/chausson/CHNetworking.git"
  s.license      = "MIT"
  s.author       = { "Chausson" => "232564026@qq.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/chausson/CHNetworking.git", :tag => s.version }
  s.source_files  = "CHNetworking/Classes/*.{h,m}","CHNetworking/Classes/CHModel/*.{h,m}"
  s.dependency "AFNetworking", "~> 3.1.o"
 
end

