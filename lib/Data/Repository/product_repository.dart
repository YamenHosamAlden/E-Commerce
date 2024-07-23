import 'package:dio/dio.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:ecommerce/Services/Helper/error_api_handler.dart';
import 'package:ecommerce/Services/Network/dio_api_service.dart';
import 'package:ecommerce/Services/Network/urls_api.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';

class ProductRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> getFilters({required String slug}) async {
    try {
      Response response = await dioApiService.postData(
        data: {"category": slug},
        UrlsApi.filtersApi,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> getProductDetails({required String slug}) async {
    try {
      Response response = await dioApiService.getData(
        "${UrlsApi.productDetailsApi}/$slug",
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> getProductsPromotion({required int promotionId}) async {
    try {
      Response response = await dioApiService.getData(
        "${UrlsApi.promotionProductsApi}/$promotionId",
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> getPromotions() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.promotionApi,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> getFiltardProductListByCategory(
      {required String slug,
      List<int>? sizeIds,
      List<int>? brandIds,
      String? minPrice,
      String? maxPrice}) async {
    final Map<String, dynamic> filterMap = <String, dynamic>{};
    filterMap['category'] = slug;
    if (brandIds!.isNotEmpty) {
      filterMap['brand'] = brandIds;
    }

    if (sizeIds!.isNotEmpty) {
      filterMap['size'] = sizeIds;
    }
    if (minPrice != null) {
      filterMap['min_price'] = minPrice;
    }

    if (maxPrice != null) {
      filterMap['max_price'] = maxPrice;
    }

    try {
      Response response = await dioApiService.postData(
        UrlsApi.filtedProductListApi,
        data: filterMap,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> getProductListByType({
    required String productsType,
  }) async {
    String? api;
    if (productsType == "highest_rating") {
      api = "highest_rating";
    } else {
      api = "newly_added";
    }

    try {
      Response response = await dioApiService.getData(
        api,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> getProductListByCategory(
      {required String slug, String? sortBy}) async {
    final Map<String, dynamic> sortByMap = <String, dynamic>{};

    if (sortBy == "New arrival" || sortBy == "جديد") {
      sortByMap['new_arrival'] = sortBy;
    }

    if (sortBy == "Highest price" || sortBy == "الاعلى سعرا") {
      sortByMap['highest_price'] = sortBy;
    }

    if (sortBy == "Lowest price" || sortBy == "الاقل سعرا") {
      sortByMap['lowest_price'] = sortBy;
    }

    try {
      Response response = await dioApiService.postData(
        "${UrlsApi.productListApi}/$slug",
        data: sortByMap,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> addToFavorite(
      {int? productId, int? productDetailId}) async {
    final Map<String, dynamic> wishListMap = <String, dynamic>{};
    if (productDetailId != null) {
      wishListMap['product_detail'] = productDetailId;
    } else {
      wishListMap['product'] = productId;
    }

    FormData wishListMapFormData = FormData.fromMap(wishListMap);
    try {
      Response response = await dioApiService.postData(UrlsApi.wishListApi,
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }),
          data: wishListMapFormData);
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> removeFromFavorite(
      {int? productDetailId, int? productId, int? all}) async {
    final Map<String, dynamic> wishListMap = <String, dynamic>{};
    if (all == null) {
      if (productDetailId != null) {
        wishListMap['product_detail'] = productDetailId;
      } else {
        wishListMap['product'] = productId;
      }
    } else {
      wishListMap['all'] = all;
    }

    FormData wishListMapFormData = FormData.fromMap(wishListMap);
    try {
      Response response = await dioApiService.deleteData(
        UrlsApi.wishListApi,
        data: wishListMapFormData,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> favoriteToCart() async {
    try {
      Response response = await dioApiService.postData(
        UrlsApi.wishListToShoppingCart,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> getMyFavoriteList() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.wishListApi,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> searchResult({required String result, String? slug}) async {
    final Map<String, dynamic> searchMap = <String, dynamic>{};
    if (slug != null) {
      searchMap['category'] = slug;
    }
    try {
      Response response = await dioApiService.postData(
        UrlsApi.searchApi + result,
        data: searchMap,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }),
      );
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> completionSearch() async {
    try {
      Response response = await dioApiService.getData(
        UrlsApi.completionApi,
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
