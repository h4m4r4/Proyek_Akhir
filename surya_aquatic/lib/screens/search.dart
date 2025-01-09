import 'package:flutter/material.dart';
import 'package:surya_aquatic/data/data_cupang.dart';
import 'package:surya_aquatic/models/cupang.dart';
import 'package:surya_aquatic/screens/detail.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  String query = '';
  List<Cupang> searchResults = [];

  void searchCupang(String keyword) {
    setState(() {
      query = keyword;
      searchResults = daftarcupang
          .where((cupang) =>
              cupang.nama.toLowerCase().contains(query.toLowerCase()) ||
              cupang.jenis.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade50],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            child: Center(
              child: TextField(
                onChanged: searchCupang,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue.shade50],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: query.isEmpty
                  ? Center(
                      child: Text(
                        "Ketik untuk mencari",
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                    )
                  : searchResults.isEmpty
                      ? Center(
                          child: Text(
                            "Tidak ada hasil ditemukan",
                            style:
                                TextStyle(fontSize: 18, color: Colors.grey[700]),
                          ),
                        )
                      : ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            final cupang = searchResults[index];
                            return InkWell(
                              onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => detail(cupang: cupang))
                          );
                        },
                              child: Card(
                                color: Colors.lightBlue[50],
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        cupang.gambar, // Pastikan atribut gambar ada di data
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cupang.nama,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              cupang.jenis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[700]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}