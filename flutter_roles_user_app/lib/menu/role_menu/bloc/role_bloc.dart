import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_roles_user_app/exceptions/CustomException.dart';
import 'package:flutter_roles_user_app/exceptions/ValidationException.dart';
import 'package:flutter_roles_user_app/menu/role_menu/model/RoleModel.dart';
import 'package:flutter_roles_user_app/repository/UserRepository.dart';

part 'role_event.dart';

part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final UserRepository userRepository;
  int page = 1;
  bool isFetching = false;

  RoleBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  RoleState get initialState => RoleInitial();

  @override
  Stream<RoleState> mapEventToState(RoleEvent event) async* {
    if (event is GetRoleEvent) {
      if (!isFetching) {
        yield RoleLoading();
      } else {
        yield RoleLoadMore();
      }

      try {
        RoleModel roleModel = await userRepository.getRoleAPi(page: page);
        yield RoleSuccess(roleModel: roleModel);
        if (roleModel.data.isNotEmpty) {
          page++;
        }
      } on ValidationException catch (error) {
        yield ValidationError(errors: error.errors);
      } catch (e) {
        yield RoleFailure(
            error: CustomException.onConnectionException(e.toString()));
      }
    }
  }
}
