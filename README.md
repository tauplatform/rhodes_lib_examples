# rhodes_lib_examples
Examples of native applications with using of Rhodes as standalone lib inside native platform application.

RhodesApp - Rhodes application (contain ruby code for native applications on iOS, Android, etc.)

Native_iOS - Native iOS example.

# for iOS
1. go to RhodesApp folder
2. prepare Rhodes framework for iOS projects (already linked in Native_iOS example) - framework should be placed into Native_iOS folder !

<pre>rake build:iphone:rhodeslib_framework["<fullpath>/Native_iOS"]</pre>

3. prepare Rhodes application bundle (already linked in Native_iOS example) - folder RhoBundle should be placed in root of XCode project folder !

<pre>rake build:iphone:rhodeslib_bundle["<fullpath>/Native_iOS"]</pre>

4. if you want to link framework and bundle into your already exist XCode project make nextsteps after generate framework andbundle :
Drag and Drop bundle folder into root of XCode project (when it open in XCode) - make reference to folder option
Drag and Drop framework into root of XCode project (when it open in XCode) and after it add framework into embedded binary list (general option of project)

5. open and run XCode project. There are 5 examples located in this file - https://github.com/tauplatform/rhodes_lib_examples/blob/master/Native_iOS/Native_iOS/ViewController.m
Examples can be executed from main application screen by buttons.
