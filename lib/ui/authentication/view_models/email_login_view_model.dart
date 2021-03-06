import 'package:flutter/material.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/network_utils.dart';

import '../../../utils/locator.dart';

class EmailLoginViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NetworkConfig _networkConfig = NetworkConfig();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  login() async {
    try {
      setBusy(ViewState.Busy);
      await _networkConfig.onNetworkAvailabilityDialog(onNetwork);
      setBusy(ViewState.Idle);
    } catch (e) {
      print(e);
      setBusy(ViewState.Idle);
    }
  }

  onNetwork() async {
    try {
      setBusy(ViewState.Busy);
      ApiResponse apiResponse = await _authenticationService.loginWithEmail(
          email: emailController.text, password: passwordController.text);
      setBusy(ViewState.Idle);
      if (apiResponse == ApiResponse.Success) {
        _navigationService.navigateToReplace(AccountInfoViewRoute);
      } else {
        // ! show handle error.
        await _dialogService.showDialog(
            buttonTitle: "OK",
            description:
                "An error occured while trying to login. Please check your credentials and try again.",
            title: "Login Error");
      }
    } catch (e) {
      print(e);
      setBusy(ViewState.Idle);
    }
  }

  googleSignIn() async {}
  facebookSignIn() async {}

  toSignUp() async {
    _navigationService.navigateToReplace(SignUpViewRoute);
  }

  toForgotPassword() async {
    _navigationService.navigateTo(ForgotPasswordViewRoute);
  }
}
