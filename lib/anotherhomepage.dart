import 'package:flutter/material.dart';
import 'package:frontend/categorychatscreen.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/data/dummy_data3.dart';
import 'package:frontend/data/dummy_data4.dart';
import 'package:frontend/widgets/interest.dart';
import 'package:frontend/widgets/topic.dart';

class AnotherHomePage extends StatefulWidget {
  const AnotherHomePage({Key? key}) : super(key: key);

  @override
  _AnotherHomePageState createState() => _AnotherHomePageState();
}

class _AnotherHomePageState extends State<AnotherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NEARIFY',
              style:
                  TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.w900)),
          automaticallyImplyLeading: false,
          actions: [
            // Add your profile image or icon here
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                //backgroundImage: NetworkImage('url_to_your_profile_image'),
                // or use AssetImage for a local image
                backgroundImage: AssetImage('assets/images/man.png'),
              ),
            ),
          ],
          backgroundColor: Color(0xff170746),
          // Add any additional app bar properties as needed
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                height: 250,
                color: Color.fromARGB(255, 238, 240, 241),
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Interests',
                      style: TextStyle(
                        color: Color(0xff170746),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 160, // Adjust the height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedInterests.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Interest(intcard: selectedInterests[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                  padding: EdgeInsets.all(12),
                  height: 140,
                  color: Color.fromARGB(255, 238, 240, 241),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Inbox',
                        style: TextStyle(
                          color: Color(0xff170746),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 0.05,
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(8),
                              child: Image.asset('assets/images/mail-box.png'),
                            ),

                            Text(
                              'Check Your Inbox',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            Spacer(), // Pushes the following widgets to the right
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                height: 560,
                color: Color.fromARGB(255, 238, 240, 241),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hottest Topics Around You',
                      style: TextStyle(
                        color: Color(0xff170746),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 435, // Adjust the height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: availableTopics.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Topic(topcard: availableTopics[index]);
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Container(
                          width: 350,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryChatScreen()),
            );
                            },
                            child: Text(
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
