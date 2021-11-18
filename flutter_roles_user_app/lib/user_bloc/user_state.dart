part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState([List props = const <dynamic>[]]);
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  String toString() {
    return 'State UserLoading';
  }

  @override
  List<Object> get props => [];
}

class UserSuccess extends UserState {
  final UserModel userModel;

  const UserSuccess({@required this.userModel});

  @override
  String toString() {
    return 'State UserSuccess';
  }

  @override
  List<Object> get props => [];
}

class ValidationError extends UserState {
  final Map<String, dynamic> errors;

  ValidationError({@required this.errors}) : super([errors]);

  @override
  String toString() {
    return 'State ValidationError{errors: $errors}';
  }

  @override
  List<Object> get props => <Object>[errors];
}

class UserFailure extends UserState {
  final String error;

  UserFailure({this.error});

  @override
  String toString() {
    return 'State UserFailure{error: $error}';
  }

  @override
  List<Object> get props => <Object>[error];
}
