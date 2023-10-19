import 'package:flutter/material.dart';
import 'package:frontend/ProfileMenuWidget.dart';
import 'package:frontend/TagMenuWidget.dart';
import 'package:frontend/UpdateProfileScreen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:frontend/categoryscreen.dart';
import 'user_model.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key});
  @override
  State<UserProfile> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    const String ok = "assets/images/u_prof.png";
    return Scaffold(
        //backgroundColor: Color.fromARGB(255, 240, 222, 169),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
          title: Text("Profile",
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            IconButton(
                onPressed: () {},
                icon:
                    Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(45),
                child: Column(children: [
                  /// -- IMAGE
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const Image(image: AssetImage(ok))),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromARGB(46, 6, 6, 122)),
                          child: const Icon(
                            LineAwesomeIcons.alternate_pencil,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("${userName}",
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text("${userEmail}",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 20),

                  /// -- BUTTON
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UpdateProfileScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(184, 100, 109, 232),
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text("Edit User Information",
                          style: TextStyle(
                              color: Color.fromARGB(238, 178, 225, 225))),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Settings",
                      icon: LineAwesomeIcons.cog,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "Update Tag",
                      icon: LineAwesomeIcons.bookmark,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryScreen(userEmail)),
                        );
                      }),
                  ProfileMenuWidget(
                      title: "User Management",
                      icon: LineAwesomeIcons.user_check,
                      onPress: () {}),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Information",
                      icon: LineAwesomeIcons.info,
                      onPress: () {}),
                ]))));
  }
}

void _showTagUpdate(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 173, 233, 171),
        title: Text('Tag List'),
        content: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          thickness: 10.0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TagMenuWidget(
                  icon: LineAwesomeIcons.plus,
                  onPress: () {},
                  onPress1: () {},
                  img: "assets/images/u_prof.png",
                ),
                const SizedBox(width: 45, height: 45),
                TagMenuWidget(
                  icon: LineAwesomeIcons.plus,
                  onPress: () {},
                  onPress1: () {},
                  img: "assets/images/u_prof.png",
                ),
                const SizedBox(width: 45, height: 45),
                TagMenuWidget(
                  icon: LineAwesomeIcons.plus,
                  onPress: () {},
                  onPress1: () {},
                  img: "assets/images/u_prof.png",
                ),
                const SizedBox(width: 45, height: 45),
                TagMenuWidget(
                  icon: LineAwesomeIcons.plus,
                  onPress: () {},
                  onPress1: () {},
                  img: "assets/images/u_prof.png",
                ),
                const SizedBox(width: 45, height: 45),
                TagMenuWidget(
                  icon: LineAwesomeIcons.plus,
                  onPress: () {},
                  onPress1: () {},
                  img: "assets/images/u_prof.png",
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the alert screen
            },
            child: Text('Update'),
          ),
        ],
      );
    },
  );
}
