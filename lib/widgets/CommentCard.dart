import 'package:famscreen/services/auth_service.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:flutter/material.dart';

class CommentService {
  Future<List<Map<String, dynamic>>> fetchCommentsForMovie(String movieId) async {
    // Simulate fetching comments from an API or database.
    await Future.delayed(const Duration(seconds: 2)); // simulate network delay
    return [
      {
        "user": "John",
        "comment": "Nice",
        "userAvatar": "https://media.suara.com/pictures/970x544/2018/10/19/48248-anjing-diomeli.jpg"
      },
      {
        "user": "Peter",
        "comment": "Good",
        "userAvatar": "https://media.istockphoto.com/id/1194711054/id/foto/anak-anjing-lucu-melawan-ras-campuran-biru.jpg?s=612x612&w=0&k=20&c=_oYLHLG2JOwAdoOlw1azEZCmG06KL_V0BsNlIq2gwRk="
      },
    ];
  }
}

class CommentCard extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> commentsFuture;

  const CommentCard({Key? key, required this.commentsFuture}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> _comments = []; // Local comments list

  @override
  void initState() {
    super.initState();
    // Load initial comments from future
    widget.commentsFuture.then((comments) {
      setState(() {
        _comments = comments;
      });
    });
  }

  void _addComment() async {
  final newComment = _commentController.text.trim();
  if (newComment.isNotEmpty) {
    // Mendapatkan nama pengguna yang sedang login
    final userName = await AuthService().getName();

    setState(() {
      _comments.insert(0, {
        "user": userName ?? "Current User",
        "comment": newComment,
        "userAvatar": null, 
      });
      _commentController.clear();
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "${_comments.length} Komentar",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: "Tambahkan komentar...",
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14 ,color: Colors.black45),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _addComment,
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColor.primary,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12), 
                  child: Transform.rotate(
                    angle: -0.7, 
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Display comments list
        _comments.isEmpty
            ? const Center(child: Text("Belum ada komentar."))
            : Column(
                children: _comments.map((comment) {
                  return ListTile(
                    leading: comment['userAvatar'] != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(comment['userAvatar']),
                          )
                        : const Icon(Icons.account_circle, size: 40), // Default icon
                    title: Text(
                      comment['user'] ?? "Anonim",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(comment['comment'] ?? ""),
                  );
                }).toList(),
              ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}