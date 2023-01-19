import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tele_tip/config.dart';
import 'package:tele_tip/models/doc_register_req.dart';
import 'package:tele_tip/models/get_doctor_res.dart';
import 'package:tele_tip/models/user_login_req.dart';
import 'package:tele_tip/models/user_login_res.dart';
import 'package:tele_tip/models/user_message_res.dart';
import 'package:tele_tip/models/user_register_req.dart';
import 'package:tele_tip/models/user_register_res.dart';
import 'package:tele_tip/services/shared_service.dart';

class APIService {
  static var client = http.Client();

  static Future<UserRegisterResModel> doctorRegister(
      DoctorRegisterRequest model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.doctorRegisterURL);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return userRegisterResModel(response.body);
  }

  static Future<bool> userLogin(UserLoginReqModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.userLoginURL);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(userLoginResJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<UserRegisterResModel> userRegister(
      UserRegisterReqModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.userRegisterURL);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return userRegisterResModel(response.body);
  }

  static Future<String> getName() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.token}'
    };
    var url = Uri.http(Config.apiURL, Config.userProfileAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return "${loginDetails.user.name} ${loginDetails.user.surname}";
    } else {
      return "";
    }
  }

  static Future<String> getImage() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.token}'
    };
    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return loginDetails.user.image;
    } else {
      return "";
    }
  }

  static Future<String> getEmail() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.token}'
    };
    var url = Uri.http(Config.apiURL, Config.userProfileAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return loginDetails.user.email;
    } else {
      return "";
    }
  }

  static Future<bool> userImageUpdate(XFile file) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.token}'
    };
    var url = Uri.http(Config.apiURL, Config.userUpdateImage);
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(requestHeaders);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var res = await request.send();
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<UserMessageRes> getAllMessageforUser() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails!.token}',
      'id': '${loginDetails.user.id}',
    };
    var url = Uri.http(Config.apiURL, Config.getUserAllMessage);
    var response = await client.post(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      try {
        print(response.body);
        return userMessageResJson(response.body);
      } catch (e) {
        print(e);
      }
      return userMessageResJson(response.body);
    } else {
      return userMessageResJson(response.body);
    }
  }

  static Future<List> getDuoMessage(String duo) async {
    var loginDetails = await SharedService.loginDetails();
    List posts = [];
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails!.token}',
      'id': '${loginDetails.user.id}',
      'duo': duo,
    };
    var url = Uri.http(Config.apiURL, Config.messageDetails);
    var response = await client.post(url,
        headers: requestHeaders,
        body: jsonEncode(
          <String, int>{
            'id': 15,
          },
        ));
    posts = json.decode(response.body);
    return posts;
  }

  static Future<bool> sendMessage(
      {int? target, int? source, String? message}) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails!.token}',
      'id': '${loginDetails.user.id}',
      'message': message.toString(),
      'target': target.toString(),
      'source': source.toString(),
    };
    var url = Uri.http(Config.apiURL, Config.sendMessage);
    var response = await client.post(url,
        headers: requestHeaders,
        body: jsonEncode(
          <String, int>{
            'id': 15,
          },
        ));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<GetDoctorRes> getDoctorUsagedName(String doctorName) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails!.token}',
    };
    var url = Uri.http(Config.apiURL, '${Config.getDoctor}/$doctorName');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return getDoctorResJSON(response.body);
    } else {
      return getDoctorResJSON(response.body);
    }
  }

  static Future<GetDoctorRes> getDoctorB(String doctorName) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails!.token}',
    };
    var url = Uri.http(Config.apiURL, '${Config.getDoctor}B/$doctorName');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return getDoctorResJSON(response.body);
    } else {
      return getDoctorResJSON(response.body);
    }
  }

  static Future<GetDoctorRes> getDoctorA(String doctorName) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails!.token}',
    };
    var url = Uri.http(Config.apiURL, '${Config.getDoctor}A/$doctorName');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return getDoctorResJSON(response.body);
    } else {
      return getDoctorResJSON(response.body);
    }
  }
}
