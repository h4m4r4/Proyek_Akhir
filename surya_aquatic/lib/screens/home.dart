import 'package:flutter/material.dart';
import 'package:surya_aquatic/data/data_cupang.dart';
import 'package:surya_aquatic/models/cupang.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children:[
                Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      'images/main2.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue, // Warna bayangan
                      spreadRadius: 1, // Seberapa jauh bayangan menyebar
                      blurRadius: 5, // Seberapa halus bayangan
                    ),
                  ],
                ),
                width: double.infinity,
                height: 400,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text('Surya Aquatic',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),
                  ),
                )
              ] 
            ),

            SizedBox(
              height: 40,
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text('Produk',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),),
                )
              ],
            ),

            SizedBox(
              height: 8,
            ),

            Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                  padding: const EdgeInsets.all(8),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    Cupang cupang = daftarcupang[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.all(6),
                      elevation: 0,
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Text(
                              cupang.nama,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),

            Container(
              height: 40,
              color: Colors.white,
            )

          ],
        ),
      ),
    );
  }
}
