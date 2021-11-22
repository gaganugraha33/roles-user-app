import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_roles_user_app/component/Skeleton.dart';
import 'package:flutter_roles_user_app/menu/create_role_menu/CreateRoleScreen.dart';
import 'package:flutter_roles_user_app/menu/role_menu/model/RoleModel.dart';
import 'package:flutter_roles_user_app/repository/UserRepository.dart';

import '../../Dictionary.dart';
import 'bloc/role_bloc.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key key}) : super(key: key);

  @override
  _RoleScreenState createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  final ScrollController _scrollController = ScrollController();
  RoleBloc _roleBloc;
  List<Role> _roleData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RoleBloc>(
          create: (BuildContext context) => _roleBloc =
              RoleBloc(userRepository: UserRepository())..add(GetRoleEvent()),
          child: BlocListener<RoleBloc, RoleState>(
            listener: (context, state) async {
              if (state is RoleLoadMore) {
                if (_roleBloc.isFetching) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(Dictionary.loadMore)));
                }
              } else if (state is RoleSuccess) {
                _roleBloc.isFetching = false;
                _roleData.addAll(state.roleModel.data);
              } else if (state is ValidationError) {
                _roleBloc.isFetching = false;
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
                _roleBloc.isFetching = false;
              }
            },
            child: BlocBuilder<RoleBloc, RoleState>(
              builder: (context, state) => state is RoleLoading
                  ? _buildLoading()
                  : state is RoleSuccess
                      ? _buildContent()
                      : state is RoleFailure
                          ? _buildFailure(state)
                          : _buildContent(),
            ),
          )),
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
    return _roleData.isNotEmpty
        ? Container(
            child: ListView.builder(
              itemCount: _roleData.length,
              controller: _scrollController
                ..addListener(() {
                  if (_scrollController.offset ==
                          _scrollController.position.maxScrollExtent &&
                      !_roleBloc.isFetching) {
                    _roleBloc.isFetching = true;
                    _roleBloc.add(GetRoleEvent());
                  }
                }),
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      _roleData[index].title.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    subtitle: Html(
                      data: _roleData[index].description.toString(),
                      defaultTextStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              Dictionary.dataEmpty,
              textScaleFactor: 3,
            ),
          );
  }

  _buildFailure(RoleFailure state) {
    return Center(child: Text(state.error, textScaleFactor: 3));
  }

  _addNewRole() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateRoleScreen()),
    );
  }

  @override
  void dispose() {
    _roleBloc.close();
    _scrollController.dispose();
    super.dispose();
  }
}
