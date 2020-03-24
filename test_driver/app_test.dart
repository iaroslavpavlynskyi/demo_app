// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {

  group('Application Navigation', () {
    FlutterDriver _driver;

    final homeScreenText = find.byValueKey('home_screen_text');
    final newRecordScreenText = find.byValueKey('new_record_screen_text');
    final addNewRecordButton = find.byValueKey('add_button');

    setUpAll(() async{
      _driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if(_driver != null) {
        _driver.close();
      }
    });

    test('start with home screen', () async{
      expect(await _driver.getText(homeScreenText), "Home Screen");
    });

    test('add button navigates to new record screen', () async{
      await _driver.tap(addNewRecordButton);

      expect(await _driver.getText(newRecordScreenText), "New Record Screen");
    });
  });
}
