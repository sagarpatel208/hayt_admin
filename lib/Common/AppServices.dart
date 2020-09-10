import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hayt_admin/Common/ClassList.dart';
import 'package:hayt_admin/Common/Constants.dart';

Dio dio = new Dio();

class AppServices {
  static Future<SaveDataClass> AdminLogin(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Admin/login';
    print("Admin Login URL: ${url}");
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Admin Login Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        List list = [
          {
            "id": jsonResponse['value']["id"],
            "name": jsonResponse['value']["name"],
          }
        ];
        saveDataClass.value = list;
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Admin Login Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetAllSeller(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Registration/seller';
    print("Get All Seller URL: ${url}");
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Get All Seller Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value']["all_users"];
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get All Seller Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetAllServices(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Services/service';
    print("Get All Services URL ${url}");
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Get All Services Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value']["all_users"];
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get All Services Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> AddService(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Services/serviceaddAPI';
    print("Service Add URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Service Add Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Service Add Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetAllProducts(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Product/product';
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Get All Products Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value']["all_users"];
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get All Products Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> AddProduct(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Product/productaddAPI';
    print("Product Add URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Product Add Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Product Add Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> SellerProfileUpdate(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Registration/sellerupdateAPI/id';
    print("Seller Profile Update URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Seller Profile Update Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Seller Profile Update Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> DeleteProduct(data) async {
    String url = API_URL + 'Product/productdeleteAPI/${data}';
    print("Delete Product URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: {});
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Delete Product Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Delete Product Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> DeleteService(data) async {
    String url = API_URL + 'Services/servicedeleteAPI/${data}';
    print("Delete Service URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: {});
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Delete Service Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Delete Service Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetAllFeeds(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Feeds/feeds';
    print("Get All Seller URL: ${url}");
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Get All Feeds Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value']["all_users"];
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get All Feeds Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> UpdateShopStatus(id, data) async {
    String url = API_URL + 'Registration/sellerstatusupdateAPI/${id}';
    print("body: ${data}");
    print("Update Shop Status URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Update Shop Status Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Update Shop Status Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> UpdateServiceStatus(id, data) async {
    String url = API_URL + 'Services/servicesstatusupdateAPI/${id}';
    print("body: ${data}");
    print("Update Service Status URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Update Service Status Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Update Service Status Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> UpdateProductStatus(id, data) async {
    String url = API_URL + '/Product/productstatusupdateAPI/${id}';
    print("body: ${data}");
    print("Update Product Status URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Update Product Status Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Update Product Status Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> UpdateFeedStatus(id, data) async {
    String url = API_URL + 'Feeds/feedsstatusupdateAPI/${id}';
    print("body: ${data}");
    print("Update Feed Status URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Update Feed Status Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Update Feed Status Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }
}
