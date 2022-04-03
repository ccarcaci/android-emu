set -e

basePath=$PWD/sdk-tools
unzipPath=$basePath
sdkTools=commandlinetools-linux-7583922_latest
version=31

if [ -z "$JAVA_HOME" ]; then
  echo "JAVA_HOME not found"
  exit
fi

if [ ! -d "$basePath" ]; then
  wget -P $basePath https://dl.google.com/android/repository/$sdkTools.zip

  unzip $basePath/$sdkTools.zip -d $basePath
  rm $basePath/$sdkTools.zip

  mv $basePath/cmdline-tools $basePath/latest
  mkdir $basePath/cmdline-tools
  mv $basePath/latest $basePath/cmdline-tools
fi

export PATH=$PATH:$basePath/cmdline-tools/latest/bin:$basePath/emulator

if [ "$1" == "--reinstall-device" ]; then
  yes | sdkmanager "platform-tools" "platforms;android-$version" "emulator" "system-images;android-$version;default;x86_64"
  touch $HOME/.android/repositories.cfg
  avdmanager delete avd --name "Pixel" || true
  avdmanager create avd --name "Pixel" --package "system-images;android-$version;google_apis_playstore;x86_64" --device "pixel"
fi

sdkmanager --update
exec emulator @Pixel > /dev/null &

curDateSecs=$(date +%s)
lastUpdate=$(cat $PWD/last-update)
checkUpdatePeriod=$(expr 86400 \* 90) # 90 days
updateEnding=$(expr $lastUpdate + $checkUpdatePeriod)

if [ "$curDateSecs" -gt "$updateEnding" ]; then
  echo "*************************************************"
  echo "* Check sdk-tools-linux and sdk version updates *"
  echo "* This message will be printed once             *"
  echo "* Link below                                    *"
  echo "*************************************************"
  echo "https://developer.android.com/studio#command-tools"
  date +%s > $PWD/last-update
fi
