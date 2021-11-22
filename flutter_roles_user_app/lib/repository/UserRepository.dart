import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_roles_user_app/exceptions/ValidationException.dart';
import 'package:flutter_roles_user_app/menu/create_role_menu/model/CreateRoleModel.dart';
import 'package:flutter_roles_user_app/menu/role_menu/model/RoleModel.dart';
import 'package:flutter_roles_user_app/menu/user_menu/model/UserModel.dart';
import 'package:http/http.dart' as http;

import '../Dictionary.dart';
import '../EndPointPath.dart';
import '../exceptions/ErrorException.dart';

class UserRepository {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json'
  };

  Future<UserModel> getUserAPi() async {
    final response = await http
        .get(EndPointPath.userApi, headers: headers)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      UserModel record = UserModel.fromJson(data);

      return record;
    } else if (response.statusCode == 401) {
      throw Exception(ErrorException.unauthorizedException);
    } else if (response.statusCode == 408) {
      throw Exception(ErrorException.timeoutException);
    } else if (response.statusCode == 422) {
      Map<String, dynamic> responseData = json.decode(response.body);
      throw ValidationException(responseData['data']);
    } else {
      throw Exception(Dictionary.somethingWrong);
    }
  }

  Future<RoleModel> getRoleAPi() async {
    var response = await http
        .get('${EndPointPath.roleApi}', headers: headers)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      RoleModel record = RoleModel.fromJson(data);

      return record;
    } else if (response.statusCode == 401) {
      throw Exception(ErrorException.unauthorizedException);
    } else if (response.statusCode == 408) {
      throw Exception(ErrorException.timeoutException);
    } else if (response.statusCode == 422) {
      Map<String, dynamic> responseData = json.decode(response.body);
      throw ValidationException(responseData['data']);
    } else {
      throw Exception(Dictionary.somethingWrong);
    }
  }

  Future<CreateRoleModel> createRoleAPi(
      {@required String title,
      @required String description,
      @required String requirement}) async {
    var requestData = {
      "title": title,
      "requirement": requirement,
      "description": description,
    };

    var response = await http
        .post('${EndPointPath.roleApi}',
            headers: headers, body: json.encode(requestData))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      CreateRoleModel record = CreateRoleModel.fromJson(data);

      return record;
    } else if (response.statusCode == 401) {
      throw Exception(ErrorException.unauthorizedException);
    } else if (response.statusCode == 408) {
      throw Exception(ErrorException.timeoutException);
    } else if (response.statusCode == 422) {
      Map<String, dynamic> responseData = json.decode(response.body);
      throw ValidationException(responseData['data']);
    } else {
      throw Exception(Dictionary.somethingWrong);
    }
  }
}
