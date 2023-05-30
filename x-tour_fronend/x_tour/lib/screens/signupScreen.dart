import 'package:flutter/material.dart';
import '../custom/custom_button.dart';
import '../custom/custom.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateRePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // Perform signup logic
      final fullName = _fullNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final rePassword = _rePasswordController.text;

      // Do something with the form values
      // ...
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X-tour',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('X-tour'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Get started with us',
                      style: TextStyle(
                        fontSize: 43,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [
                              Color.fromRGBO(85, 233, 242, 1),
                              Color.fromRGBO(95, 56, 249, 1),
                            ],
                          ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomTextField(
                    labelText: 'Your full name',
                    prefixIcon: Icons.person,
                    controller: _fullNameController,
                    borderRadius: 30,
                    onChanged: (value) {
                      // Handle the full name input value
                    },
                    validator: _validateFullName,
                    width: 380,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    controller: _emailController,
                    borderRadius: 30,
                    onChanged: (value) {
                      // Handle the email input value
                    },
                    validator: _validateEmail,
                    width: 380,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    controller: _passwordController,
                    borderRadius: 30,
                    onChanged: (value) {
                      // Handle the password input value
                    },
                    validator: _validatePassword,
                    obscureText: true,
                    width: 380,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    labelText: 'Re-Password',
                    prefixIcon: Icons.lock,
                    controller: _rePasswordController,
                    borderRadius: 30,
                    onChanged: (value) {
                      // Handle the re-password input value
                    },
                    validator: _validateRePassword,
                    obscureText: true,
                    width: 380,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10, left: 30),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Agree to terms and conditions check box is a method of protecting your business by requiring',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _signup,
                    child: const Text('Signup'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(250, 40),
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
