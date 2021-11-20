import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_roles_user_app/blocs/role_bloc/role_bloc.dart';
import 'package:flutter_roles_user_app/component/Skeleton.dart';
import 'package:flutter_roles_user_app/repository/UserRepository.dart';
import 'package:flutter_roles_user_app/screen/CreateRoleScreen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key key}) : super(key: key);

  @override
  _RoleScreenState createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  RoleBloc _roleBloc;
  RefreshController _mainRefreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RoleBloc>(
        create: (BuildContext context) => _roleBloc =
            RoleBloc(userRepository: UserRepository())..add(GetRoleEvent()),
        child: BlocBuilder<RoleBloc, RoleState>(
          builder: (context, state) => SmartRefresher(
              controller: _mainRefreshController,
              enablePullDown: true,
              header: WaterDropMaterialHeader(),
              onRefresh: refresh,
              child: state is RoleLoading
                  ? _buildLoading()
                  : state is RoleSuccess
                      ? _buildContent(state)
                      : state is RoleFailure
                          ? _buildFailure(state)
                          : Container()),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: _addNewRole,
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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

  _buildContent(RoleSuccess state) {
    return Container(
      child: ListView.builder(
        itemCount: state.roleModel.data.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                state.roleModel.data[index].title.toString(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: Html(
                data: state.roleModel.data[index].description.toString(),
                defaultTextStyle: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildFailure(RoleFailure state) {
    return Container();
  }

  _addNewRole() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateRoleScreen()),
    );
  }

  Future<void> refresh() async {
    _roleBloc.add(GetRoleEvent());
    _mainRefreshController.refreshCompleted();
  }
}
