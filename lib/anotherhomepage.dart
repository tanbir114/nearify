import 'package:flutter/material.dart';
import 'package:frontend/categorychatscreen.dart';
import 'package:frontend/data/dummy_data.dart';
import 'package:frontend/data/dummy_data3.dart';
import 'package:frontend/data/dummy_data4.dart';
import 'package:frontend/models/interestcard.dart';
import 'package:frontend/userProfile.dart';
import 'package:frontend/user_model.dart';
import 'package:frontend/widgets/interest.dart';
import 'package:frontend/widgets/topic.dart';

class AnotherHomePage extends StatefulWidget {
  const AnotherHomePage({Key? key}) : super(key: key);

  @override
  _AnotherHomePageState createState() => _AnotherHomePageState();
}

class _AnotherHomePageState extends State<AnotherHomePage> {
  var filteredCategories = availableCategories.where((category) {
    return tags!.any((tag) => tag == category.title);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NEARIFY',
              style: TextStyle(
                  color: Colors.amberAccent, fontWeight: FontWeight.w900)),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfile(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/man.png'),
                ),
              ),
            ),
          ],
          backgroundColor: const Color(0xff170746),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 250,
                color: const Color.fromARGB(255, 238, 240, 241),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Interests',
                      style: TextStyle(
                        color: Color(0xff170746),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredCategories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Interest(intcard: filteredCategories[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 140,
                  color: const Color.fromARGB(255, 238, 240, 241),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Inbox',
                        style: TextStyle(
                          color: Color(0xff170746),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 0.05,
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(8),
                              child: Image.asset('assets/images/mail-box.png'),
                            ),

                            const Text(
                              'Check Your Inbox',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            const Spacer(), // Pushes the following widgets to the right
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 560,
                color: const Color.fromARGB(255, 238, 240, 241),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hottest Topics Around You',
                      style: TextStyle(
                        color: Color(0xff170746),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 435, // Adjust the height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: availableTopics.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Topic(topcard: availableTopics[index]);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryChatScreen()),
                                );
                              },
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                  color: Color(0xff170746),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
