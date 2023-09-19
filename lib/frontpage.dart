import 'package:flutter/material.dart';
import 'menu_drawer.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(249, 249, 1, 0.976),
      appBar: AppBar(
        // title: const CurrentLocation(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  return Scaffold.of(context).openEndDrawer();
                },
                icon: Image.asset(
                  'assets/icons/icon_menu.ico',
                  scale: 0.8,
                ),
              );
            }),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLargeScreen = constraints.maxWidth > 600;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 30.0 : 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      endDrawer: const ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
        child: MenuDrawer(),
      ),
    );
  }
}
