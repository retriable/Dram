Pod::Spec.new do |s|
s.name     = 'Dram'
s.version  = '1.0.3'
s.license  = 'MIT'
s.summary  = 'channel sort'
s.homepage = 'https://github.com/retriable/Dram'
s.author   = { 'retriable' => 'retriable@retriable.com' }
s.source   = { :git => 'https://github.com/retriable/Dram.git',:tag => "#{s.version}" }
s.description = 'channel sort by using UICollectionView'
s.requires_arc   = true
s.ios.deployment_target = '8.0'
s.source_files = 'Dram/*.{h,m}'
s.framework = 'UIKit'
end
