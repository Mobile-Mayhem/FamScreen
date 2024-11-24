import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<HistoryItem> historyItems = [
    HistoryItem(
      title: 'Venom 3 (Venom: The Last Dance)',
      image: 'assets/images/venom.jpeg',
      description:
          '"Venom 3" adalah film superhero Amerika tentang Venom, sekuel dari "Venom" dan "Venom: Let There Be Carnage," diproduksi oleh Columbia Pictures dan Marvel...',
    ),
    HistoryItem(
      title: 'Do You See What I See',
      image: 'assets/images/venom.jpeg',
      description:
          'Do You See What I See adalah film hantu Indonesia tahun 2024 yang disutradarai oleh Awi Suryadi berdasarkan siniar Do You See What I See Episode #64.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Riwayat',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Cari riwayat',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                FilterChip(label: Text('All'), onSelected: (_) {}),
                SizedBox(width: 8),
                FilterChip(label: Text('Movies'), onSelected: (_) {}),
                SizedBox(width: 8),
                FilterChip(label: Text('Series'), onSelected: (_) {}),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Fungsi untuk tombol lainnya
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: historyItems.length,
                itemBuilder: (context, index) {
                  final item = historyItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15), // Set the border radius to 15
                            child: Image.asset(
                              item.image,
                              width: 70,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Text(
                                      "2015  ·  1h 35m  ·  ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow, // Yellow star icon
                                      size: 16,
                                    ),
                                    const Text(
                                      " 8.1",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.description,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class HistoryItem {
  final String title;
  final String image;
  final String description;

  HistoryItem(
      {required this.title, required this.image, required this.description});
}

class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {},
      child: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
