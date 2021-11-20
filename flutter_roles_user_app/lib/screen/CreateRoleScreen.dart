import 'package:flutter/material.dart';
import 'package:flutter_roles_user_app/component/CustomTextFormField.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Create Role'),
          ),
          body: ListView(
            padding: EdgeInsets.all(10.0),
            children: [
              CustomTextFormField(
                  title: 'Title',
                  hintText: 'Input name of role',
                  controller: _titleTextController),
              const SizedBox(height: 10),
              CustomTextFormField(
                  title: 'Description',
                  hintText: 'Input description of role',
                  controller: _descriptionTextController),
              const SizedBox(height: 10),
              CustomTextFormField(
                  title: 'Requirement',
                  hintText: 'Input requirement of role',
                  controller: _requirementTextController),
              const SizedBox(height: 10),
            ],
          ),
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
                }
              },
            ),
          )),
    );
  }
}
