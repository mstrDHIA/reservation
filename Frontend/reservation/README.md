# reservation

The backend url can be configured by updating the variable "baseurl" from the file:
    - lib/network/apis

The application can be started directly on an android emulated or physical device by running the command flutter run -d "device_id"

The unit test can be executed via the command:
    - flutter test test/calculer_total_test.dart 

PS: Make sure to add the internet permission in the android/app/src/main/res/AndroidManifest.xml file if it's not added in case you've only used the lib folder and not the whole project.

