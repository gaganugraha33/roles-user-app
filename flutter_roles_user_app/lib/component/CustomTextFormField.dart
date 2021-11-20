import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Dictionary.dart';

class CustomTextFormField extends StatefulWidget {
  ///Component for build custom textfield

  final String title;
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final TextStyle textStyle;
  final int maxLines;
  final FocusNode focusNode;
  final dynamic validation;
  final int limitCharacter;

  CustomTextFormField(
      {Key key,
      this.title,
      this.controller,
      this.validation,
      this.hintText,
      this.textInputType,
      this.textStyle,
      this.maxLines,
      this.focusNode,
      this.limitCharacter})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                Dictionary.requiredForm,
                style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLines: widget.maxLines != null ? widget.maxLines : 1,
            style: TextStyle(color: Colors.black, fontSize: 14),
            focusNode: widget.focusNode,
            validator: widget.validation,
            maxLength: widget.limitCharacter,
            textCapitalization: TextCapitalization.words,
            controller: widget.controller,
            inputFormatters: widget.textInputType == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              errorMaxLines: 2,
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red, width: 1.5)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400], width: 1.5)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400], width: 1.5)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400], width: 1.5)),
            ),
            keyboardType: widget.textInputType != null
                ? widget.textInputType
                : TextInputType.text,
          ),
        ],
      ),
    );
  }
}
