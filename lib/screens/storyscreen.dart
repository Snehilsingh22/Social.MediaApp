import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final storycontroller = StoryController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoryView(
        storyItems: [
          StoryItem.text(
              title: 'Hello', backgroundColor: Colors.green.shade300),
          StoryItem.pageImage(
              url:
                  'https://images.pexels.com/photos/775201/pexels-photo-775201.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              controller: storycontroller)
        ],
        controller: storycontroller,
        inline: false,
        repeat: false,
      ),
    );
  }
}
