import 'package:dio/dio.dart';
import 'package:lafyuu_e_commerce/model/product_details_model.dart';

class ProductDetailsRepo{



  Future<ProductDetailsModel> getProductDetails(int id)async{
   final  response = await Dio().get('https://student.valuxapps.com/api/products/${id.toString()}');
   print('===========================================');
   print(response.data);
   print('===========================================');
   final data = ProductDetailsModel.fromJson(response.data);
   return data;


  }
}

