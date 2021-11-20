import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roles_user_app/component/Skeleton.dart';
import 'package:flutter_roles_user_app/repository/UserRepository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../blocs/user_bloc/user_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserBloc _userBloc;
  RefreshController _mainRefreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<UserBloc>(
      create: (BuildContext context) => _userBloc =
          UserBloc(userRepository: UserRepository())..add(GetUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => SmartRefresher(
            controller: _mainRefreshController,
            enablePullDown: true,
            header: WaterDropMaterialHeader(),
            onRefresh: refresh,
            child: state is UserLoading
                ? _buildLoading()
                : state is UserSuccess
                    ? _buildContent(state)
                    : state is UserFailure
                        ? _buildFailure(state)
                        : Container()),
      ),
    ));
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
                'Loading',
              ),
              subtitle: Text('Loading'),
              trailing: Text('Loading'),
            ),
          );
        },
      ),
    );
  }

  _buildContent(UserSuccess state) {
    return Container(
      child: ListView.builder(
        itemCount: state.userModel.data.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                state.userModel.data[index].fullname,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: Text(
                state.userModel.data[index].email,
                style: TextStyle(color: Colors.black),
              ),
              trailing: Text(
                state.userModel.data[index].phone,
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildFailure(UserFailure state) {
    return Container();
  }

  Future<void> refresh() async {
    _userBloc.add(GetUserEvent());
    _mainRefreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }
}
