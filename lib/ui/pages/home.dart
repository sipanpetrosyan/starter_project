import 'package:flutter/material.dart';
import 'package:igroove_ui/ui/pages/account.dart';
import 'package:igroove_ui/ui/pages/my_trends.dart';
import 'package:igroove_ui/ui/pages/products.dart';
import 'package:igroove_ui/ui/pages/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar(),
        body: bodyContent(),
      ),
    );
  }

  Widget bodyContent() {
    switch (selectedTab) {
      case 0:
        return MyTrends();
        break;
      case 1:
        return AccountPage();
        break;
      case 2:
        return ProductsPage();
        break;
      case 3:
        return ProfilePage();
        break;
    }
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color.fromARGB(255, 242, 113, 58),
      unselectedItemColor: Color.fromARGB(255, 99, 99, 105),
      showUnselectedLabels: true,
      unselectedFontSize: 13,
      selectedFontSize: 13,
      elevation: 0,
      currentIndex: selectedTab,
      onTap: (index) {
        setState(() {
          selectedTab = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          title: Text(
            'Trends',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.equalizer),
        ),
        BottomNavigationBarItem(
          title: Text(
            'Account',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.account_balance_wallet),
        ),
        BottomNavigationBarItem(
          title: Text(
            'Products',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.music_video),
        ),
        BottomNavigationBarItem(
          title: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
