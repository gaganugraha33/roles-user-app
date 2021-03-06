import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roles_user_app/component/BlockCircleLoading.dart';
import 'package:flutter_roles_user_app/component/CustomTextFormField.dart';
import 'package:flutter_roles_user_app/component/DialogTextOnly.dart';
import 'package:flutter_roles_user_app/main.dart';
import 'package:flutter_roles_user_app/repository/UserRepository.dart';

import '../../Dictionary.dart';
import 'bloc/create_role_bloc.dart';

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
          title: Text(Dictionary.createRole),
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
                  barrierDismissible: false,
                  builder: (BuildContext context) => DialogTextOnly(
                    description: Dictionary.createRoleSucceess,
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
                builder: (context, state) => Column(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(10.0),
                            children: [
                              CustomTextFormField(
                                  title: Dictionary.title,
                                  hintText: Dictionary.hintRole,
                                  controller: _titleTextController,
                                  validation: _validationCheck),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                  title: Dictionary.description,
                                  hintText: Dictionary.hintDescription,
                                  controller: _descriptionTextController,
                                  validation: _validationCheck),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                  title: Dictionary.requirement,
                                  hintText: Dictionary.hintRequirement,
                                  controller: _requirementTextController,
                                  validation: _validationCheck),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
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
                                Dictionary.submit,
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
                                    description:
                                        _descriptionTextController.text,
                                    requirement:
                                        _requirementTextController.text));
                              }
                            },
                          ),
                        )
                      ],
                    )),
          ),
        ),
      ),
    );
  }

  String _validationCheck(String value) {
    if (value == null || value.isEmpty) {
      return Dictionary.validation;
    }
    return null;
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _requirementTextController.dispose();
    _descriptionTextController.dispose();
    _createRoleBloc.close();
    super.dispose();
  }
}
