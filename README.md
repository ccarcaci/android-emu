# Android Emulator by Shell

This project provides a script to run an Android emulator in Ubuntu OS. It provides a script compatible with OSX too.

The reason that makes me to build this project is that in Ubuntu in order to have a working Android emulator the installation of the entire Android Studio was needed.
Unfortunately the Android Studio suite is greedy on system resources and React Native development is mainly done using lightweight IDE like VSCode or Atom.

The need to install and run Android Studio just to obtain an emulator is excessive.

In this work I extracted the commands used by Android Studio to run the emulator.

## Prerequisites

* Shell console
* wget
* JRE, at least. JAVA_HOME variable must be filled

## How to use

Set the executable permission to the scripts:

```$ chmod +x launch-*.sh```

Run the launch-*.sh script from command line.

```$ ./launch-unix.sh```

or

```$ ./launch-mac.sh```

The first time the script runs it will take a while to download the Android SDK Tools and the emulator. The following executions will only check if there are new versions of the emulator.

### Arguments

Running the command with --reinstall-device argument will reinstall the avd.

```$ ./launch-unix.sh --reinstall-device```

```$ ./launch-mac.sh --reinstall-device```

Feel free to fork this project and modify the used Device and used commands.

I preferred to avoid the use of arguments in order to maintain the solution simple. It consists on few lines of code and by adding the possibility to specify configurations through the arguments would result in a complex and unreadable code.

I hope thet you appreciate my KISS choice.

## License

This project is distributed under [EUPL-1.2](https://eupl.eu/1.2/en).
