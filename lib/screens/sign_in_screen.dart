import 'package:flutter/material.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/screens/splash_screen.dart';
import 'package:placement_cell_app/utils/errorCallback.dart';
import 'package:placement_cell_app/utils/validators.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _email, _password;

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SafeArea(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildLogo1(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 16),
                                  TextFieldName(text: 'Email'),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "Example@gmail.com",
                                    ),
                                    validator: validateEmail,
                                    onSaved: (email) => _email = email!,
                                  ),
                                  SizedBox(height: 16),
                                  TextFieldName(text: 'Password'),
                                  TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "**********",
                                    ),
                                    validator: validatePassword,
                                    onSaved: (password) =>
                                        _password = password!,
                                    onChanged: (pass) => _password = pass,
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "FORGOT PASSWORD ?",
                                          ))),
                                ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() {
                                  _loading = true;
                                });

                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .signInWithEmailAndPassword(
                                        _email, _password, (e) {
                                  errorCallbackSignIn(e.code);
                                  setState(() {
                                    _loading = false;
                                  });
                                });
                              }
                            },
                            child: _loading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildLogo1 extends StatelessWidget {
  const BuildLogo1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/jntua_logo.png",
            ),
            Text(
              "Placements Cell",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16 / 3),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }
}
