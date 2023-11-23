import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:frontend/categoryscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'login_page.dart';
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
  bool rememberUser = false;

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
    print("why??????");
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
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryScreen(userEmail: emailController.text)));
      } else {
        print("Something went wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaS = MediaQuery.of(context).size;
    // bool checkboxval = false;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff170746),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            children: [
                              Text(
                                'Sign Up!',
                                style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'We know you dont have friends, let us\nhelp make you some',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xffC3C5FF),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 24, top: 20, bottom: 20),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Username",
                                //labelText: 'Username',
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                errorText: _isNotValidateusername
                                    ? "Enter Proper Info"
                                    : null,
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 219, 34, 21),
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 24, top: 20, bottom: 20),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email Address",
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                errorText: _isNotValidateusername
                                    ? "Enter Proper Info"
                                    : null,
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 219, 34, 21),
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 24, top: 20, bottom: 20),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Phone Number",
                                //labelText: 'Username',
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                errorText: _isNotValidateusername
                                    ? "Enter Proper Info"
                                    : null,
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 219, 34, 21),
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 24, top: 20, bottom: 20),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password (min 6 characters)",
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                errorText: _isNotValidateusername
                                    ? "Enter Proper Info"
                                    : null,
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 219, 34, 21),
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: rememberUser,
                                onChanged: (value) {
                                  setState(() {
                                    rememberUser = value!;
                                  });
                                },
                              ),
                              const Text(
                                "I promise that I won't kidnap anyone",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8 ,
                                height: 60,
                                child: ElevatedButton(
                                    onPressed: () {
                                      registerUser();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    )),
                              ),
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