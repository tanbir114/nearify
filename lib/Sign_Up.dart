import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'login_page.dart';
import 'homepage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:frontend/current_location.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool _isNotValidateemail = false;
  bool _isNotValidatepassword = false;
  bool _isNotValidatephone = false;
  bool _isNotValidateusername = false;

  late Size mediaS;

  bool validatePhoneNumber(String phoneNumber) {
    // A basic example: check if the input is numeric and has a minimum length
    final numericRegex = RegExp(r'^[0-9]+$');
    if (numericRegex.hasMatch(phoneNumber) && phoneNumber.length == 11) {
      return true;
    } else {
      return false;
    }
  }

  void registerUser() async {
    if (usernameController.text.isEmpty) {
      print(_isNotValidateusername);
      setState(() {
        _isNotValidateusername = true;
      });
    } else {
      setState(() {
        _isNotValidateusername = false;
      });
    }
    if (EmailValidator.validate(emailController.text)) {
      setState(() {
        _isNotValidateemail = false;
      });
    } else {
      setState(() {
        _isNotValidateemail = true;
      });
    }
    if (validatePhoneNumber(phoneController.text)) {
      setState(() {
        _isNotValidatephone = false;
      });
    } else {
      setState(() {
        _isNotValidatephone = true;
      });
    }
    if (passwordController.text.length >= 6) {
      setState(() {
        _isNotValidatepassword = false;
      });
    } else {
      setState(() {
        _isNotValidatepassword = true;
      });
    }

    if (!_isNotValidateemail &&
        !_isNotValidatephone &&
        !_isNotValidatepassword &&
        !_isNotValidateusername) {
      Position position = await CurrentLocation();

      print(position.latitude);
      print(position.longitude);

      var regBody = {
        "name": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phone_no": phoneController.text,
        "latitude": position.latitude,
        "longitude": position.longitude
      };

      var response = await http.post(Uri.parse(registration),
          headers: {"Content-type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      } else {
        print("Something went wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaS = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Last.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 100, top: 120),
              child: const Text(
                'Welcome',
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          TextField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Username",
                                labelText: 'Username',
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                errorText: _isNotValidateusername
                                    ? "Enter Proper Info"
                                    : null,
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 219, 34, 21),
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            // obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                labelText: 'Email Address',
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                errorText: _isNotValidateemail
                                    ? "Enter Proper Info"
                                    : null,
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 219, 34, 21),
                                    fontWeight: FontWeight.bold),
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            // obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                labelText: 'Mobile Number',
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                hintText: "Mobile Number",
                                errorText: _isNotValidatephone
                                    ? "Enter Proper Info"
                                    : null,
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 219, 34, 21),
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                errorText: _isNotValidatepassword
                                    ? "Enter Proper Info"
                                    : null,
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 219, 34, 21),
                                    fontWeight: FontWeight.bold),
                                hintText:
                                    'Enter your password (min. 6 characters)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 71, 152, 60),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      registerUser();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
Widget Buildtext (BuildContext context)
{
  
  return  SizedBox(

            width: MediaQuery.of(context).size .width,
     

        
                  child: const Text("Ok testing",
                      style: TextStyle(
                        backgroundColor: Color.fromARGB(132, 48, 198, 10),
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 40,
                      ))
                
              );
              
              
  
}
*/
