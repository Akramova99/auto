import 'dart:convert';

import 'package:auto/data/model/all_lesson.dart';
import 'package:auto/data/model/bilet_id_lessons.dart';
import 'package:auto/data/model/login_response.dart';
import 'package:auto/data/model/random_test.dart';
import 'package:auto/data/model/register_response.dart';
import 'package:auto/data/model/test_of_lesson_id.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkService {
  static String BASE = 'api.rulionline.uz';

  static String GET_LESSON = '/api/lesson'; //
  static String LOGIN_URL = '/api/auth/login'; //
  static String SIGN_UP_URL = '/api/auth/register'; //
  static String GET_TEST = '/api/random_lesson/'; //we are with you
  static String BILET_TEST = '/api/bilet/';
  static String RANDOM_TEST = '/api/random';
  static String TEST_LESSON = '/api/question/';
  static Map<String, String> header1 = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    // "Authorization":
    //     "Bearer 5943|jU91139X3lSSu3xuWQYuiBRInsRX1xyK6PhperlZ2f61f30a",
    // Tokenni bu yerga qo'shdik
  };
  static Map<String, String> header2 = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    // "Authorization":
    //     "Bearer 5943|jU91139X3lSSu3xuWQYuiBRInsRX1xyK6PhperlZ2f61f30a",
    // Tokenni bu yerga qo'shdik
  };

  static Map<String, String> header({String? token}) {
    header2 = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
      // Tokenni bu yerga qo'shdik
    };
    return header2;
  }

  static Future<String> GET_LESSON_METHOD() async {
    try {
      Uri uri = Uri.https(
        BASE,
        GET_LESSON,
      );
      Logger().i('Requesting URL: $uri');
      Logger().i('header2: ${header2}');

      var response = await get(uri, headers: header2);
      Logger().i(response.statusCode);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Optionally, handle other status codes as needed
        return "";
      }
    } catch (e) {
      // Log the error or handle it in a way that makes sense for your app
      return "";
    }
  }

  static Future<String?> LOGIN(Map<String, String> params) async {
    try {
      Uri uri = Uri.https(BASE, LOGIN_URL);
      Logger().i('Requesting URL: $uri');

      var response =
          await post(uri, headers: header1, body: jsonEncode(params));
      Logger().i(response.statusCode);
      if (response.statusCode == 200) {
        Logger().i(response.body);
        return response.body;
      } else {
        // Optionally, handle other status codes as needed
        return null;
      }
    } catch (e) {
      // Log the error or handle it in a way that makes sense for your app
      return null;
    }
  }

  static Future<String?> SIGN_UP(Map<String, String> params) async {
    try {
      Uri uri = Uri.https(BASE, SIGN_UP_URL);
      Logger().i('Requesting URL: $uri');

      var response =
          await post(uri, headers: header1, body: jsonEncode(params));
      Logger().i(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Logger().i(response.body);
        return response.body;
      } else {
        // Optionally, handle other status codes as needed
        return null;
      }
    } catch (e) {
      // Log the error or handle it in a way that makes sense for your app
      return null;
    }
  }

  // static Future<String?> GET_TEST_METHOD(
  //     String api, Map<String, String> params) async {
  //   Uri uri = Uri.https(BASE, api, params);
  //   var response = await get(uri, headers: header);
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   }
  //   return null;
  // }

  static Future<String?> BILET_TEST_METHOD(
      String id, Map<String, String> params) async {
    try {
      Uri uri = Uri.https(BASE, BILET_TEST + id, params);
      Logger().i('Requesting URL: $uri');

      var response = await get(uri, headers: header2);
      Logger().i('Response Status Code: ${response.statusCode}');
      Logger().i('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return response.body;
      } else {
        Logger().w('Failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      Logger().e('Error in BILET_TEST_METHOD: $e');
      return null;
    }
  }

  static Future<String?> GET_TEST_METHOD(
      String id, Map<String, String> params) async {
    try {
      Uri uri = Uri.https(BASE, GET_TEST + id, params);
      Logger().i('Requesting URL: $uri');

      var response = await get(uri, headers: header2);
      Logger().i('Response Status Code: ${response.statusCode}');
      Logger().i('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return response.body;
      } else {
        Logger().w('Failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      Logger().e('Error in GET_TEST_METHOD: $e');
      return null;
    }
  }

  static Future<String?> RANDOM_TEST_METHOD(Map<String, String> params) async {
    Uri uri = Uri.https(BASE, RANDOM_TEST, params);
    var response = await get(uri, headers: header2);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> TEST_LESSON_METHOD(
      String id, Map<String, String> params) async {
    try {
      Uri uri = Uri.https(BASE, TEST_LESSON + id, params);
      Logger().i('Requesting URL: $uri');

      var response = await get(uri, headers: header2);
      Logger().i('Response Status Code: ${response.statusCode}');
      Logger().i('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return response.body;
      } else {
        Logger().w('Failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      Logger().e('Error in TEST_LESSON_METHOD: $e');
      return null;
    }
  }

  static List<AllLesson2> parsingResponse(String response) {
    try {
      var myJson = jsonDecode(response);
      List<AllLesson2> lessons = [];
      Logger().i("Processing mp: $myJson");
      Logger().i("runtime mp: ${myJson.runtimeType}");
      for (var mp in myJson) {
        try {
          Logger().i("Processing mp: $mp");
          lessons.add(AllLesson2.fromJson(mp));
        } catch (e) {
          Logger().e("Skipping invalid mp: $mp, Error: $e");
        }
      }

      return lessons;
    } catch (e) {
      Logger().e("Error parsing AllLesson: $e");
      rethrow;
    }
  }


  // static List<TestOfLessons> biletResponse(String response) {
  //   List<TestOfLessons> welcomeFromJson = List<TestOfLessons>.from(
  //       json.decode(response).map((x) => TestOfLessons.fromJson(x)));

  //   return welcomeFromJson;
  // }

  static BiletId fromJsonjon(String str) => BiletId.fromJson(json.decode(str));

  static TestOfLessons testOfLessons(String str) =>
      TestOfLessons.fromJson(json.decode(str));

  static biletResponse(String response) {
    dynamic json = jsonDecode(response);
    List<BiletId> answers =
        List.from(json["data"].map((answers) => BiletId.fromJson(answers)));
    Logger().w(answers.first.data);
    return answers;

    /// returned List of answers object
  }

  static RandomTest randomTest(String str) =>
      RandomTest.fromJson(json.decode(str));

  static LoginResponse loginResponse(String str) =>
      LoginResponse.fromJson(json.decode(str));

  static RegistrationResponse registerResponse(String str) =>
      RegistrationResponse.fromJson(json.decode(str));
}
