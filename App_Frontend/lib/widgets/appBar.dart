import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF64A3A3),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, color: Colors.white, size: 30),
          SizedBox(width: 10),
          Icon(Icons.scatter_plot, color: Colors.white, size: 24),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
