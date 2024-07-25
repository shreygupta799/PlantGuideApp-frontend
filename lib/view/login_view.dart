import 'package:flutter/material.dart';
import 'package:frontend/res/components/round_button.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  ValueNotifier<bool> obsecurePass = ValueNotifier<bool>(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    obsecurePass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
              controller: emailController,
              focusNode: emailFocus,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusNode(context, emailFocus, passwordFocus);
              }),
          ValueListenableBuilder(
            valueListenable: obsecurePass,
            builder: (context, value, child) {
              return TextFormField(
                controller: passwordController,
                focusNode: passwordFocus,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(obsecurePass.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      obsecurePass.value = !obsecurePass.value;
                    },
                  ),
                ),
                obscureText: obsecurePass.value,
                onFieldSubmitted: (value) {
                  passwordFocus.unfocus();
                },
              );
            },
          ),
          SizedBox(height: height * .1),
          RoundButton(
              title: 'click',
              loading: loginViewModel.Loading,
              onPress: () async {
                if (emailController.text.isEmpty) {
                  Utils.flushbarErrorMessage('Enter Email', context);
                } else if (passwordController.text.isEmpty) {
                  Utils.flushbarErrorMessage('Enter Password', context);
                } else if (passwordController.text.length < 6) {
                  Utils.flushbarErrorMessage(
                      'Password must be 6 characters', context);
                } else {
                  Map user = {
                    'username': emailController.text.toString(),
                    'password': passwordController.text.toString(),
                  };
                  await loginViewModel.loginUser(user, context);
                }
              }),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, RoutesName.register),
            child: const Text('Don\'t have an account?',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 42, 179, 243),
                )),
          ),
        ],
      ),
    ));
  }
}
