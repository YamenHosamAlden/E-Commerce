import 'package:dio/dio.dart';
import 'package:ecommerce/Data/Models/auth_model.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:ecommerce/Services/Helper/error_api_handler.dart';
import 'package:ecommerce/Services/Network/dio_api_service.dart';
import 'package:ecommerce/Services/Network/urls_api.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Util/notificaton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> signUp({required SignUpModel signUpModel}) async {
    NotificatonHandler.fcmToken = await FirebaseMessaging.instance.getToken();
    final Map<String, dynamic> signUpMap = <String, dynamic>{};
    signUpMap['username'] = signUpModel.username;
    signUpMap['first_name'] = signUpModel.fullName;
    signUpMap['last_name'] = signUpModel.lastName;
    signUpMap['phone_number'] = signUpModel.phone;
    signUpMap['email'] = signUpModel.email;
    signUpMap['password'] = signUpModel.password;
    signUpMap['fcm_token'] = NotificatonHandler.fcmToken;

    FormData signUpMapFormData = FormData.fromMap(signUpMap);

    try {
      Response response = await dioApiService.postData(UrlsApi.signUpApi,
          data: signUpMapFormData);
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> logIn(
      {required String password, required String email}) async {
    NotificatonHandler.fcmToken = await FirebaseMessaging.instance.getToken();
    final Map<String, dynamic> loginMap = <String, dynamic>{};

    loginMap['email'] = email;
    loginMap['password'] = password;
    loginMap['fcm_token'] = NotificatonHandler.fcmToken;

    FormData loginMapFormData = FormData.fromMap(loginMap);

    try {
      Response response = await dioApiService.postData(UrlsApi.logInApi,
          data: loginMapFormData);
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> logOut() async {
    try {
      Response response = await dioApiService.postData(
        UrlsApi.logOutApi,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }
}
