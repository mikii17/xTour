import 'package:flutter/material.dart';
import '../custom/custom_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic
      final username = _usernameController.text;
      final password = _passwordController.text;

      // Do something with the form values
      // ...
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "mytrial",
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("X-tour"),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Hi,\nWelcome Back',
                      style: TextStyle(
                        fontSize: 50,
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
                    height: 70,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: _validateUsername,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 185),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'forgot password?',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 12, 77, 198),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(250, 40),
                    ),
                    child: const Text('login'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onPressed: () {},
                    text: 'Signup',
                    backgroundGradient: const [
                      Colors.white,
                      Colors.white,
                    ],
                    textColor: Colors.black,
                    borderRadius: 20,
                    borderColor: const Color.fromRGBO(15, 57, 224, 0.992),
                    width: 250,
                    height: 40,
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

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final List<Color> backgroundGradient;
  final Color textColor;
  final double borderRadius;
  final Color borderColor;
  final double width;
  final double height;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.backgroundGradient,
    required this.textColor,
    required this.borderRadius,
    required this.borderColor,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: backgroundGradient.isNotEmpty ? null : Colors.blue,
          onPrimary: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
