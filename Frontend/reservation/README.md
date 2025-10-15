# Reservation Mobile App

## URL Configuration

The backend url can be configured by updating the variable "baseurl" from the file:
```sh
    - lib/network/apis
```
## Start The App 
The application can be started directly on an android emulated or physical device by running the command: 

```sh 
    - flutter run -d "device_id"
```
## Run Test
The unit test can be executed via the command:
```sh
    - flutter test test/calculer_total_test.dart 
```
## Note
PS: Make sure to add the internet permission in the android/app/src/main/res/AndroidManifest.xml file if it's not added in case you've only used the lib folder and not the whole project.

