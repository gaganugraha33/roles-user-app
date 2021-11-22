import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_roles_user_app/exceptions/CustomException.dart';
import 'package:flutter_roles_user_app/exceptions/ValidationException.dart';
import 'package:flutter_roles_user_app/menu/user_menu/model/UserModel.dart';
import 'package:flutter_roles_user_app/repository/UserRepository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  int page = 1;
  bool isFetching = false;

  UserBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUserEvent) {
      if (!isFetching) {
        yield UserLoading();
      } else {
        yield UserLoadMore();
      }

      try {
        UserModel userModel = await userRepository.getUserAPi(page: page);
        yield UserSuccess(userModel: userModel);
        if (userModel.data.isNotEmpty) {
          page++;
        }
      } on ValidationException catch (error) {
        yield ValidationError(errors: error.errors);
      } catch (e) {
        yield UserFailure(
            error: CustomException.onConnectionException(e.toString()));
      }
    }
  }
}
