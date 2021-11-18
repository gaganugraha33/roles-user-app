part of 'role_bloc.dart';

abstract class RoleState extends Equatable {
  const RoleState([List props = const <dynamic>[]]);
}

class RoleInitial extends RoleState {
  @override
  List<Object> get props => [];
}

class RoleLoading extends RoleState {
  @override
  String toString() {
    return 'State RoleLoading';
  }

  @override
  List<Object> get props => [];
}

class RoleSuccess extends RoleState {
  final RoleModel roleModel;

  const RoleSuccess({@required this.roleModel});

  @override
  String toString() {
    return 'State RoleSuccess';
  }

  @override
  List<Object> get props => [];
}

class ValidationError extends RoleState {
  final Map<String, dynamic> errors;

  ValidationError({@required this.errors}) : super([errors]);

  @override
  String toString() {
    return 'State ValidationError{errors: $errors}';
  }

  @override
  List<Object> get props => <Object>[errors];
}

class RoleFailure extends RoleState {
  final String error;

  RoleFailure({this.error});

  @override
  String toString() {
    return 'State RoleFailure{error: $error}';
  }

  @override
  List<Object> get props => <Object>[error];
}
