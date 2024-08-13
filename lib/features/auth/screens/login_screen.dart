import 'package:airbnb/features/auth/screens/signup_screen.dart';
import 'package:airbnb/features/auth/widget/form_field.dart';
import 'package:airbnb/util/extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static String get loginRoute => '/';

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText=true;



  void signInWithEmailAndPassword(
      WidgetRef ref, String email, String password, BuildContext context) async {
      await ref
          .read(authControllerProvider.notifier)
          .logInWithEmailAndPassword(email, password, context);

  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state=ref.watch(authControllerProvider);
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Welcome Back",
                  style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Login to your account',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 35),
                  CustomFormField(
                    label: const Text("Email or Username"),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r' ')),
                      FilteringTextInputFormatter.deny(RegExp(r'\n')),

                    ],
                    controller: email,
                    hintText: "Enter Username or Email",
                    labelText: "Email or Username",
                    validateFunction: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      if(val.isValidName | val.isValidEmail){
                        return null;
                      }
                      return "Not Valid Email Or Username";

                    },

                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    label: const Text("Password"),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r' ')),
                      FilteringTextInputFormatter.deny(RegExp(r'\n')),
                    ],
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        obscureText=!obscureText;
                      });
                    } ,icon:  obscureText ? const Icon(Icons.visibility) :const Icon(Icons.visibility_off) ,),
                    obscureText: obscureText,
                    controller: password,
                    hintText: "Enter your Password",
                    labelText: "Password",
                    validateFunction: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      if(val.isValidPassword){
                        return null;
                      }
                      return "Minimum length of 8 characters";
                    },
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed:state.isLoading ? (){}:  () {
                      if (_formKey.currentState!.validate()) {
                        signInWithEmailAndPassword(ref, email.value.text,
                            password.value.text, context);
                      }
                    },
                    child:state.isLoading ?  const SizedBox( width: 8.0,height: 8.0,child: Center(child: CircularProgressIndicator(color: Colors.white,))): const Text("Login"),
                  ),
                  TextButton(
                      onPressed: () {
                        context.push(SignupScreen.signUpRoute);
                      },
                      child: const Text(
                        "Don't Have account ",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
