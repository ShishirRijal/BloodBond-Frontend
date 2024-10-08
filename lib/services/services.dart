import 'dart:convert';
import 'dart:io';

import 'package:bloodbond/controller/all_hospitals_detail_controller.dart';
import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/models/campaignDonorsModel.dart';
import 'package:bloodbond/models/campaignModel.dart';
import 'package:bloodbond/models/redeemedRewardsModel.dart';
import 'package:bloodbond/models/rewardRedeemedDonors.dart';
import 'package:bloodbond/models/rewardsModel.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/changePassword.dart';
import 'package:bloodbond/screen/history_donor.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../controller/nearby_donor.controller.dart';
import '../utils/constants.dart' as cons;

class ApiService {
  //For nearby donors
  static Future<List<NearbyDonor>?> fetchDonors() async {
    var response = await http.get(
      Uri.parse(Url.nearbyDonor),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;

    if (response.statusCode == 200) {
      final x = nearbyDonorFromJson(data);
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

//read user
  static Future<String?> fetchUserProfile() async {
    var response = await http.get(
      Uri.parse(Url.readUser),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else if (response.statusCode == 401) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      Get.closeAllSnackbars();
      Get.snackbar(
        responseData['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Unexpected error occurred (${response.statusCode})',
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

//get donors
  static Future<List<AllHospital>?> fetchAllHospitals() async {
    var response = await get(
      Uri.parse(Url.getAllhospitals),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;
    if (response.statusCode == 200) {
      return allHospitalFromJson(data);
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static Future<List<EmergencyRequest>?> fetchEmergencyRequest(
      {bool All = false}) async {
    var response = await http.get(
      Uri.parse("${Url.getEmergencyRequest}/?showAll=$All"),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;

    print(data);
    if (response.statusCode == 200) {
      final x = emergencyRequestFromJson(data);
      print(x);
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static Future<List<CampaignDetails>?> fetchCampaigns(
      {bool All = false}) async {
    var response = await http.get(
      Uri.parse("${Url.getCampaings}/?showAll=$All"),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;

    final x = campaignDetailsFromJson(data);
    print(x);
    if (response.statusCode == 200) {
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static Future<String> uploadImage(File imageFile) async {
    final Uri uploadEndpoint = Uri.parse(Url.uploadImage);

    var request = http.MultipartRequest('POST', uploadEndpoint);

    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    print(responseBody);
    if (response.statusCode == 201) {
      return responseBody;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        "Error Uploading Image",
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );

      return "";
    }
  }

  static void forgetPassword() async {
    final response = await http.post(
      Uri.parse(Url.login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        //"email": emailController.value.text,
      }),
    );
  }

  static Future<CampaignDonorsDetails?> fetchCampaignDonors(int id) async {
    var response = await http.get(
      Uri.parse("${Url.getCampaings}/$id"),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;

    print(data);
    if (response.statusCode == 200) {
      final x = campaignDonorsDetailsFromJson(data);
      print(x);
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static Future<List<MyCampaigns>?> fetchDonorsCampaign(
      {bool All = false}) async {
    var token = GetStorage().read('token');
    var response = await http.get(
      Uri.parse("${Url.getCampaings}/my-campaigns"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token ',
      },
    );
    var data = response.body;

    print(data);
    if (response.statusCode == 200) {
      final x = myCampaignsFromJson(data);
      print(x);
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static Future<List<Rewards>?> fetchRewards() async {
    var token = GetStorage().read('token');
    var response = await http.get(
      Uri.parse(Url.getRewards),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token ',
      },
    );
    var data = response.body;

    print(data);
    if (response.statusCode == 200) {
      final x = rewardsFromJson(data);
      print(x);
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static Future<List<RedeemedRewards>?> fetchRedeemedRewards() async {
    var token = GetStorage().read('token');
    var response = await http.get(
      Uri.parse(Url.getRedeem),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token ',
      },
    );
    var data = response.body;

    print(data);
    if (response.statusCode == 200) {
      final x = redeemedRewardsFromJson(data);
      print(x);
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static redeemRewards(final id) async {
    try {
      var token = GetStorage().read('token');

      final response = await post(
        Uri.parse("${Url.getRedeem}/$id"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token ',
        },
      );
      // print(response.statusCode);
      var data = jsonDecode(response.body);
      // var user = data.user;
      // print(response.statusCode);
      // print(data);
      if (response.statusCode == 200) {
        Get.closeAllSnackbars();
        Get.snackbar(
          'Sucessfully Redeemed',
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.deleteAll();
      } else {
        Get.closeAllSnackbars();
        Get.snackbar(
          "Failed",
          data['detail'],
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }
    } catch (e) {
      Get.closeAllSnackbars();

      if (e == SocketException) {
        Get.snackbar(
          'Check Your Internet Connection',
          "",
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }
    }
  }

  static Future<List<RewardRedeemedDonors>?> rewardRedeemedDonors() async {
    var token = GetStorage().read('token');
    var response = await http.get(
      Uri.parse(Url.getRedeemdDonors),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token ',
      },
    );
    var data = response.body;

    print(data);
    if (response.statusCode == 200) {
      final x = rewardRedeemedDonorsFromJson(data);
      print(x);
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static verfiyotp(final email, final otp) async {
    try {
      final response = await post(
        Uri.parse(Url.verifyotp),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );
      // print(response.statusCode);
      var data = jsonDecode(response.body);
      // var user = data.user;
      // print(response.statusCode);
      // print(data);
      if (response.statusCode == 200) {
        Get.closeAllSnackbars();
        Get.snackbar(
          'Sucessfully Verified',
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.deleteAll();
        Get.to(ChangePassword(email: email));
      } else {
        Get.closeAllSnackbars();
        Get.snackbar(
          "Failed",
          data['detail'],
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }
    } catch (e) {
      Get.closeAllSnackbars();

      if (e == SocketException) {
        Get.snackbar(
          'Check Your Internet Connection',
          "",
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }
    }
  }
}
