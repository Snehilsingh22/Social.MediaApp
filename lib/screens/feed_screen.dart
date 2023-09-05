import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_auth/widgets/post_card.dart';

import '../utils/colors.dart';
import '../utils/global_variable.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with AutomaticKeepAliveClientMixin<FeedScreen> {
  // Uint8List? _file;
  FirebaseAuth auth = FirebaseAuth.instance;
//  void fnc()async{
//     var uid = (await FirebaseAuth.instance.currentUser()).uid;
//  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    User? getCurrentUser() {
      User? user = FirebaseAuth.instance.currentUser;
      return user;
    }

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? blackColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: Colors.deepPurple,

                // Status bar brightness (optional)
                statusBarIconBrightness:
                    Brightness.light, // For Android (dark icons)
                statusBarBrightness: Brightness.light,
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.deepPurple,
              centerTitle: false,
              title: Text('Posts'),
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished', descending: true)
            // .where('uid', isNotEqualTo: )
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple,
                color: Colors.white,
              ),
            );
          }
          return WillPopScope(
            onWillPop: () async => false,
            child: RefreshIndicator(
              strokeWidth: 2,
              color: Colors.white,
              backgroundColor: Colors.deepPurple,
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                  () {
                    setState(() {});
                  },
                );
              },
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () => Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => StoryScreen())),
                  //         child: Container(
                  //           height: 90,
                  //           width: 90,
                  //           decoration: BoxDecoration(
                  //               image: DecorationImage(
                  //                   image: AssetImage('assets/Snehil.jpg'),
                  //                   fit: BoxFit.cover),
                  //               borderRadius: BorderRadius.circular(100)),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            child: Column(
                              children: [
                                PostCard(
                                  snap: snapshot.data!.docs[index].data(),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   // isExtended: true,
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.green,
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => AddPostScreen()));
      //   },
      // ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
