import 'package:flutter/material.dart';
import 'Sign_Up.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Forgotpass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key,}): super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        // var myToken = jsonResponse['token'];
        // prefs.setString('token', myToken);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Homepage(
                    jsonResponse['name'],
                    emailController.text,
                    jsonResponse['phone_no'],
                    passwordController.text,
                    jsonResponse['_id'])));
      } else {
        print('Something went wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/bg3.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.9), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          // Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildBottom() {
    return SingleChildScrollView(
      child: SizedBox(
        width: mediaSize.width,
        // color: Color.fromARGB(0, 198, 201, 14),

        child: Card(
          color: const Color.fromARGB(188, 254, 255, 181),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            //child: Color.fromARGB(255, 30, 104, 207),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome Back",
            style: TextStyle(
                color: Color.fromARGB(255, 30, 104, 207),
                fontSize: 28,
                fontWeight: FontWeight.w500),
          ),
          //_buildGreyText("Please login with your information"),
          const Text(
            "Please login with your information",
            style: TextStyle(
                color: Color.fromARGB(255, 8, 93, 68),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10),

          _buildGreyText("Email"),
          _buildInputField(emailController),
          const SizedBox(height: 10),
          _buildGreyText("Password"),
          _buildInputField(passwordController, isPassword: true),
          const SizedBox(height: 10),
          _buildRememberForgot(),
          const SizedBox(height: 10),
          _buildLoginButton(),
          const SizedBox(height: 10),
          _buildOtherLogin(),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Color.fromARGB(255, 8, 93, 68),
          fontSize: 16,
          fontWeight: FontWeight.w500),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return SingleChildScrollView(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? const Icon(Icons.remove_red_eye)
              : const Icon(Icons.done),
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _buildRememberForgot() {
    return SingleChildScrollView(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreyText("Remember me"),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPassword()));
          },
          child: const Text(
            "I forgot my password",
            style: TextStyle(
                color: Color.fromARGB(255, 197, 19, 72),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        )
      ]),
    );
  }

  Widget _buildLoginButton() {
    return SingleChildScrollView(
      child: ElevatedButton(
        onPressed: () {
          print("log in pressed");
          debugPrint("Username : ${emailController.text}");
          debugPrint("Password : ${passwordController.text}");
          loginUser();
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: myColor,
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text("LOGIN"),
      ),
    );
  }

  Widget _buildOtherLogin() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          _buildGreyText("Don't have an account?"),
          const SizedBox(height: 10),
        ],
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const SignUp()));
        },
        child: const Text(
          "Sign Up",
          style: TextStyle(
              color: Color.fromARGB(255, 12, 131, 10),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      )
    ]);
  }
}
