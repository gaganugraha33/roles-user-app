part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent([List props = const <dynamic>[]]);
}

class GetUserEvent extends UserEvent {
  @override
  String toString() {
    return 'Event GetUserEvent';
  }

  @override
  List<Object> get props => [];
}
