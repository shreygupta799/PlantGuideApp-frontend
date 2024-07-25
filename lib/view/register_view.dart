import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/model/register_model.dart';
import 'package:frontend/res/components/round_button.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/view_model/auth_view_Model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode nameFocus = FocusNode();

  ValueNotifier<bool> obsecurePass = ValueNotifier<bool>(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    nameFocus.dispose();
    obsecurePass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
              controller: nameController,
              focusNode: nameFocus,
              decoration: const InputDecoration(
                hintText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusNode(context, nameFocus, emailFocus);
              }),
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
                  prefixIcon: const Icon(Icons.password),
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
              loading: authViewModel.Loading,
              onPress: () async {
                if (nameController.text.isEmpty) {
                  Utils.flushbarErrorMessage('Enter Name', context);
                } else if (emailController.text.isEmpty) {
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
                    'full_name': nameController.text.toString()
                  };
                  await authViewModel.registerUser(user, context);
                }
              }),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, RoutesName.login),
            child: const Text('Already have an account? Login',
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
