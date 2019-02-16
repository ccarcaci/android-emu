export JAVA_HOME=/home/claudio/Downloads/apps/jdk1.8.0_181
export platformTools=platform-tools_r28.0.1-linux
export sdkTools=sdk-tools-linux-4333796
export ANDROID_SDK_ROOT=/home/claudio/Downloads/git/android-emu/sdk-tools/sdk-tools-linux-4333796/tools

if [ ! -d "platform-tools/$platformTools" ]; then
  mkdir platform-tools
  wget -P platform-tools https://dl.google.com/android/repository/$platformTools.zip
  unzip platform-tools/$platformTools.zip -d platform-tools/$platformTools
  rm platform-tools/$platformTools.zip
fi

if [ ! -d "sdk-tools/$sdkTools" ]; then
  wget -P sdk-tools https://dl.google.com/android/repository/$sdkTools.zip
  unzip sdk-tools/$sdkTools.zip -d sdk-tools/$sdkTools
  rm sdk-tools/$sdkTools.zip
fi

yes | ./sdk-tools/sdk-tools-linux-4333796/tools/bin/sdkmanager "system-images;android-25;google_apis;x86"
no | ./sdk-tools/sdk-tools-linux-4333796/tools/bin/avdmanager create avd --name test --package "system-images;android-25;google_apis;x86"
