import 'package:flutter/material.dart';
import '../utils/Colors.dart';
import 'CameraPage.dart';
import 'LoginPage.dart';
import 'DetailPage.dart';
import 'MlTestPage.dart';
import 'SearchScreen.dart';
import 'OnBoardingPage.dart';
// import 'FavoritePage.dart';
import '../components/navbar.dart'; //coba navbar

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  final List<Map<String, String>> movies = [
    {
      'title': 'Spider Man',
      'duration': '1h 35m',
      'rating': '8.1',
      'image': 'assets/images/spiderman.jpg'
    },
    {
      'title': 'Spider Man 2',
      'duration': '1h 35m',
      'rating': '8.1',
      'image': 'assets/images/spiderman.jpg'
    },
  ];

  void _onBackToIntro(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnBoardingPage()),
    );
  }

  Widget _buildCategoryButton(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? CustomColor.primary : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isSelected ? Colors.transparent : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildMovieCard(Map<String, String> movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 2 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              movie['image']!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                movie['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow[800], size: 16),
                const SizedBox(width: 4),
                Text(movie['rating']!),
              ],
            ),
          ],
        ),
        Text(
          movie['duration']!,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'FamScreen',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Filter
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildCategoryButton('All', true),
                  _buildCategoryButton('Movies', false),
                  _buildCategoryButton('Series', false),
                ],
              ),
              const SizedBox(height: 16),

              // Recommendations Section
              const Text(
                'Rekomendasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // grid film
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return _buildMovieCard(movies[index]);
                },
              ),

              const SizedBox(height: 70),

              // Button and Navigation Section
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("This is the screen after Introduction"),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const MlTestPage()),
                        );
                      },
                      child: const Text('Open ML Test Page'),
                    ),
                    ElevatedButton(
                      onPressed: () => _onBackToIntro(context),
                      child: const Text('Back to Introduction'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const CameraPage()),
                        );
                      },
                      child: const Text('Open Camera'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: const Text('Open Login Page'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const DetailPage()),
                        );
                      },
                      child: const Text('Open Detail Page'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SearchScreen()),
                        );
                      },
                      child: const Text('Open Search Page'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).push(
                        // MaterialPageRoute(builder: (_) => FavoritePage()),
                        // );
                      },
                      child: const Text('Open Favorite Page'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // navbar
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
