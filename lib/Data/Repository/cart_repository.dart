import 'package:dio/dio.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:ecommerce/Services/Helper/error_api_handler.dart';
import 'package:ecommerce/Services/Network/dio_api_service.dart';
import 'package:ecommerce/Services/Network/urls_api.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';

class CartRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> addToCart({int? productId, int? productDetailId}) async {
    final Map<String, dynamic> cartMap = <String, dynamic>{};
    if (productDetailId != null) {
      cartMap['product_detail'] = productDetailId;
    } else {
      cartMap['product'] = productId;
    }

    FormData cartMapFormData = FormData.fromMap(cartMap);
    try {
      Response response = await dioApiService.postData(UrlsApi.shoppingCart,
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }),
          data: cartMapFormData);
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> removeFromCart({int? productDetailId, int? all}) async {
    final Map<String, dynamic> cartMap = <String, dynamic>{};
    if (all != null) {
      cartMap['all'] = all;
    } else {
      cartMap['product_detail'] = productDetailId;
    }

    FormData cartMapFormData = FormData.fromMap(cartMap);
    try {
      Response response = await dioApiService.deleteData(
        UrlsApi.shoppingCart,
        data: cartMapFormData,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> getMyCartList() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.shoppingCart,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> changeQty(
      {required int qty, required int productDetailId}) async {
    try {
      Response response = await dioApiService.putData(
        "${UrlsApi.shoppingCart}$productDetailId",
        data: {"quantity": qty},
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  
  Future<ApiResult> addCoupon(
      { required String couponCode}) async {
    try {
      Response response = await dioApiService.postData(
        UrlsApi.useCouponApi,
        data: {"coupon_code": couponCode},
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
