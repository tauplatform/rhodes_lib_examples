# rhodes_lib_examples
Examples of native applications with using of Rhodes as standalone lib inside native platform application.

RhodesApp - Rhodes application (contain ruby code for native applications on iOS, Android, etc.)

Native_iOS - Native iOS example.

Native_Android - Native Android example (for Android Studio)

# for iOS

1. go to RhodesApp folder
2. prepare Rhodes framework for iOS projects (already linked in Native_iOS example) - framework should be placed into Native_iOS folder !

<pre>rake build:iphone:rhodeslib_framework["fullpath/Native_iOS"]</pre>

3. prepare Rhodes application bundle (already linked in Native_iOS example) - folder RhoBundle should be placed in root of XCode project folder !

<pre>rake build:iphone:rhodeslib_bundle["fullpath/Native_iOS"]</pre>

4. if you want to link framework and bundle into your already exist XCode project make next steps after generate framework and bundle ( set destination path to your XCode project root):

Drag and Drop bundle folder into root of XCode project (when it open in XCode) - make reference to folder option

Drag and Drop framework into root of XCode project (when it open in XCode) and after it add framework into embedded binary list (general option of project)

5. open and run XCode project. There are 5 examples located in this file - https://github.com/tauplatform/rhodes_lib_examples/blob/master/Native_iOS/Native_iOS/ViewController.m
Examples can be executed from main application screen by buttons.


# for Android

1. go to RhodesApp folder
2. prepare Rhodes library for Android project (already linked in Native_Android example) - framework should be placed into Native_Android/MyApplication/app/libs/ folder !

<pre>rake build:android:rhodeslib_lib["fullpath/Native_Android/MyApplication/app/libs/"]</pre>

3. prepare Rhodes application bundle (already linked in Native_Android example) - folder RhoBundle should be placed into Native_Android/MyApplication/app/src/main/assets/ folder !

<pre>rake build:android:rhodeslib_bundle["fullpath/Native_Android/MyApplication/app/src/main/assets/"]</pre>

4. if you want to link library and bundle into your already exist Android project make next steps( skip this step for Native_Android - it already prepared for rhodes lib and bundle):

You should make /app/libs folder if it not exists and also /app/src/main/assets/ - make it by self or make from Android Studio: right menu button on app item and -> new -> folder -> Assests Folder

Prepare lib and bundle by rake commands (see above)

In build.gradle in section dependencies:
<pre>implementation 'com.android.support:appcompat-v7:26.1.0'
implementation(name:'RhodesApp-1.0', ext:'aar') </pre>

In AndroidManifest.xml in section application add this:
<pre>android:name="com.rhomobile.rhodes.RhodesApplication"</pre>

Sync Project with Gradle Files

Build -> Build APK

In sources:

Main Activity should be extends from com.rhomobile.RhodesActivity

Make class and extends from RhoMain for get event about starts Rhodes application - onAppStart() method. Example:
<pre>class DefaultMain extends RhoMain
{
    @Override
    public void onAppStart()
    {
        super.onAppStart();
    }
}</pre>

In main Activity in OnCreate add code for setup Rhodes:
<pre>RhodesService.setRhoMain(new DefaultMain());</pre>

onAppStart() will be called when Rhode application(server) already started.

5. Build -> Build APK and Run

Example ruby access code located in https://github.com/tauplatform/rhodes_lib_examples/blob/master/Native_Android/MyApplication/app/src/main/java/com/example/n0men/myapplication/MainActivity.java
There are 3 buttons:

INIT - call method for add two items into DB (all ruby access functionality must be call only from Ruby thread)
TEST 2 - make network request to Rest API on local ruby http server, receive result
TEST 3 - call ruby class methods with JSON parameters and result (all ruby access functionality must be call only from Ruby thread)
