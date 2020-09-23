import 'package:flutter/material.dart';

class AppRaisedButton extends StatelessWidget {

  AppRaisedButton({
    @required this.press,
    @required this.color,
    @required this.textColor,
    @required this.text,
  });

  final Function press;
  final Color color, textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 36),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}