import 'package:flutter/material.dart';
import 'message_model.dart';

class MessageCard extends StatefulWidget {
  MessageCard(this.message, this.onTap, {super.key});

  message_model message;
  Function()? onTap;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child:
                      Image.asset(widget.message.thumbURL!, fit: BoxFit.fill),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 8,
                          top: 8,
                        ),
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          widget.message.name!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              fontFamily: 'DM Sans',
                              height: (20 / 14)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.7,
                        margin: const EdgeInsets.only(
                          left: 8,
                          top: 2,
                        ),
                        child: widget.message.messageCount <2
                            ? Text(
                                widget.message.message[0],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 127, 135, 147),
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            : Text(
                                '${widget.message.messageCount} new messages',
                                style: const TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w500,
                                  height: (15.62 / 12),
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                      ),
                      // const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              top: 4,
                            ),
                            child: const Text('12 hours ago',
                            style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      height: (15.62 / 12),
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 127, 135, 147)
                                    ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
