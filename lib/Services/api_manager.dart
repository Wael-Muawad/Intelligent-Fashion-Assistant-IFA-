import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testo/Constants/Strings.dart';
import 'package:testo/Model/AddPhotoRespnse.dart';
import 'package:testo/Model/ApiResponse.dart';
import 'package:testo/Model/BodyShapeRequest.dart';
import 'package:testo/Model/BodyShapeResponse.dart';
import 'package:testo/Model/CategoryResponse.dart';
import 'package:testo/Model/DetailsResponse.dart';
import 'package:testo/Model/FeedbacksResponse.dart';
import 'package:testo/Model/Garment.dart';
import 'package:testo/Model/Garment2.dart';
import 'package:testo/Model/Garment3.dart';
import 'package:testo/Model/LoginResponse.dart';
import 'package:testo/Model/RateStoreRequest.dart';
import 'package:testo/Model/StoreDetailsResponse.dart';
import 'package:testo/Model/User.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:testo/Model/UserProfileRequest.dart';
import 'package:testo/Model/UserProfileResponse.dart';

class API_Manager {
  var url = Uri.parse(Strings.url);
  var client = http.Client();


  Future<Garment> getAllGarments({int pageNumber,int pageSize}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await client.get('$url/garment/user-garments?PageNumber=$pageNumber&PageSize=$pageSize',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );
    var garmentResponse = Garment();
    garmentResponse = garmentFromJson(response.body);
    return garmentResponse;
  }

  Future<Garment> searchGarments({String searchWord,int pageNumber,int pageSize}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/garment/search/ass?PageNumber=1&PageSize=1
    var response = await client.get('$url/garment/search/$searchWord?PageNumber=$pageNumber&PageSize=$pageSize',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );
    var garmentResponse = Garment();
    garmentResponse = garmentFromJson(response.body);
    return garmentResponse;
  }

  Future<Garment> categoryGarments({int categoryId,int pageNumber,int pageSize}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/garment/category/2?PageNumber=1&PageSize=50
    var response = await client.get('$url/garment/category/$categoryId?PageNumber=$pageNumber&PageSize=$pageSize',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );
    var garmentResponse = Garment();
    garmentResponse = garmentFromJson(response.body);
    return garmentResponse;
  }

  Future<DetailsResponse> getDetails({int garmentId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/garment/GetGarmentUserById/1
    var response = await client.get('$url/garment/GetGarmentUserById/$garmentId',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );
    var details = DetailsResponse();
    details = detailsResponseFromJson(response.body);
    return details;
  }

  Future<StoreDetailsResponse> getStoreWithGarments({int storeId,int pageNumber,int pageSize}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/store/GetStoreWithGarments?storeId=2&PageNumber=1&PageSize=50
    var response = await client.get('$url/store/GetStoreWithGarments?storeId=$storeId&PageNumber=$pageNumber&PageSize=$pageSize',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );
    var storeDetails = StoreDetailsResponse();
    storeDetails = storeDetailsResponseFromJson(response.body);
    return storeDetails;
  }

  Future<FeedbacksResponse> getStoreFeedback({int storeId}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/store/GetAllFeedbacks/3
    var response = await client.get('$url/store/GetAllFeedbacks/$storeId',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );
    var feedbacks = FeedbacksResponse();
    feedbacks = feedbacksResponseFromJson(response.body);
    return feedbacks;
  }

  uploadImage(File file) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/user/AddPhoto
    /*var request = http.MultipartRequest("POST",Uri.parse('http://10.0.2.2:5001/user/AddPhoto'));

    request.headers['content-type'] = 'application/json';
    request.headers['accept'] = 'application/json';
    request.headers['authorization'] = 'Bearer ${prefs.getString('token')}';

    var picture = http.MultipartFile.fromBytes('image', (await rootBundle.load('assets/testimage.png')).buffer.asUint8List(),
        filename: 'testimage.png');

    request.files.add(picture);

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var result = String.fromCharCodes(responseData);

    print(result);*/

    var request = http.MultipartRequest("POST", Uri.parse('http://10.0.2.2:5001/user/AddPhoto'));
    //request.fields['user'] = 'someone@somewhere.com';
    request.headers['content-type'] = 'application/json';
    request.headers['accept'] = 'application/json';
    request.headers['authorization'] = 'Bearer ${prefs.getString('token')}';

   /* request.files.add(http.MultipartFile.fromPath(
      file.path
      *//*'package',
      'build/package.tar.gz',*//*
      contentType: new MediaType('application', 'x-tar'),
    ));
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });*/
  }

