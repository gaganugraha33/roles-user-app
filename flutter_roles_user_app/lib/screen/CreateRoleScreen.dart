import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roles_user_app/blocs/create_role_bloc/create_role_bloc.dart';
import 'package:flutter_roles_user_app/component/BlockCircleLoading.dart';
import 'package:flutter_roles_user_app/component/CustomTextFormField.dart';
import 'package:flutter_roles_user_app/component/DialogTextOnly.dart';
import 'package:flutter_roles_user_app/main.dart';
import 'package:flutter_roles_user_app/repository/UserRepository.dart';

import '../Dictionary.dart';

class CreateRoleScreen extends StatefulWidget {
  const CreateRoleScreen({Key key}) : super(key: key);

  @override
  _CreateRoleScreenState createState() => _CreateRoleScreenState();
}

class _CreateRoleScreenState extends State<CreateRoleScreen> {
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _requirementTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CreateRoleBloc _createRoleBloc;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Create Role'),
          ),
          body: BlocProvider<CreateRoleBloc>(
              create: (BuildContext context) => _createRoleBloc =
                  CreateRoleBloc(userRepository: UserRepository()),
              child: BlocListener<CreateRoleBloc, CreateRoleState>(
                listener: (context, state) async {
                  if (state is CreateRoleLoading) {
                    await blockCircleLoading(context: context);
                  } else if (state is CreateRoleSuccess) {
                    Navigator.of(context, rootNavigator: true).pop();

                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => DialogTextOnly(
                        description: 'Create role success',
                        buttonText: Dictionary.ok,
                        onOkPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => MyApp(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    );
                  } else if (state is CreateRoleFailure) {
                    Navigator.of(context, rootNavigator: true).pop();

                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => DialogTextOnly(
                        description: state.error ?? Dictionary.somethingWrong,
                        buttonText: Dictionary.ok,
                        onOkPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop(); // To close the dialog
                        },
                      ),
                    );
                  } else if (state is ValidationError) {
                    Navigator.of(context, rootNavigator: true).pop();
                  } else {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                },
                child: BlocBuilder<CreateRoleBloc, CreateRoleState>(
                  builder: (context, state) => ListView(
                    padding: EdgeInsets.all(10.0),
                    children: [
                      CustomTextFormField(
                          title: 'Title',
                          hintText: 'Input name of role',
                          controller: _titleTextController,
                          validation: _validationCheck),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                          title: 'Description',
                          hintText: 'Input description of role',
                          controller: _descriptionTextController,
                          validation: _validationCheck),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                          title: 'Requirement',
                          hintText: 'Input requirement of role',
                          controller: _requirementTextController,
                          validation: _validationCheck),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              )),
          bottomSheet: Container(
            margin: EdgeInsets.all(10),
            height: 50,
            child: RaisedButton(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();
                  _createRoleBloc.add(PostRoleEvent(
                      title: _titleTextController.text,
                      description: _descriptionTextController.text,
                      requirement: _requirementTextController.text));
                }
              },
            ),
          )),
    );
  }

  String _validationCheck(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
