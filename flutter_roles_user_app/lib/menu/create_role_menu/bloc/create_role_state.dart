part of 'create_role_bloc.dart';

abstract class CreateRoleState extends Equatable {
  const CreateRoleState([List props = const <dynamic>[]]);
}

class CreateRoleInitial extends CreateRoleState {
  @override
  List<Object> get props => [];
}

class CreateRoleLoading extends CreateRoleState {
  @override
  String toString() {
    return 'State CreateRoleLoading';
  }

  @override
  List<Object> get props => [];
}

class CreateRoleSuccess extends CreateRoleState {
  final CreateRoleModel createRoleModel;

  const CreateRoleSuccess({@required this.createRoleModel});

  @override
  String toString() {
    return 'State CreateRoleSuccess';
  }

  @override
  List<Object> get props => [];
}

class ValidationError extends CreateRoleState {
  final Map<String, dynamic> errors;

  ValidationError({@required this.errors}) : super([errors]);

  @override
  String toString() {
    return 'State ValidationError{errors: $errors}';
  }

  @override
  List<Object> get props => <Object>[errors];
}

class CreateRoleFailure extends CreateRoleState {
  final String error;

  CreateRoleFailure({this.error});

  @override
  String toString() {
    return 'State CreateRoleFailure{error: $error}';
  }

  @override
  List<Object> get props => <Object>[error];
}
