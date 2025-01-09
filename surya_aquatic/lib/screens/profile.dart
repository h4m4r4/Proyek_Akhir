import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surya_aquatic/data/data_user.dart';
import 'package:surya_aquatic/models/user.dart';
import 'package:surya_aquatic/screens/login.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String username = '';
  String name = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');

    if (savedUsername != null) {
      // Cari data user berdasarkan username
      User matchedUser = userlist.firstWhere(
        (user) => user.username == savedUsername,
        orElse: () => User(username: '', password: '', name: 'Tidak Diketahui'),
      );

      setState(() {
        username = matchedUser.username;
        name = matchedUser.name;
        password = matchedUser.password;
      });
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('islogged');
    await prefs.remove('username');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => loginpage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue.shade100],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight),
                ),
                height: 250,
              ),
              Padding(
                padding: EdgeInsets.only(top: 200),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _logout(context);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text("Logout"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 310),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 100),
                            child: Column(
                              children: [
                                Text(name.isNotEmpty ? name : 'Nama Tidak Diketahui',),
                                Divider(
                                  color: Colors.blue.shade100,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: username.isNotEmpty ? username : 'Username Tidak Diketahui',
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: password.isNotEmpty ? password : 'Password Tidak Diketahui',
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
