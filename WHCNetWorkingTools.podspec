Pod::Spec.new do |s|

  s.name         = "WHCNetWorkingTools"
  
  s.version      = "1.0.1"
  
  s.summary      = "基于AFNetWorking 的tools 只是有一些简单的功能使用"

  s.description  = "1.基础的GET和POST方法
                    2.可添加请求头参数的POST方法
                    3.可更改返回参数格式的的POST方法
                    4.图片链接和图片上传
                    5.文件的上传和下载（暂时只支持本地数据上传）
                    6.网络状态监测（例：可用来监测iOS 11出现的使用网络或WIFI提示出现的网络未连接出现的相关问题)网络监测"

  s.homepage     = "https://github.com/Wanghongchao12138/WHCNetWorking"

  s.license      = "MIT"

  s.author             = { "王红超" => "798907348@qq.com" }

  # s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/Wanghongchao12138/WHCNetWorking.git", :tag => "#{s.version}" }

  s.source_files  = "WHCNetWorkingTools/**/*.{h,m}"

  s.requires_arc = true

  s.dependency 'AFNetworking', '~> 3.0.0'

end
