#!/usr/bin/ruby

require 'json'

# Install pods needed to embed Flutter plugins into an iOS application.
def flutter_install_all_ios_pods(flutter_application_path)
  flutter_root = File.expand_path(File.join(flutter_application_path, '..', '..'))
  ios_application_path = File.expand_path(File.join(flutter_application_path, '..'))
  flutter_podspec = File.join(flutter_root, 'packages', 'flutter_tools', 'gradle', 'flutter.podspec')

  install_flutter_pod(flutter_application_path, ios_application_path, flutter_podspec)
end

def install_flutter_pod(flutter_application_path, ios_application_path, flutter_podspec)
  pod 'Flutter', :path => File.join(flutter_application_path, '.ios', 'Flutter', 'Flutter.podspec')
end
