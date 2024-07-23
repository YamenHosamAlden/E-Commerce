import 'package:dio/dio.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:ecommerce/Services/Helper/error_api_handler.dart';
import 'package:ecommerce/Services/Network/dio_api_service.dart';
import 'package:ecommerce/Services/Network/urls_api.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';

class StartAppRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> startApp() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.startAppApi,
         options: Options(
        headers: {
          "Authorization":"Bearer ${AppSharedPreferences.getToken}"
        }
        
      ),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }
}
