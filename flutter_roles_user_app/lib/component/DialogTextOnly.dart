import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DialogTextOnly extends StatelessWidget {
  final String title, description, buttonText;
  final GestureTapCallback onOkPressed;
  final CrossAxisAlignment crossAxisAlignment;
  final AlignmentGeometry buttonAlignment;
  final Color descriptionColor, titleColor;
  final TextAlign textAlign;
  final bool isRaisedButton;

  DialogTextOnly(
      {Key key,
      @required this.description,
      @required this.buttonText,
      @required this.onOkPressed,
      this.title,
      this.titleColor,
      this.descriptionColor,
      this.textAlign,
      this.crossAxisAlignment,
      this.buttonAlignment,
      this.isRaisedButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  _dialogContent(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          crossAxisAlignment: crossAxisAlignment != null
              ? crossAxisAlignment
              : CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 14),
            title != null
                ? Text(
                    title,
                    textAlign: textAlign != null ? textAlign : TextAlign.left,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: titleColor),
                  )
                : Text(""),
            const SizedBox(height: 14),
            Text(
              description != null ? description : "",
              textAlign: textAlign != null ? textAlign : TextAlign.left,
              style: TextStyle(
                fontSize: 14.0,
                color: descriptionColor,
              ),
            ),
            const SizedBox(height: 24.0),
            !isRaisedButton
                ? Container(
                    alignment: buttonAlignment,
                    child: FlatButton(
                      onPressed: onOkPressed,
                      child: Text(
                        buttonText,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  )
                : RaisedButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: onOkPressed)
          ],
        ),
      ),
    );
  }
}
