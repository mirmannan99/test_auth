import 'package:flutter/material.dart';
import 'package:test_auth/controller/api_service__controller.dart';
import 'package:test_auth/features/authentication/models/auth_model.dart';
import 'package:test_auth/services/api_services.dart';

import '../../../components/text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailTc = TextEditingController();
  TextEditingController passTc = TextEditingController();

  ApiServices _apiServices = ApiServices();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'E-mail',
                    textController: emailTc,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: 'Password',
                    textController: passTc,
                    obscure: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildContainer(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      child: isLoading
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: clickedFunction,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
              ),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }

  clickedFunction() async {
    setState(() {
      isLoading = true;
    });
    AuthModel auth = AuthModel(email: emailTc.text, password: passTc.text);

    ApiControler response = await _apiServices.authenticate(auth);

    setState(() {
      isLoading = false;
    });

    if (response.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        buildSnackBar(response, Colors.red),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        buildSnackBar(response, Colors.greenAccent),
      );
    }
  }

  SnackBar buildSnackBar(ApiControler<dynamic> response, Color color) {
    return SnackBar(
      content: Text(
        response.message.toString(),
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
  }
}
