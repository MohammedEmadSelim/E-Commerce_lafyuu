import 'package:dio/dio.dart';
import 'package:lafyuu_e_commerce/model/favorite_model.dart';

class FavoriteRepo {
  Future<FavoriteCategoryModel> getFavoriteCategoey(int id) async {
    Response response = await Dio().get(
        'https://student.valuxapps.com/api/products?category_id=${id.toString()}');
    final data = response.data;
    final FavoriteCategoryModel dataAsObject =
        FavoriteCategoryModel.fromJson(data);

    return dataAsObject;
  }
}
