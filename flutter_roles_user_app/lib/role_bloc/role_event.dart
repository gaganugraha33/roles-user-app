part of 'role_bloc.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent([List props = const <dynamic>[]]);
}

class GetRoleEvent extends RoleEvent {
  @override
  String toString() {
    return 'Event GetRoleEvent';
  }

  @override
  List<Object> get props => [];
}
