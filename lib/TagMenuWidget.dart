import 'package:flutter/material.dart';
// import 'package:frontend/UpdateProfileScreen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class TagMenuWidget extends StatelessWidget {
  const TagMenuWidget({
    Key? key,
    required this.icon,
    required this.onPress,
    required this.onPress1,
    required this.img,
    this.textColor,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPress;
  final VoidCallback onPress1;
  final String img;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark
        ? const Color.fromARGB(9, 206, 15, 177)
        : const Color.fromARGB(219, 206, 15, 95);

    return Column(children: [
      SizedBox(
        width: 60,
        height: 60,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(image: AssetImage(img))),
      ),
      ListTile(
        //contentPadding: const EdgeInsets.all(45),

        onTap: onPress,
        title: Center(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: iconColor.withOpacity(0.1),
            ),
            child: Icon(icon, color: iconColor),
          ),
        ),
      ),
      //const SizedBox(width: 10),
      ListTile(
        //contentPadding: const EdgeInsets.all(45),

        onTap: onPress1,
        title: Center(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: iconColor.withOpacity(0.1),
            ),
            child: Icon(LineAwesomeIcons.minus, color: iconColor),
          ),
        ),
      )
    ]);
  }
}
