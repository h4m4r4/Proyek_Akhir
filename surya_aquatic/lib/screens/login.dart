import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surya_aquatic/data/data_user.dart';
import 'package:surya_aquatic/models/user.dart';
import 'package:surya_aquatic/screens/navbar_screen.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:[Colors.blue , Colors.blue.shade100],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('dont have an account?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade100
                      ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text("Get Started"),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 125),
                    child: Text(
                      'Login to Surya Aquatic',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 250),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        spreadRadius: 3,
                        blurRadius: 5,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: 450,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              'Welcome Back to',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              'Surya Aquatic',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'enter your details here',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: _username,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: _password,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String username = _username.text;
                                String pasword = _password.text;
                        
                                if (validatedlogg(username, pasword)) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool('islogged', true);
                                  await prefs.setString('username', username);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => navbar_screen()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text('invalid email or password')
                                      ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade300, 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: const Size.fromHeight(48), 
                                elevation: 0,
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,),
                              ),
                            ),
                            const SizedBox(height: 16,),
                            Text('forgot your password?',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade400,
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validatedlogg(String username, String password) {
    for (User user in userlist) {
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }
}
