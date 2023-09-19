import 'notification_model.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  NotificationCard(this.notification, this.onTap, {super.key});

  notification_model notification;
  Function()? onTap;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/6.5,
                height: MediaQuery.of(context).size.width/6.5,
                margin: const EdgeInsets.only(
                  left: 8,
                  top: 9,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  // color: Colors.amber,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12/2),
                    topRight: Radius.circular(12/2),
                    bottomLeft: Radius.circular(12/2),
                    bottomRight: Radius.circular(12/2),
                  ),
                  color: Colors.grey.shade200,
                  image: DecorationImage(
                    image: AssetImage(widget.notification.thumbURL!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                heightFactor: .3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 8,
                        top: 8,
                      ),
                      width: MediaQuery.of(context).size.width/1.5,
                      child: Text(
                        widget.notification.titel!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            fontFamily: 'DM Sans',
                            height: (20 / 14)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 8,
                        top: 4,
                      ),
                      child: Text(
                        widget.notification.date!,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 127, 135, 147),
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
