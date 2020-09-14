import 'package:special_lane/Pages/Notifications.dart';
import 'package:special_lane/Pages/pages.dart';

class IdToPage {
  static idToPage(String id) {
    if (id == HomePage.id) {
      return HomePage();
    } else if (id == ProfilePage.id) {
      return ProfilePage();
    } else if (id == Notifications.id) {
      return Notifications();
    } else if (id == UploadPage.id) {
      return UploadPage();
    }
  }
}
