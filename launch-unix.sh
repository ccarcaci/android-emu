baseDir=$(dirname "$0")
sdkTools=sdk-tools-linux-4333796
sdkPath=$baseDir/sdk-tools/$sdkTools
version=29

if [ -z "$JAVA_HOME" ]; then
  echo "JAVA_HOME not found"
  exit
fi

if [ ! -d "$sdkPath" ]; then
  wget -P sdk-tools https://dl.google.com/android/repository/$sdkTools.zip
  unzip $sdkPath.zip -d $sdkPath
  rm $sdkPath.zip

  yes | $sdkPath/tools/bin/sdkmanager "platform-tools" "platforms;android-$version" "emulator" "system-images;android-$version;google_apis;x86"
  touch $HOME/.android/repositories.cfg
  $sdkPath/tools/bin/avdmanager delete avd --name "Nexus5X"
  $sdkPath/tools/bin/avdmanager create avd --name "Nexus5X" --package "system-images;android-$version;google_apis;x86" --device "Nexus 5X"
fi

export ANDROID_SDK_ROOT=$sdkPath

$sdkPath/tools/bin/sdkmanager --update
exec $sdkPath/emulator/emulator @Nexus5X > /dev/null &

curDateSecs=$(date +%s)
lastUpdate=$(cat $baseDir/last-update)
checkUpdatePeriod=$(expr 86400 \* 90) # 90 days
updateEnding=$(expr $lastUpdate + $checkUpdatePeriod)

if [ "$curDateSecs" -gt "$updateEnding" ]; then
  echo "Check sdk-tools-linux and sdk version updates"
  echo "This message will be printed once"
  date +%s > $baseDir/last-update
fi
