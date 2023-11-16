import 'package:flutter/material.dart';
import 'notification_model.dart';
import 'notification_card.dart';
import 'message_model.dart';
import 'message_card.dart';

var screen_no = 0;

class Notifications extends StatefulWidget {
  Notifications(this.title, this.notification, this.message, {super.key});

  String? title;
  List<notification_model> notification;
  List<message_model> message;

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    // print(screen_no);
    return screen_no == 0
        ? Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            appBar: AppBar(
              title: Text(
                widget.title!,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'DM Scans'),
              ),
              backgroundColor: const Color(0xFFFFFFFF),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.notification.isEmpty
                      ? const SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No notifications',
                                  style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    height: (28 / 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            NotificationCard(widget.notification[0], () {}),
                            NotificationCard(widget.notification[1], () {}),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 99,
                                  height: 34,
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFB2B2B2)
                                            .withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 30,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          screen_no = 1;
                                        },
                                      );
                                    },
                                    child: const Text(
                                      "View all",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14,
                                        height: 1.3,
                                        color: Color(0xFF0A8ED9),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: const Text(
                      'Messages',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        height: (28 / 18),
                      ),
                    ),
                  ),
                  widget.message.isEmpty
                      ? const SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No Messages',
                                  style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    height: (28 / 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 15,),
                            MessageCard(widget.message[0], () {}),
                            MessageCard(widget.message[1], () {}),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 99,
                                  height: 34,
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFB2B2B2)
                                            .withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 30,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        screen_no = 2;
                                      });
                                    },
                                    child: const Text(
                                      "View all",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14,
                                        height: 1.3,
                                        color: Color(0xFF0A8ED9),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                ],
              ),
            ),
          )
        : screen_no == 1
            ? Scaffold(
                backgroundColor: const Color(0xFFF9F9F9),
                appBar: AppBar(
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            screen_no = 0;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'All ${widget.title}',
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'DM Scans'),
                      ),
                    ],
                  ),
                  backgroundColor: const Color(0xFFFFFFFF),
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: widget.notification.length,
                            itemBuilder: (context, index) => NotificationCard(
                                widget.notification[index], () {}),
                          ),
                        ),
                ),
              )
            : Scaffold(
                backgroundColor: const Color(0xFFF9F9F9),
                appBar: AppBar(
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            screen_no = 0;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'All Messages',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'DM Scans'),
                      ),
                    ],
                  ),
                  backgroundColor: const Color(0xFFFFFFFF),
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: widget.message.length,
                            itemBuilder: (context, index) =>
                                MessageCard(widget.message[index], () {}),
                          ),
                        ),
                ),
              );
  }
}
