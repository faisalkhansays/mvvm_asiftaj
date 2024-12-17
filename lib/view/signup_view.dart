import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../resources/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(title: Text('SignUp'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: emailFocusNode,
              onFieldSubmitted: (valu) {
                Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
              },
              decoration: InputDecoration(
                  hintText: 'Email', labelText: 'Email', prefixIcon: Icon(Icons.alternate_email)),
            ),
            SizedBox(height: height * 0.02),
            ValueListenableBuilder(
              valueListenable: _obsecurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obsecurePassword.value,
                  focusNode: passwordFocusNode,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: InkWell(
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: Icon(_obsecurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility))),
                );
              },
            ),
            SizedBox(height: height * .07),
            RoundButton(
                title: 'Sign Up',
                loading: authViewMode.signUpLoading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.toastMessage("Email Field is Empty");
                  } else if (_passwordController.text.isEmpty) {
                    Utils.toastMessage("Password Field is empty");
                  } else if (_passwordController.text.length < 6) {
                    Utils.toastMessage("Password was too short");
                  } else {
                    Map data = {
                      'email': _emailController.text.toString(),
                      'password': _passwordController.text.toString(),
                    };
                    authViewMode.signUpApi(data, context);
                    print("api hit");
                  }
                }),
            SizedBox(height: height * .02),
            InkWell(onTap: () {
              Navigator.pushNamed(context, RoutesName.login);
            }, child: Text("Already have an account? Login"))
          ],
        ),
      ),
    );
  }
}