  Future<String> uploadImage2(filename) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:5001/user/AddPhoto'));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<Garment> getLikedGarments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/garment/FavoriteGarments
    var response = await client.get('$url/garment/FavoriteGarments',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );
    var garmentResponse = Garment();
    garmentResponse = garmentFromJson(response.body);
    return garmentResponse;
  }


  Future<void> isLikeGarment(int garmentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/garment/toggle-like/1
    final response = await client.post(
      Uri.parse(Strings.url + '/garment/toggle-like/$garmentId'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );
  }


  Future<void> rateStore(RateStoreRequest data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await client.post(
      //http://localhost:5001/store/rate
      Uri.parse(Strings.url + '/store/rate'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
      body: rateStoreRequestToJson(data),
    );

    //apiResponse = apiResponseFromJson(response.body);

    //return apiResponse;
  }


  Future<CategoryResponse> getAllCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http://localhost:5001/category

    var response = await client.get('$url/category',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );

      var categoryResponse = CategoryResponse();
      categoryResponse = categoryResponseFromJson(response.body);

    return categoryResponse;
  }


  Future<UserProfileResponse> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/user/profile
    var response = await client.get('$url/user/profile',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
    );
    var userProfileResponse = UserProfileResponse();
    userProfileResponse = userProfileResponseFromJson(response.body);
    return userProfileResponse;
  }

  Future<UserProfileResponse> editUserProfile(UserProfileRequest model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //http://localhost:5001/user
    var response = await client.put('$url/user',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
      body: userProfileRequestToJson(model)
    );
    var userProfileResponse = UserProfileResponse();
    userProfileResponse = userProfileResponseFromJson(response.body);
    return userProfileResponse;
  }

  Future<List<User>> getAllUsers() async {
    // ignore: avoid_init_to_null
    var categoryModel = List<User>.empty();
    var response = await client.get('$url/user');
    print('getAllUsers ${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        //var jsonString = response.body;
        //var jsonMap = jsonDecode(jsonString);
        //var hashToList = jsonMap['data'];
        //categoryModel = jsonMap.map<Category>((json) => Category.fromJson(json)).toList();
        //print('getAllUsers: ${categoryModel.length}');
        //print('getAllUsersjsonMap: $jsonMap');
      }
    } catch (exception) {
      //print('Data: ${response.statusCode}');
      return categoryModel;
    }
    return categoryModel;
  }


  Future<AddPhotoResponse> addPhoto() async {
    //response = await dio.post("/info", data: formData)

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await client.post(
      //http://localhost:5001/user/AddPhoto
      Uri.parse(Strings.url + '/user/AddPhoto'),
      //"content-type"
      //"accept"
      //"authorization"
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
      //body: data,
    );
    AddPhotoResponse addPhotoResponse = AddPhotoResponse();
    addPhotoResponse = addPhotoResponseFromJson(response.body);
    return addPhotoResponse;
  }


  Future<ApiResponse> addCustomer(User data) async {
    final response = await client.post(
      Uri.parse(Strings.url + '/user'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
      },
      body: userToJson(data),
    );
    var apiResponse = ApiResponse();
    apiResponse = apiResponseFromJson(response.body);

    return apiResponse;
  }


  Future<LoginResponse> LoginToken(
      {@required String email, @required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var loginResponse = LoginResponse();
    final response = await client.get(
      Uri.parse(
          Strings.url + '/auth/login?userEmail=$email&password=$password'),
    );

    loginResponse = loginResponseFromJson(response.body);

    if (loginResponse.success) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(loginResponse.data);
        prefs.setString('token', loginResponse.data);
    }
    return loginResponse;
  }


  Future<BodyShapeResponse> CalculateBodyShape(BodyShapeRequest data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await client.post(
      Uri.parse(Strings.url + '/calculatebodyshape'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString('token')}'
      },
      body: bodyShapeRequestToJson(data),
    );
    var bodyShapeResponse = BodyShapeResponse();
    bodyShapeResponse = bodyShapeResponseFromJson(response.body);

    return bodyShapeResponse;
  }

}
