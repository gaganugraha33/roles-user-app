import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roles_user_app/Dictionary.dart';
import 'package:flutter_roles_user_app/component/Skeleton.dart';
import 'package:flutter_roles_user_app/menu/user_menu/model/UserModel.dart';
import 'package:flutter_roles_user_app/repository/UserRepository.dart';

import 'bloc/user_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserBloc _userBloc;
  final ScrollController _scrollController = ScrollController();
  List<User> _userData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<UserBloc>(
        create: (BuildContext context) => _userBloc =
            UserBloc(userRepository: UserRepository())..add(GetUserEvent()),
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) async {
            if (state is UserLoadMore) {
              if (_userBloc.isFetching) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(Dictionary.loadMore)));
              }
            } else if (state is UserSuccess) {
              _userBloc.isFetching = false;
              _userData.addAll(state.userModel.data);
            } else if (state is ValidationError) {
              _userBloc.isFetching = false;
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(Dictionary.infoError),
                      content: Text(state.errors.toString()),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(Dictionary.ok)),
                      ],
                    );
                  });
            } else {
              _userBloc.isFetching = false;
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => state is UserLoading
                ? _buildLoading()
                : state is UserSuccess
                    ? _buildContent()
                    : state is UserFailure
                        ? _buildFailure(state)
                        : _buildContent(),
          ),
        ),
      ),
    );
  }

  _buildLoading() {
    return Skeleton(
      child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                Dictionary.loading,
              ),
              subtitle: Text(Dictionary.loading),
              trailing: Text(Dictionary.loading),
            ),
          );
        },
      ),
    );
  }

  _buildContent() {
    return Container(
      child: ListView.builder(
        controller: _scrollController
          ..addListener(() {
            if (_scrollController.offset ==
                    _scrollController.position.maxScrollExtent &&
                !_userBloc.isFetching) {
              _userBloc.isFetching = true;
              _userBloc.add(GetUserEvent());
            }
          }),
        itemCount: _userData.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                _userData[index].fullname,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: Text(
                _userData[index].email,
                style: TextStyle(color: Colors.black),
              ),
              trailing: Text(
                _userData[index].phone,
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildFailure(UserFailure state) {
    return Container(child: Text(state.error));
  }

  @override
  void dispose() {
    _userBloc.close();
    _scrollController.dispose();
    super.dispose();
  }
}
