
import 'package:dio/dio.dart';
import 'package:ecommerce/Data/Models/profile_model.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:ecommerce/Services/Helper/error_api_handler.dart';
import 'package:ecommerce/Services/Network/dio_api_service.dart';
import 'package:ecommerce/Services/Network/urls_api.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';

class ProfileRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> getProfile() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.profileApi,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> editProfile({required Customer userProfile}) async {
    final Map<String, dynamic> editProfile = <String, dynamic>{};
    editProfile['first_name'] = userProfile.user!.firstName;
    editProfile['last_name'] = userProfile.user!.lastName;
    editProfile['username'] = userProfile.user!.username;
    editProfile['email'] = userProfile.user!.email;
    editProfile['phone_number'] = userProfile.phoneNumber;

    if (userProfile.fileImage != null) {
      editProfile['image_url'] = await MultipartFile.fromFile(
        userProfile.fileImage!.path,
        filename: userProfile.fileImage!.path,
      );
    }

    FormData editProfileFormData = FormData.fromMap(editProfile);
    try {
      Response response = await dioApiService.putData(
        UrlsApi.profileApi,
        data: editProfileFormData,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  // Future<ApiResult> changePassword(
  //     {required String oldPassword,
  //     required String newPassword,
  //     required String confirmPassword}) async {
  //   try {
  //     Response response = await dioApiService.postData(
  //       UrlsApi.changePasswordApi,
  //       data: {
  //         "old_password": oldPassword,
  //         "password": newPassword,
  //         "password_confirmation": confirmPassword
  //       },
  //       options:
  //           Options(headers: {"auth-token": AppSharedPreferences.getToken}),
  //     );
  //     return ApiResult.withSuccess(response);
  //   } catch (error) {
  //     return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
  //   }
  // }
}
