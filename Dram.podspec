Pod::Spec.new do |s|
s.name     = 'Dram'
s.version  = '1.0.1'
s.license  = 'MIT'
s.summary  = 'channel sort'
s.homepage = 'https://github.com/emsihyo/Dram'
s.author   = { 'emsihyo' => 'emsihyo@gmail.com' }
s.source   = { :git => 'https://github.com/emsihyo/Dram.git',:tag => "#{s.version}" }
s.description = 'channel sort by using UICollectionView'
s.requires_arc   = true
s.platform     = :ios
s.ios.deployment_target = '8.0'
s.source_files = 'Dram/*.{h,m}'
end
