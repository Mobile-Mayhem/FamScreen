import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/venom.jpeg',
            //height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 210),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  actions: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border, color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Container(
            margin: const EdgeInsets.only(top: 230, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('2024', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4), 
                      color: const Color (0xffF5C518),
                      ),
                      child: const Text('IMDb', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    const Text('8.0  |', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    const Text('1h 50m', style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Venom 3 (Venom: The Last Dance)',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                const Text(
                  '"Venom 3" adalah film superhero Amerika tentang Venom, sekuel dari "Venom" dan "Venom: Let There Be Carnage," diproduksi oleh Columbia Pictures dan Marvel, didistribusikan oleh Sony Pictures.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), 
                        color: const Color.fromARGB(255, 228, 227, 227),
                      ),
                      child: const Text('Animasi', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), 
                        color: const Color.fromARGB(255, 228, 227, 227),
                      ),
                      child: const Text('Komedi', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), 
                        color: const Color.fromARGB(255, 228, 227, 227),
                      ),
                      child: const Text('Drama', style: TextStyle(fontSize: 14)),
                    )
                  ]
                ),
                const SizedBox(height: 30),
                const Text(
                  'Lihat Sekarang',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:  Image.asset(
                          'assets/images/netflix.png',
                          width: 50,
                          height: 50,
                        )
                      ) 
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Rekomendasi Lainnya',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
