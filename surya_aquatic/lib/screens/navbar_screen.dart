import 'package:flutter/material.dart';
import 'package:surya_aquatic/screens/favortite.dart';
import 'package:surya_aquatic/screens/home.dart';
import 'package:surya_aquatic/screens/profile.dart';
import 'package:surya_aquatic/screens/search.dart';

class navbar_screen extends StatefulWidget {
  const navbar_screen({super.key});

  @override
  State<navbar_screen> createState() => _navbar_screenState();
}

class _navbar_screenState extends State<navbar_screen> {

  int _selectedIndex = 0;

  static const List<Widget> _screenOptions = <Widget>[
    home(),
    search(),
    favorite(),
    profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: 
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue, // Warna bayangan
                spreadRadius: 1, // Seberapa jauh bayangan menyebar
                blurRadius: 5, // Seberapa halus bayangan
                offset: Offset(0, -2), // Bayangan hanya muncul di atas (y negatif)
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              //pertama
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              //kedua
              BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
              //ketiga
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorite"),
              //keempat
              BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.blue.shade100,
          ),
        ),
    );
  }
}