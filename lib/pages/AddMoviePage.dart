import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMoviePage extends StatefulWidget {
  @override
  _AddMoviePageState createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controller untuk setiap input field
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _tahunRilisController = TextEditingController();
  final TextEditingController _durasiController = TextEditingController();
  final TextEditingController _rateImdbController = TextEditingController();
  final TextEditingController _linkStreamingController =
      TextEditingController();
  final TextEditingController _posterPotraitController =
      TextEditingController();
  final TextEditingController _posterLandscapeController =
      TextEditingController();

  // Variabel untuk pilihan kategori usia
  String? _kategoriUsia = 'SU'; // Set default value as 'SU'

  // Fungsi untuk menambahkan film ke Firestore
  Future<void> _addMovie() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Ambil data dari controller
      Map<String, dynamic> movieData = {
        'judul': _judulController.text,
        'genre':
            _genreController.text.split(','), // Misalnya genre dipisah koma
        'deskripsi': _deskripsiController.text,
        'tahun_rilis': int.tryParse(_tahunRilisController.text),
        'durasi': int.tryParse(_durasiController.text),
        'rate_imdb': double.tryParse(_rateImdbController.text),
        'kategori_usia': _kategoriUsia,
        'link_streaming': _linkStreamingController.text,
        'poster_potrait': _posterPotraitController.text,
        'poster_landscap': _posterLandscapeController.text,
      };

      // Simpan ke Firestore
      await _firestore.collection('movies').add(movieData);

      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Movie Added!')));

      // Bersihkan input setelah menambahkan data
      _judulController.clear();
      _genreController.clear();
      _deskripsiController.clear();
      _tahunRilisController.clear();
      _durasiController.clear();
      _rateImdbController.clear();
      _linkStreamingController.clear();
      _posterPotraitController.clear();
      _posterLandscapeController.clear();
      setState(() {
        _kategoriUsia = 'SU'; // Reset to default value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Movie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Input untuk Judul Film
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(labelText: 'Judul'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the movie title';
                  }
                  return null;
                },
              ),

              // Input untuk Genre
              TextFormField(
                controller: _genreController,
                decoration:
                    InputDecoration(labelText: 'Genre (comma separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the genre';
                  }
                  return null;
                },
              ),

              // Input untuk Deskripsi
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),

              // Input untuk Tahun Rilis
              TextFormField(
                controller: _tahunRilisController,
                decoration: InputDecoration(labelText: 'Tahun Rilis'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the release year';
                  }
                  return null;
                },
              ),

              // Input untuk Durasi
              TextFormField(
                controller: _durasiController,
                decoration: InputDecoration(labelText: 'Durasi (menit)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the duration';
                  }
                  return null;
                },
              ),

              // Input untuk Rating IMDB
              TextFormField(
                controller: _rateImdbController,
                decoration: InputDecoration(labelText: 'Rating IMDB'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the IMDb rating';
                  }
                  return null;
                },
              ),

              // Dropdown untuk Kategori Usia
              DropdownButtonFormField<String>(
                value: _kategoriUsia,
                decoration: InputDecoration(labelText: 'Kategori Usia'),
                items: ['SU', '17+', '13+', '21+'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _kategoriUsia = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an age category';
                  }
                  return null;
                },
              ),

              // Input untuk Link Streaming
              TextFormField(
                controller: _linkStreamingController,
                decoration: InputDecoration(labelText: 'Link Streaming'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the streaming link';
                  }
                  return null;
                },
              ),

              // Input untuk Poster Potrait
              TextFormField(
                controller: _posterPotraitController,
                decoration: InputDecoration(labelText: 'Poster Potrait URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the portrait poster URL';
                  }
                  return null;
                },
              ),

              // Input untuk Poster Landscape
              TextFormField(
                controller: _posterLandscapeController,
                decoration: InputDecoration(labelText: 'Poster Landscape URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the landscape poster URL';
                  }
                  return null;
                },
              ),

              // Tombol Simpan
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _addMovie,
                  child: Text('Add Movie'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
