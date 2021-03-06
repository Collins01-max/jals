import 'dart:core';

import 'package:jals/constants/base_url.dart';

class AppUrl {
  static String login = "$baseUrl/rest-auth/login/";
  static String sendEmailToRegister = "$baseUrl/users/check_email/";
  static String sendRegistrationPassword = "$baseUrl/rest-auth/registration/";
  static String logOut = "$baseUrl/rest-auth/logout/";
  static String createUserAccountIno = "$baseUrl/v1/users/";
  static String forgotPasswordEmail = "$baseUrl";
  static String sendForgotPassword = "";
}
