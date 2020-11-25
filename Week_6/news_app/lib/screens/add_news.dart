import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/components/app_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddNewsScreen extends StatefulWidget {
  static const String _id = 'add_news';
  static String get id => _id;

  @override
  _AddNewsScreenState createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  String _userId, _title, _content, _description;
  File _imageFile;

  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  void _selectImage() async {
    final pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  void _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userId');
      print("User ID: $_userId");
    });
  }

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _submit();
    }
  }

  void _submit() async {
    try {
      var uri = Uri.parse('https://flutternewsapi.000webhostapp.com/addNews.php');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', _imageFile.path));
      request.fields['title'] = _title;
      request.fields['content'] = _content;
      request.fields['description'] = _description;
      request.fields['userId'] = _userId;
      print(_userId);
      print(_title);
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Uploading Success');
        Navigator.pop(context);
      } else {
        print('Uploading Failed');
      }
    } catch (e) {
    debugPrint('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget _placeholder = Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      child: Image.asset('assets/add-image.png'),
    );

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 64.0, 0, 32.0),
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: InkWell(
                      child: _imageFile == null ? _placeholder : Image.file(_imageFile, fit: BoxFit.scaleDown),
                      onTap: () {
                        _selectImage();
                      },
                    )
                  ),
                  AppTextFormField(
                    onSaved: (value) => _title = value,
                    inputType: TextInputType.emailAddress,
                    secure: false,
                    hint: "Title",
                    label: "Title",
                  ),
                  AppTextFormField(
                    onSaved: (value) => _content = value,
                    inputType: TextInputType.text,
                    secure: false,
                    hint: "Content",
                    label: "Content",
                  ),
                  AppTextFormField(
                    onSaved: (value) => _description = value,
                    inputType: TextInputType.text,
                    secure: false,
                    hint: "Description",
                    label: "Description",
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      onPressed: () => _validateForm(),
                      textColor: Colors.white,
                      color: Colors.black87,
                      child: Text("SUBMIT"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}