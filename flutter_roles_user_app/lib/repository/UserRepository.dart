import 'dart:convert';

import 'package:flutter_roles_user_app/exceptions/ValidationException.dart';
import 'package:flutter_roles_user_app/model/RoleModel.dart';
import 'package:flutter_roles_user_app/model/UserModel.dart';
import 'package:http/http.dart' as http;

import '../Dictionary.dart';
import '../EndPointPath.dart';
import '../ErrorException.dart';
import '../HttpHeaders.dart';

class UserRepository {
  Future<UserModel> getUserAPi() async {
    print('kesini masuk ngga? ');

    final response = await http
        .get(EndPointPath.userApi, headers: await HttpHeaders.headers())
        .timeout(const Duration(seconds: 10));

    print('cekk isinya apa ' + response.body.toString());

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
        .get('${EndPointPath.roleApi}')
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

  Future<RoleModel> createRoleAPi() async {
    var response = await http
        .post('${EndPointPath.roleApi}')
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
}
