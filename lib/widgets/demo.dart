import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('comments').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Loading indicator
        }

        final comments = snapshot.data!.docs;
        List<Widget> commentWidgets = [];

        for (var comment in comments) {
          Timestamp timestamp = comment['datePublished'] ?? Timestamp.now();
          DateTime commentTime = timestamp.toDate();
          String formattedTime = formatCommentTime(commentTime);

          // Create a widget to display the comment and its formatted time
          commentWidgets.add(
            ListTile(
              title: Text(comment['text']),
              subtitle: Text(formattedTime),
            ),
          );
        }

        return ListView(
          children: commentWidgets,
        );
      },
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
}





// import 'dart:async';

// import 'package:flutter/material.dart';

// class RealTimeCommentTimer extends StatefulWidget {
//   final DateTime commentDateTime;

//   RealTimeCommentTimer({required this.commentDateTime});

//   @override
//   _RealTimeCommentTimerState createState() => _RealTimeCommentTimerState();
// }

// class _RealTimeCommentTimerState extends State<RealTimeCommentTimer> {
//   late Timer _timer;
//   Duration _elapsedTime = Duration(seconds: 0);

//   @override
//   void initState() {
//     super.initState();

//     // Calculate the initial elapsed time
//     final now = DateTime.now();
//     _elapsedTime = now.difference(widget.commentDateTime);

//     // Create a timer that updates every minute
//     _timer = Timer.periodic(Duration(minutes: 1), (timer) {
//       setState(() {
//         _elapsedTime = _elapsedTime + Duration(minutes: 1);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     // Dispose of the timer to prevent memory leaks
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Format the elapsed time
//     String formattedTime = _formatTime(_elapsedTime);

//     return Text(
//       formattedTime,
//       style: TextStyle(
//         color: Colors.grey, // Instagram-like timestamp color
//         fontSize: 12.0, // Instagram-like timestamp font size
//       ),
//     );
//   }

//   String _formatTime(Duration time) {
//     if (time.inSeconds < 60) {
//       return '${time.inSeconds}s';
//     } else if (time.inMinutes < 60) {
//       return '${time.inMinutes}m';
//     } else if (time.inHours < 24) {
//       return '${time.inHours}h';
//     } else {
//       return '${time.inDays}d';
//     }
//   }
// }
