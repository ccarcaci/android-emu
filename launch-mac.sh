baseDir=$(dirname "$0")
sdkTools=sdk-tools-darwin-4333796
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
fi

if [ "$1" == "--reinstall-device" ]; then
  yes | $sdkPath/tools/bin/sdkmanager "platform-tools" "platforms;android-$version" "emulator" "system-images;android-$version;google_apis_playstore;x86_64"
  touch $HOME/.android/repositories.cfg
  $sdkPath/tools/bin/avdmanager delete avd --name "Pixel"
  $sdkPath/tools/bin/avdmanager create avd --name "Pixel" --package "system-images;android-$version;google_apis_playstore;x86_64" --device "pixel"
fi

export ANDROID_SDK_ROOT=$sdkPath

$sdkPath/tools/bin/sdkmanager --update
exec $sdkPath/emulator/emulator @Pixel > /dev/null &

curDateSecs=$(date +%s)
lastUpdate=$(cat $baseDir/last-update)
checkUpdatePeriod=$(expr 86400 \* 90) # 90 days
updateEnding=$(expr $lastUpdate + $checkUpdatePeriod)

if [ "$curDateSecs" -gt "$updateEnding" ]; then
  echo "*************************************************"
  echo "* Check sdk-tools-linux and sdk version updates *"
  echo "* This message will be printed once             *"
  echo "* Link below                                    *"
  echo "*************************************************"
  echo "https://developer.android.com/studio/?gclid=CjwKCAiAjrXxBRAPEiwAiM3DQpEZ4I-DSCnFic2f13Xdt8zdfxUcmi118B8HJNF5zuA-ioSfvws5BBoCW2IQAvD_BwE#command-tools"
  date +%s > $baseDir/last-update
fi
