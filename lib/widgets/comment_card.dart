import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              snap.data()['profilePic'],
            ),
            radius: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: snap.data()['name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: ' ${snap.data()['text']}',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      formatCommentTime(
                        snap.data()['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite_border,
              size: 16,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  String formatCommentTime(DateTime commentTime) {
    final now = DateTime.now();
    final timeDifference = now.difference(commentTime);

    if (timeDifference.inDays >= 365) {
      return DateFormat('MMM d, y').format(commentTime);
    } else if (timeDifference.inDays >= 7) {
      return DateFormat('MMM d').format(commentTime);
    } else if (timeDifference.inDays > 1) {
      return '${timeDifference.inDays} days ago';
    } else if (timeDifference.inDays == 1) {
      return '1 day ago';
    } else if (timeDifference.inHours >= 1) {
      return '${timeDifference.inHours} hours ago';
    } else if (timeDifference.inMinutes >= 1) {
      return '${timeDifference.inMinutes} min ago';
    } else {
      return 'Just now';
    }
  }

  // String _formatDateTime(DateTime dateTime) {
  //   final now = DateTime.now();
  //   final today = DateTime(now.year, now.month, now.day);
  //   final yesterday = today.subtract(Duration(days: 1));

  //   if (dateTime.isAfter(today)) {
  //     // If the comment was posted today, show just the time (e.g., "5h")
  //     final hoursAgo = now.difference(dateTime).inHours;
  //     return '$hoursAgo${hoursAgo == 1 ? 'h' : 'h'}';
  //   } else if (dateTime.isAfter(yesterday)) {
  //     // If the comment was posted yesterday, show "Yesterday"
  //     return 'Yesterday';
  //   } else {
  //     // Otherwise, show the full date (e.g., "Jul 30")
  //     return DateFormat('MMM d').format(dateTime);
  //   }
  // }
}
