import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_roles_user_app/exceptions/CustomException.dart';
import 'package:flutter_roles_user_app/exceptions/ValidationException.dart';
import 'package:flutter_roles_user_app/model/CreateRoleModel.dart';
import 'package:flutter_roles_user_app/repository/UserRepository.dart';

part 'create_role_event.dart';

part 'create_role_state.dart';

class CreateRoleBloc extends Bloc<CreateRoleEvent, CreateRoleState> {
  final UserRepository userRepository;

  CreateRoleBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  CreateRoleState get initialState => CreateRoleInitial();

  @override
  Stream<CreateRoleState> mapEventToState(CreateRoleEvent event) async* {
    if (event is PostRoleEvent) {
      yield CreateRoleLoading();

      try {
        CreateRoleModel createRoleModel = await userRepository.createRoleAPi(
            title: event.title,
            description: event.description,
            requirement: event.requirement);
        yield CreateRoleSuccess(createRoleModel: createRoleModel);
      } on ValidationException catch (error) {
        yield ValidationError(errors: error.errors);
      } catch (e) {
        yield CreateRoleFailure(
            error: CustomException.onConnectionException(e.toString()));
      }
    }
  }
}
