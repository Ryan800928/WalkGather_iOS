#指定編譯的平台與版本
platform :ios, '11.0'
#開啟管理套件設定
install! 'cocoapods',
#這個先不解釋，對你來說太難
disable_input_output_paths: true,
#將每一個使用的套件改成一個專案檔，讓Xcode讀取速度變快
generate_multiple_pod_projects: true


target 'WalkGather' do
  # Comment the next line if you don't want to use dynamic frameworks
  # 如果你的專案是Swift這個一定要開，所謂「開」就是前面不要有#，#表示該行不生效
	use_frameworks!
	# 你要安裝的套件，看寫套件的人要你怎麼寫
	# https://github.com/kciter/Floaty
	# pod 'Floaty', '~> 4.2.0'
  # Pods for WalkGather

  pod 'Firebase/Auth'
  pod 'GoogleSignIn'

end
