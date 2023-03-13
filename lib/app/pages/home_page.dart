import 'package:flutter/material.dart';

import './ar_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(),
      home: const MenuBar(),
    );
  }
}

class MenuBar extends StatelessWidget {
  const MenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("menu")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 75,
              ),
              FloatingActionButton.extended(
                  heroTag: "AR Start btn",
                  onPressed: () {
                    Navigator.of(context).push<void>(MaterialPageRoute(
                      builder: (context) => const ARPage(title: "AR Page"),
                    ));
                  },
                  label: const Text("AR Start"),
                  backgroundColor: Colors.transparent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 75,
              ),
              FloatingActionButton.extended(
                  heroTag: "Settings btn",
                  onPressed: () {},
                  label: const Text("Settings"),
                  backgroundColor: Colors.transparent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 75,
              ),
              FloatingActionButton.extended(
                  heroTag: "info btn",
                  onPressed: () {},
                  label: const Text("   Info   "),
                  backgroundColor: Colors.transparent),
            ],
          ),
        ],
      )),
    );
  }
}
