import 'dart:async';
import 'package:flutter/material.dart';
import 'package:famscreen/services/auth_service.dart';
import 'package:famscreen/widgets/CommentBottomSheet.dart';

class CommentService {
  Future<List<Map<String, dynamic>>> fetchCommentsForMovie(
      String movieId) async {
    // Simulate fetching comments from an API or database.
    await Future.delayed(const Duration(seconds: 2)); // simulate network delay
    return [
      {
        "user": "John",
        "comment": "Nice",
        "userAvatar":
            "https://media.suara.com/pictures/970x544/2018/10/19/48248-anjing-diomeli.jpg",
        "timestamp": DateTime.now().subtract(Duration(hours: 1)),
      },
      {
        "user": "Peter",
        "comment": "Good",
        "userAvatar":
            "https://media.istockphoto.com/id/1194711054/id/foto/anak-anjing-lucu-melawan-ras-campuran-biru.jpg?s=612x612&w=0&k=20&c=_oYLHLG2JOwAdoOlw1azEZCmG06KL_V0BsNlIq2gwRk=",
        "timestamp": DateTime.now().subtract(Duration(minutes: 30)),
      },
    ];
  }
}

String formatTime(dynamic timestamp) {
  if (timestamp == null || timestamp is! DateTime) {
    return "Baru saja"; // Tampilkan default jika timestamp null
  }

  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inMinutes < 1) {
    return "Baru saja";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes}m"; // Menit
  } else if (difference.inHours < 24) {
    return "${difference.inHours}h"; // Jam
  } else {
    return "${difference.inDays}d"; // Hari
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
  final FocusNode _focusNode = FocusNode(); // Declare FocusNode
  List<Map<String, dynamic>> _comments = []; // Local comments list
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Load initial comments from future
    widget.commentsFuture.then((comments) {
      setState(() {
        _comments = comments;
      });
    });

    // Set up a timer to update the state every second for realtime time updates
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void _addComment(String newComment) async {
    if (newComment.isNotEmpty) {
      // Mendapatkan nama pengguna yang sedang login
      final userName = await AuthService().getName();

      setState(() {
        _comments.insert(0, {
          "user": userName ?? "Anonim",
          "comment": newComment,
          "userAvatar": null,
          "timestamp": DateTime.now(),
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
                child: GestureDetector(
                  onTap: () {
                    CommentBottomSheet.show(
                      context,
                      focusNode: _focusNode, // Pass the FocusNode
                      onCommentSubmit: (newComment) {
                        _addComment(
                            newComment); // Use the method to handle comment submission
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Tambahkan komentar...",
                      style: TextStyle(fontSize: 14, color: Colors.black45),
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
                            backgroundImage:
                                NetworkImage(comment['userAvatar']!),
                          )
                        : const Icon(Icons.account_circle,
                            size: 40), // Default icon
                    title: Row(
                      children: [
                        Text(
                          comment['user'] ?? "Anonim",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                            width: 8), // Jarak kecil antara nama dan waktu
                        Text(
                          formatTime(comment['timestamp'] ??
                              DateTime.now()), // Waktu dinamis
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
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
    _focusNode.dispose(); // Dispose the FocusNode
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }
}
