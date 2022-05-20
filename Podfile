# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def 	shared_pods
	pod 'Firebase/Firestore'
      	pod 'Firebase/Auth'
  	pod 'Firebase/Storage'
  	pod 'Firebase/Core'
	pod 'IQKeyboardManagerSwift'
	pod 'Kingfisher', '~> 7.0'
	pod 'CodableFirebase'
end
    

target 'ShoppingAdmin' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ShoppingAdmin
  shared_pods
  pod 'CropViewController'

end

target 'ShoppingApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ShoppingApp
  shared_pods
  pod 'Stripe'
  pod 'Alamofire', '~> 5.5'

end
