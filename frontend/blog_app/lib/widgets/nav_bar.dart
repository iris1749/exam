import 'package:flutter/material.dart';

class DesktopNavBar extends StatelessWidget {
  final String temperature;

  const DesktopNavBar({Key? key, required this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Logo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Row(
            children: [
              NavBarItem(title: 'Home'),
              NavBarItem(title: 'Posts'),
              NavBarItem(title: 'About'),
              SizedBox(width: 20),
              Text('Temperature: $temperature', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

class MobileNavBar extends StatelessWidget {
  final String temperature;

  const MobileNavBar({Key? key, required this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text('Logo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          NavBarItem(title: 'Home'),
          NavBarItem(title: 'Posts'),
          NavBarItem(title: 'About'),
          SizedBox(height: 20),
          Text('Temperature: $temperature', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String title;

  const NavBarItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(title, style: TextStyle(fontSize: 16)),
    );
  }
}