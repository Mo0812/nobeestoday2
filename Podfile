# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'No Bees Today' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for No Bees Today
  pod 'RealmSwift'
  pod 'Toast-Swift'
  pod 'Charts'
  pod 'AcknowList'

end

post_install do | installer |
  system("sh tools/copyAcknowledgments.sh")
end
