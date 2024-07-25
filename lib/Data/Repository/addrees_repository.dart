import 'package:dio/dio.dart';
import 'package:ecommerce/Data/Models/addrees_model.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:ecommerce/Services/Helper/error_api_handler.dart';
import 'package:ecommerce/Services/Network/dio_api_service.dart';
import 'package:ecommerce/Services/Network/urls_api.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';

class AddreesRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> getAddreeses() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.addressApi,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> setNewAddress({required AddreesModel addreesModel}) async {
    final Map<String, dynamic> addreesModelMap = <String, dynamic>{};
    addreesModelMap['address_name'] = addreesModel.addressName;
    addreesModelMap['city'] = addreesModel.city;
    addreesModelMap['district'] = addreesModel.district;
    addreesModelMap['details'] = addreesModel.details;
    addreesModelMap['latitude'] = addreesModel.latitude;
    addreesModelMap['longitude'] = addreesModel.longitude;
    addreesModelMap['phone_number'] = addreesModel.phoneNumber;
    try {
      Response response = await dioApiService.postData(
        UrlsApi.addressApi,
        data: addreesModelMap,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> deleteAddrees({required int addreesId}) async {
    try {
      Response response = await dioApiService.deleteData(
        "${UrlsApi.addressApi}$addreesId",
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> confirmOrder(
      {required int totalCost, required int addreesId}) async {
    try {
      Response response = await dioApiService.postData(
        UrlsApi.orderApi,
        data: {"order_address": addreesId, "total_price": totalCost},
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
