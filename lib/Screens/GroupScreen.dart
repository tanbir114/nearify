// ignore_for_file: avoid_print

import 'package:frontend/CustomUI/OwnFileCard.dart';
import 'package:frontend/CustomUI/OwnMessageCard.dart';
import 'package:frontend/CustomUI/ReplyFileCard.dart';
import 'package:frontend/CustomUI/ReplyGroupCard.dart';
import 'package:frontend/Screens/CameraScreen.dart';
import 'package:frontend/Screens/CameraView.dart';
import 'package:frontend/models/MessageModel.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:frontend/user_model.dart';
import 'package:frontend/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class GroupScreen extends StatefulWidget {
  final String name;
  final List<dynamic> onlineGridItemIds;
  const GroupScreen(
      {Key? key, required this.name, required this.onlineGridItemIds})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  var popTime = 0;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });

    fetchOldMsg();
    connect();
  }

  void fetchOldMsg() async {
    var reqBody = {
      "groupId": widget.name,
    };

    var response = await http.post(Uri.parse(oldGroupMessage),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> msgList = data['msg'];

    for (Map<String, dynamic> message in msgList) {
      String? type;
      String? messageContent = message['message'];
      String? time = message['time'];
      String? path;
      String? senderId = message['userId'];
      String? senderName = message['senderName'];
      if (userId != senderId) {
        type = "destination";
        path = message['dest_path'];
      } else {
        type = "source";
        path = message['src_path'];
      }

      if (messageContent != null) {
        setMessage(type, messageContent, time, path, senderName);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 0), curve: Curves.easeOut);
      }
    }
  }

  void connect() {
    socket = IO.io(url, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();

    socket.onDisconnect((_) => print('Disconnected'));

    socket.onConnect((data) {
      socket.emit("joinGroup", widget.name);

      socket.on("grpmessage", (msg) {
        var time = DateTime.now().toString().substring(10, 16);

        if (msg["sourceId"] != userId) {
          setMessage("destination", msg["message"], time, msg["path"],
              msg["senderName"]);
        }

        if (_scrollController.positions.isNotEmpty &&
            _scrollController.position.extentAfter == 0.0) {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        }
      });
    });
  }

  void sendMessage(
      String message, String sourceId, String targetId, String path) async {
    var time = DateTime.now().toString().substring(10, 16);

    setMessage("source", message, time, path, userName);
    socket.emit("grpmessage", {
      "groupId": widget.name,
      "message": message,
      "sourceId": userId,
      "path": path,
      "senderName": userName,
    });

    var reqBody = {
      "message": message,
      "userId": userId,
      "groupId": widget.name,
      "time": time,
      "src_path": path,
      "dest_path": path,
      "senderName": userName,
    };
    await http.post(Uri.parse(sentGroupMessage),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

  }

  void onImageSend(String path, String message) async {
    for (int i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popTime = 0;
    });

    var request = http.MultipartRequest("POST", Uri.parse(addImage));
    request.files.add(await http.MultipartFile.fromPath('img', path));
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    http.StreamedResponse response = await request.send();

    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);

    var time = DateTime.now().toString().substring(10, 16);

    setMessage("source", message, time, path, userName);

    socket.emit("grpmessage", {
      "message": message,
      "sourceId": userId,
      "targetId": widget.name,
      "path": data['path'],
      "senderName": userName,
      "groupId": widget.name,
    });

    var reqBody = {
      "message": message,
      "userId": userId,
      "groupId": widget.name,
      "time": time,
      "src_path": path,
      "dest_path": data['path'],
      "senderName": userName,
    };

    await http.post(Uri.parse(sentGroupMessage),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
  }

  void setMessage(String type, String message, time, path, senderName) async {
    MessageModel messageModel = MessageModel(
        type: type, message: message, time: time, path: path, name: senderName);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.onDisconnect((_) => print('Disconnected'));
    super.dispose();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        // widget.chatModel.isGroup!
                        // ? "assets/groups.svg"
                        // :
                        "assets/person.svg",
                        // color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            margin: const EdgeInsets.only(right: 5),
                          ),
                          const Text(
                            "Online",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
                IconButton(icon: const Icon(Icons.call), onPressed: () {}),
                PopupMenuButton<String>(
                  padding: const EdgeInsets.all(0),
                  onSelected: (value) {},
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      const PopupMenuItem(
                        value: "View Contact",
                        child: Text("View Contact"),
                      ),
                      const PopupMenuItem(
                        value: "Media, links, and docs",
                        child: Text("Media, links, and docs"),
                      ),
                      const PopupMenuItem(
                        value: "Whatsapp Web",
                        child: Text("Whatsapp Web"),
                      ),
                      const PopupMenuItem(
                        value: "Search",
                        child: Text("Search"),
                      ),
                      const PopupMenuItem(
                        value: "Mute Notification",
                        child: Text("Mute Notification"),
                      ),
                      const PopupMenuItem(
                        value: "Wallpaper",
                        child: Text("Wallpaper"),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      // reverse: true,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          if (messages[index].path != "" &&
                              messages[index].path != null) {
                            return OwnFileCard(
                              path: "${messages[index].path}",
                              message: "${messages[index].message}",
                              time: "${messages[index].time}",
                            );
                          } else {
                            return OwnMessageCard(
                              message: "${messages[index].message}",
                              time: "${messages[index].time}",
                            );
                          }
                        } else {
                          if (messages[index].path != "" &&
                              messages[index].path != null) {
                            return ReplyFileCard(
                              path: "${messages[index].path}",
                              message: "${messages[index].message}",
                              time: "${messages[index].time}",
                            );
                          } else {
                            return ReplyGroupCard(
                              senderName: "${messages[index].name}",
                              message: "${messages[index].message}",
                              time: "${messages[index].time}",
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          show
                                              ? Icons.keyboard
                                              : Icons.emoji_emotions_outlined,
                                        ),
                                        onPressed: () {
                                          if (!show) {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                          }
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.attach_file),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.camera_alt),
                                            onPressed: () {
                                              setState(() {
                                                popTime = 2;
                                              });

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          CameraScreen(
                                                            onImageSend:
                                                                onImageSend,
                                                          )));
                                            },
                                          ),
                                        ],
                                      ),
                                      contentPadding: const EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 2,
                                  left: 2,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: const Color(0xFF128C7E),
                                  child: IconButton(
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(_controller.text,
                                            "{$userId}", widget.name, "");
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigo,
                      "Document", () {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera", () {
                    setState(() {
                      popTime = 2;
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CameraScreen(
                                  onImageSend: onImageSend,
                                )));
                  }),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",
                      () async {
                    setState(() {
                      popTime = 2;
                    });
                    file = await _picker.pickImage(source: ImageSource.gallery);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CameraViewPage(
                                  path: file!.path,
                                  onImageSend: onImageSend,
                                )));
                  }),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio", () {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                      Icons.location_pin, Colors.teal, "Location", () {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact", () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icons, Color color, String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        config: const Config(
          columns: 7,
        ),
        onEmojiSelected: (emoji, category) {
          setState(() {
            _controller.text = '${_controller.text}$emoji';
          });
        });
  }
}
