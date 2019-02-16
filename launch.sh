export sdkTools=sdk-tools-linux-4333796
export JAVA_HOME=/home/claudio/Downloads/apps/jdk1.8.0_201
export ANDROID_SDK_ROOT=/home/claudio/Downloads/git/android-emu/sdk-tools/$sdkTools

if [ ! -d "sdk-tools/$sdkTools" ]; then
  wget -P sdk-tools https://dl.google.com/android/repository/$sdkTools.zip
  unzip sdk-tools/$sdkTools.zip -d sdk-tools/$sdkTools
  rm sdk-tools/$sdkTools.zip

  yes | ./sdk-tools/$sdkTools/tools/bin/sdkmanager "platform-tools" "platforms;android-25" "emulator" "system-images;android-25;google_apis;x86"
touch /home/claudio/.android/repositories.cfg
  ./sdk-tools/$sdkTools/tools/bin/avdmanager create avd --name test --package "system-images;android-25;google_apis;x86" --device "Nexus 5X"
fi

./sdk-tools/$sdkTools/tools/bin/sdkmanager --update
exec ./sdk-tools/$sdkTools/tools/emulator @test > /dev/null &
