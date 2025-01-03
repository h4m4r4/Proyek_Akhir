import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surya_aquatic/models/cupang.dart';
import 'package:surya_aquatic/screens/after_sale.dart';
import 'package:surya_aquatic/screens/home.dart';

class detail extends StatefulWidget {
  final Cupang cupang;

  const detail({super.key, required this.cupang});

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  bool _isFavorite = false;

  Future<void> _LoadFavoritStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteCupangs = prefs.getStringList('favoriteCupangs') ?? [];
    setState(() {
      _isFavorite = favoriteCupangs.contains(widget.cupang.nama);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _LoadFavoritStatus();
  }

  Future<void> _ToggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteCupangs = prefs.getStringList('favoriteCupangs') ?? [];
    setState(() {
      if (_isFavorite) {
        //unfavorite
        favoriteCupangs.remove(widget.cupang.nama);
        _isFavorite = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${widget.cupang.nama} removed from favorites')));
      } else {
        favoriteCupangs.add(widget.cupang.nama);
        _isFavorite = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${widget.cupang.nama} added to favorites')));
      }
    });

    await prefs.setStringList('favoriteCupangs', favoriteCupangs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.cupang.nama,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Stack(children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      image: DecorationImage(
                          image: AssetImage(widget.cupang.gambar),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.4)),
                          child: IconButton(
                            onPressed: _ToggleFavorite,
                            icon: Icon(
                              Icons.favorite),
                              color: _isFavorite ? Colors.red : null,
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.cupang.nama,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.blue.shade200,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.cupang.harga,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.blue.shade200,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.cupang.deskripsi,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AfterSale()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade300, Colors.blue.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_checkout,
                          size: 24,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Buy',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
