baseDir=$(dirname "$0")
sdkTools=sdk-tools-linux-4333796
sdkPath=$baseDir/sdk-tools/$sdkTools
version=28

export ANDROID_SDK_ROOT=$sdkPath

if [ -z "$JAVA_HOME" ]; then
  echo "JAVA_HOME not found"
  exit
fi

if [ ! -d "$sdkPath" ]; then
  wget -P sdk-tools https://dl.google.com/android/repository/$sdkTools.zip
  unzip $sdkPath.zip -d $sdkPath
  rm $sdkPath.zip

  yes | $sdkPath/tools/bin/sdkmanager "platform-tools" "platforms;android-$version" "emulator" "system-images;android-$version;google_apis;x86"
touch /home/claudio/.android/repositories.cfg
  $sdkPath/tools/bin/avdmanager delete avd --name test
  $sdkPath/tools/bin/avdmanager create avd --name test --package "system-images;android-$version;google_apis;x86" --device "Nexus 5X"
fi

$sdkPath/tools/bin/sdkmanager --update
exec $sdkPath/emulator/emulator @test > /dev/null &

curDateSecs=$(date +%s)
lastUpdate=$(cat last-update)
checkUpdatePeriod=$(expr 86400 \* 90) # 90 days
updateEnding=$(expr $lastUpdate + $checkUpdatePeriod)

if [ "$curDateSecs" -lt "$updateEnding" ]; then
  echo "Check sdk-tools-linux and sdk version updates"
  echo "This message will be printed once"
  date +%s > last-update
fi
