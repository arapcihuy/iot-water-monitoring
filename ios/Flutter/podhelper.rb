#!/usr/bin/ruby

# Install pods needed to embed Flutter plugins into an iOS application.
def flutter_install_all_ios_pods(flutter_application_path)
  flutter_root = File.expand_path(File.join(flutter_application_path, '..', '..'))
  pod 'Flutter', :path => File.join(flutter_application_path, '.ios', 'Flutter', 'Flutter.podspec')
end