Pod::Spec.new do |s|
s.name         = "Flop"
s.version      = "1.1.0"
s.summary      = "Flop animations.Imitating Jingdong, palm reading, sign in animation."
s.homepage     = "https://github.com/wsj2012/Flop"
s.license      = "MIT"
s.author             = { "wsj_2012" => "time_now@yeah.net" }
s.source       = { :git =>    "https://github.com/wsj2012/Flop.git", :tag => "#{s.version}" }
s.requires_arc = true
s.ios.deployment_target = "8.0"
s.source_files  = "FlopView/*.{h,m}"
end
