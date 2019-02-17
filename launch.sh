export JAVA_HOME=/home/claudio/Downloads/apps/jdk1.8.0_201

baseDir=$(dirname "$0")
sdkTools=sdk-tools-linux-4333796
sdkPath=sdk-tools/$sdkTools
version=28
export ANDROID_SDK_ROOT=$baseDir/$sdkPath

if [ ! -d "$sdkPath" ]; then
  wget -P sdk-tools https://dl.google.com/android/repository/$sdkTools.zip
  unzip $sdkPath.zip -d $sdkPath
  rm $sdkPath.zip

  yes | $baseDir/$sdkPath/tools/bin/sdkmanager "platform-tools" "platforms;android-$version" "emulator" "system-images;android-$version;google_apis;x86"
touch /home/claudio/.android/repositories.cfg
  $baseDir/$sdkPath/tools/bin/avdmanager delete avd --name test
  $baseDir/$sdkPath/tools/bin/avdmanager create avd --name test --package "system-images;android-$version;google_apis;x86" --device "Nexus 5X"
fi

$baseDir/$sdkPath/tools/bin/sdkmanager --update
exec $baseDir/$sdkPath/emulator/emulator @test > /dev/null &
