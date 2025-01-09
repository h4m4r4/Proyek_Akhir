import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surya_aquatic/data/data_cupang.dart';
import 'package:surya_aquatic/models/cupang.dart';
import 'package:surya_aquatic/screens/detail.dart';

class favorite extends StatefulWidget {
  const favorite({super.key});

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  List<Cupang> _favoriteCupangs = [];

  Future<void> _LoadFavoriteCupangs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteCupangNames =
        prefs.getStringList('favoriteCupangs') ?? [];
    setState(() {
      _favoriteCupangs = daftarcupang
          .where((cupang) => favoriteCupangNames.contains(cupang.nama))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _LoadFavoriteCupangs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Favorite'),centerTitle: true,),
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white.withOpacity(0.9), Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView( 
                    child: Column(
                    children: [
                      Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:[Colors.blue.shade300 , Colors.blue.shade100],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight
                    ),
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(12),
                    //   bottomRight: Radius.circular(12)
                    // )
                  ),
                  height: 60,
                  child: Center(
                    child: Text('Favorite',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisSpacing: 10),
                        padding: const EdgeInsets.all(8),
                        itemCount: _favoriteCupangs.length,
                        itemBuilder: (context, index) {
                          Cupang cupang = _favoriteCupangs[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => detail(cupang: cupang)));
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                margin: const EdgeInsets.all(6),
                                elevation: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                        child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        cupang.gambar,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16, top: 8),
                                      child: Text(
                                        cupang.nama,
                                        style: const TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        },
                      )
                    ],
                  ),
          )),
      ),
    );
  }
}
