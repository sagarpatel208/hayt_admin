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
        saveDataClass.value = jsonResponse['value'];
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
        saveDataClass.value = jsonResponse['value'];
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get All Products Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> ProductByCategory(id, body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Product/productbycategory/${id}';
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Get All Products Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value'];
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

  static Future<SaveDataClass> GetAllFeeds(id, body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Feeds/feeds/${id}';
    print("Get All feeds URL: ${url}");
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Get All Feeds Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value']['all_users'];
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

  static Future<SaveDataClass> MakeVIPService(id, data) async {
    String url = API_URL + 'Services/makevip/${id}';
    print("body: ${data}");
    print("Make VIP Service URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Make VIP Service Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Make VIP Service Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> MakeVIPProduct(id, data) async {
    String url = API_URL + 'Product/makevip/${id}';
    print("body: ${data}");
    print("Make VIP Product URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Make VIP Product Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Make VIP Product Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetCategory(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Category/allcategories';
    print("Get Category URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value']['all_users'];
        print("Get Category Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get Category Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> AddCategory(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Category/categoryaddAPI';
    print("Category Add URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Category Add Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Category Add Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> UpdateCategory(id, body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Category/categoryupdateAPI/${id}';
    print("Category Update URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Category Update Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Category Update Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> DeleteCategory(id, body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Category/categorydeleteAPI/${id}';
    print("Category Delete URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Category Delete Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Category Delete Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> AddFollow(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Follow/followaddAPI';
    print("Add Follow URL: ${url}");
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Add Follow Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();

        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Add Follow Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> DeleteFollow(id, body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Follow/followdeleteAPI/${id}';
    print("Delete Follow URL: ${url}");
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Delete Follow Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();

        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Delete Follow Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GiveFeedLike(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Like/likeaddAPI';
    print("Give Feed Like URL: ${url}");
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Give Feed Like Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();

        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Give Feed Like Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> RemoveFeedLike(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Like/likedeleteAPI/id';
    print("Remove Feed Like URL: ${url}");
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        print("Remove Feed Like Responce: ${jsonResponse}");
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Remove Feed Like Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> AddFeedComment(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Comment/commentaddAPI';
    print("Add Feed Comment URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Add Feed Comment Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Add Feed Comment Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetFeedComments(id, body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Feeds/feedidcommentlist/${id}';
    print("Get Feed Comment URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value'];
        print("Get Feed Comment Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get Feed Comment Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetUsersToAdminChatList(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'usertoadmin/chatlist';
    print("Get Users to Admin Chat URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value'];
        print("Get Users to Admin Chat Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get Users to Admin Chat Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> SendUsertoAdminMessage(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'usertoadmin/message';
    print("User to Admin Add URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("User to Admin Add Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("User to Admin Add Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetUsertoAdminChatMsg(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'usertoadmin/chathistory';
    print("Get UsertoAdmin Chat msg URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value'];
        print("Get UsertoAdmin Chat msg Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get UsertoAdmin Chat msg Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetSellerToAdminChatList(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'sellertoadmin/chatlist';
    print("Get SellertoAdmin Chat list URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value'];
        print("Get SellertoAdmin Chat list Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get SellertoAdmin Chat list Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> GetSellertoAdminChatMsg(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'sellertoadmin/chathistory';
    print("Get SellertoAdmin Chat msg URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        saveDataClass.value = jsonResponse['value'];
        print("Get SellertoAdmin Chat msg Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Get SellertoAdmin Chat msg Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> SendSellertoAdminMessage(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'sellertoadmin/message';
    print("Seller to Admin Add URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
            new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Seller to Admin Add Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Seller to Admin Add Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }
  static Future<SaveDataClass> SendNotificationToBuyer(body) async {
    print("body: ${body.toString()}");
    String url = API_URL + 'Admin/Notification';
    print("Send Admin to Buyer Notification URL: " + url);
    dio.options.contentType = Headers.jsonContentType;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveDataClass =
        new SaveDataClass(message: 'No Data', data: "1");
        final jsonResponse = json.decode(response.data);
        saveDataClass.message = jsonResponse['message'];
        saveDataClass.data = jsonResponse['data'].toString();
        print("Send Admin to Buyer Notification Responce: ${jsonResponse}");
        return saveDataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Send Admin to Buyer Notification Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }
}
