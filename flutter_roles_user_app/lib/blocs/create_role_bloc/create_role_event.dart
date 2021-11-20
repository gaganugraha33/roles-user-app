part of 'create_role_bloc.dart';

abstract class CreateRoleEvent extends Equatable {
  const CreateRoleEvent([List props = const <dynamic>[]]);
}

class PostRoleEvent extends CreateRoleEvent {
  final String title;
  final String requirement;
  final String description;

  PostRoleEvent(
      {@required this.title,
      @required this.description,
      @required this.requirement});

  @override
  String toString() {
    return 'Event PostRoleEvent';
  }

  @override
  List<Object> get props => [title, description, requirement];
}
