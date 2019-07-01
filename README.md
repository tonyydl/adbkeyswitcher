# adbkeyswitcher
The switcher allow user to specify adbkey settings.

## Installation

```
$ git clone git@github.com:tonyyang924/adbkeyswitcher.git
$ chmod +x adbkeyswitcher/switch_adbkey.sh  
$ ./adbkeyswitcher/switch_adbkey.sh set default ~/adbkey_store/adbkey:adbkey,~/adbkey_store/adbkey.pub:adbkey.pub
$ ./adbkeyswitcher/switch_adbkey.sh set work ~/adbkey_store/work_adbkey:adbkey
```

## Usage

```
$ ./adbkeyswitcher/switch_adbkey.sh default
Backup old adbkeys...
Switch to [default] adb key...
Copy /Users/tonyyang/adbkey_store/adbkey to /Users/tonyyang/.android/adbkey
Copy /Users/tonyyang/adbkey_store/adbkey.pub to /Users/tonyyang/.android/adbkey.pub
* daemon not running; starting now at tcp:5037
* daemon started successfully

$ ./adbkeyswitcher/switch_adbkey.sh work
Backup old adbkeys...
Switch to [work] adb key...
Copy /Users/tonyyang/adbkey_store/work_adbkey to /Users/tonyyang/.android/adbkey
* daemon not running; starting now at tcp:5037
* daemon started successfully
```
