// comment_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:famscreen/services/auth_service.dart';

class CommentBottomSheet {
  static void show(BuildContext context, {
    required Function(String) onCommentSubmit,
    FocusNode? focusNode, // Accept the focusNode parameter
  }) {
    final TextEditingController _bottomSheetController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        // Setelah widget dibangun, kita minta fokus pada TextField
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (focusNode != null) {
            focusNode.requestFocus(); // Memfokuskan pada TextField
          }
        });

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _bottomSheetController,
                      focusNode: focusNode, // Assign the focusNode here
                      decoration: InputDecoration(
                        hintText: "Tambahkan komentar...",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
                        filled: true,
                        fillColor: Colors.grey[300],
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
                  IconButton(
                    icon: Icon(
                      Icons.send, // Ikon kirim
                      color: CustomColor.primary,
                    ),
                    onPressed: () async {
                      final newComment = _bottomSheetController.text.trim();
                      if (newComment.isNotEmpty) {
                        onCommentSubmit(newComment);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
