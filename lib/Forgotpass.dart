import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late Size mediaSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Forgot3.png"),
          fit: BoxFit.cover,
        ),
      ),
      /*child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              padding: EdgeInsets.all(32.0),
              child: Center(
                  child: Column(
                    Positioned(
               ),
           ),
       ),
     ),*/

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              //color: const Color.fromARGB(255, 100, 100, 100),
              padding: const EdgeInsets.only(left: 90, top: 475),
              child: const Text(
                'Reset Password',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 60, 199), fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5 + 25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 90,
                          ),
                          TextField(
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 212, 219, 225),
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Restore',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 22, 114, 10),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 70),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(255, 241, 206, 46),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );

    /*return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Forgot2.png"),
          fit: BoxFit.cover,
        ),
      ),
      
      child:const Scaffold(
           
          backgroundColor: Colors.transparent,
          body: Stack(
            

            children: [
              SizedBox(height: 90),
              
              
            Container(
              padding: EdgeInsets.only(left: 100, top: 120),
              child: Text(
                
                'Welcome',
                style: TextStyle(
                    color: Color.fromARGB(255, 11, 11, 11), fontSize: 35),
              ),
            ),
            ],
          ),
          ),
    );*/
  }
}
