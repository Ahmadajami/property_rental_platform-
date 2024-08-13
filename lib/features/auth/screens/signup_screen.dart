import 'package:airbnb/features/auth/controller/auth_controller.dart';
import 'package:airbnb/features/auth/widget/form_field.dart';
import 'package:airbnb/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static String get signUpRoute => '/signUp';
  const SignupScreen({super.key});

  @override
  ConsumerState createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final emailVisibility = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  final name = TextEditingController();
  String? gender;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final List<String> optionList = ["Male", "Female"];
  //controllers
  //UI
  EdgeInsets padding = const EdgeInsets.symmetric(vertical: 12.0);
  late bool passwordObscureText = false;
  late bool confirmPasswordObscureText = false;
  //UI

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 50);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera,imageQuality:50,preferredCameraDevice: CameraDevice.front );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void showBottom(BuildContext context) {
    Scaffold.of(context).showBottomSheet(
      (context) => TapRegion(
        onTapOutside: (event) => Navigator.pop(context),
        child: Container(
          height: 200,
          color: const Color.fromARGB(255, 237, 238, 238),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Picking Image",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text(
                        'Camera',

                      ),
                      onPressed: () {
                        pickImageFromCamera();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text(
                        'Gallery',

                      ),
                      onPressed: () {
                        pickImageFromGallery();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  void signup(BuildContext context, bool mounted) {
    if (_formKey.currentState!.validate()) {
      final body = <String, dynamic>{
        "username": username.text,
        "email": email.text,
        "emailVisibility": true,
        "password": password.text,
        "passwordConfirm": passwordConfirm.text,
        "name": name.text,
        "gender": gender == "Male" ?"male" : "female",
      };
      ref
          .read(authControllerProvider.notifier)
          .signup(body, context, mounted, _image);
    }
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
    gender=null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
        backgroundColor: Colors.transparent,
      ),
      body: ref.watch(authControllerProvider).whenOrNull(
          data: (data) => Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Let's Create a  \n New Account",
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Enter your Data',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 35),
                        //name
                        Padding(
                          padding: padding,
                          child: CustomFormField(
                            label: const Text("Name"),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r' ')),
                              FilteringTextInputFormatter.deny(RegExp(r'\n')),
                            ],
                            controller: name,
                            hintText: "Enter your Name ",
                            labelText: " Name",
                            validateFunction: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Required';
                              }
                              if (val.isValidName) {
                                return null;
                              }
                              return "Not Valid Name";
                            },
                          ),
                        ),

                        //username
                        Padding(
                          padding: padding,
                          child: CustomFormField(
                            label: const Text("UserName"),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r' ')),
                              FilteringTextInputFormatter.deny(RegExp(r'\n')),
                            ],
                            controller: username,
                            hintText: "Enter your Username",
                            labelText: "Username",
                            validateFunction: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),

                        //email
                        Padding(
                          padding: padding,
                          child: CustomFormField(
                            label: const Text("Email"),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r' ')),
                              FilteringTextInputFormatter.deny(RegExp(r'\n')),
                            ],
                            controller: email,
                            hintText: "Enter your Email",
                            labelText: "Email",
                            validateFunction: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Required';
                              }
                              if (val.isValidEmail) {
                                return null;
                              }
                              return "is Not Valid Email";
                            },
                          ),
                        ),

                        //Gender
                        DropdownButtonFormField<String>(
                          elevation: 10,
                          decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              labelText: "Gender",
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          value: gender,
                          hint: const Text('Male or Female'),
                          items: optionList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              gender = value ?? "";
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an option';
                            }
                            return null;
                          },
                        ),

                        //password
                        Padding(
                          padding: padding,
                          child: CustomFormField(
                            label: const Text("Password"),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r' ')),
                              FilteringTextInputFormatter.deny(RegExp(r'\n')),
                            ],
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordObscureText = !passwordObscureText;
                                });
                              },
                              icon: passwordObscureText
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            obscureText: passwordObscureText,
                            controller: password,
                            hintText: "Enter your Password",
                            labelText: "Password",
                            validateFunction: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Required';
                              }
                              if (val.isValidPassword) {
                                return null;
                              }
                              return "Minimum length of 8 characters";
                            },
                          ),
                        ),

                        //Confirm Password
                        CustomFormField(
                          label: const Text("Connfirm Password"),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r' ')),
                            FilteringTextInputFormatter.deny(RegExp(r'\n')),
                          ],
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                confirmPasswordObscureText =
                                    !confirmPasswordObscureText;
                              });
                            },
                            icon: confirmPasswordObscureText
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          obscureText: confirmPasswordObscureText,
                          controller: passwordConfirm,
                          hintText: "Confirm your  Password",
                          labelText: "Confirm Password",
                          validateFunction: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Required';
                            }
                            if (val.isValidPassword) {
                              return null;
                            }
                            return "Minimum length of 8 characters";
                          },
                        ),

                        const SizedBox(height: 35),
                        //image Picker
                        Builder(builder: (context) {
                          return ElevatedButton(
                              onPressed: () => showBottom(context),
                              child: const Text(
                                "pick avatar image *optional ",

                              ));
                        })
                      ],
                    ),
                  ),
                ),
              ),
          loading: () => const Center(
                child: Text("Loading"),
              ),
          skipError: true),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => signup(context, mounted),
          style: ElevatedButton.styleFrom(
            elevation: 4.0,
            backgroundColor: Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
          child: const Text("SignUp"),
        ),
      ),
    );
  }
}
