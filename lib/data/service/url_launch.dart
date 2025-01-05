import 'package:url_launcher/url_launcher.dart';

class LaunchUrl{
  static Future <void> makePhoneCall(String phoneNumber)async{
    final Uri launchUri = Uri(scheme: "tel",path: phoneNumber);
    await launchUrl(launchUri);
  }
  static Future <void> httpsCall(String path)async{
    final Uri launchUri = Uri(scheme: "http",path: path);
    await launchUrl(launchUri);
  }
  static Future <void> mailtoCall(String emailEnter)async{
    final Uri launchUri = Uri(scheme: "mailto",path: emailEnter);
    await launchUrl(launchUri);
  }


}