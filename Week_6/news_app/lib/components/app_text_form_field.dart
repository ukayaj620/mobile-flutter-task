import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  AppTextFormField({
    @required this.hint,
    @required this.inputType,
    @required this.secure,
    @required this.onSaved,
  });

  final String hint;
  final TextInputType inputType;
  final bool secure;
  final ValueSetter<String> onSaved;

  static const TextStyle _textStyle = TextStyle(fontFamily: 'Roboto', fontSize: 16.0);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 16.0, 0, 0),
      child: TextFormField(
        validator: (value) => value.isEmpty ? "This field should be filled" : null,
        obscureText: this.secure,
        onSaved: this.onSaved,
        keyboardType: this.inputType,
        style: _textStyle,
        decoration: InputDecoration(
          labelText: 'Label text',
          hintText: this.hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}