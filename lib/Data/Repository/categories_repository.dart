import 'package:dio/dio.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:ecommerce/Services/Helper/error_api_handler.dart';
import 'package:ecommerce/Services/Network/dio_api_service.dart';
import 'package:ecommerce/Services/Network/urls_api.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';

class CategoriesRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> getAllCategories() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.categoryApi,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );

      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> getSubCategory({required String slug}) async {
    try {
      Response response = await dioApiService.getData(
        "${UrlsApi.categoryApi}$slug",
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
