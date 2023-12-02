import 'package:dio/dio.dart';
import 'package:lafyuu_e_commerce/model/category_model.dart';

class CategoryRepo{


  Future <CategoryMdel> getCategory()async{
    var pre = Dio();
    var response =await pre.get('https://student.valuxapps.com/api/categories');
    var data = CategoryMdel.fromJson(response.data);
    return data;

  }


}

