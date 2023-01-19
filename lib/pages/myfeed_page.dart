
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:instagramclone/pages/myupload_page.dart';

import '../models/post_model.dart';

class MyFeedPage extends StatefulWidget {
  final PageController? pageController;
  const MyFeedPage({Key? key, this.pageController}) : super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {

  List<Post> items = [
    Post(caption: "Post caption", imgPost: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost.png?alt=media&token=f0b1ba56-4bf4-4df2-9f43-6b8665cdc964"),
    Post(caption: "Post caption", imgPost: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost2.png?alt=media&token=ac0c131a-4e9e-40c0-a75a-88e586b28b72"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text("Instagram", style: TextStyle(fontFamily: "billabong", color: Colors.black, fontSize: 28),),
        actions: [
          IconButton(
            onPressed: (){
              widget.pageController?.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            },
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _itemOfPost(items[index]);
        },
      ),
    );
  }

  Widget _itemOfPost(Post post) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Divider(),
          // #user info
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: (post.imgUser == null) ?
                      Image(
                        height: 40,
                        width: 40,
                        image: AssetImage("assets/images/ic_userImage.png"),
                      ) :
                      Image.network(
                        post.imgUser.toString(),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      )
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("User name", style: TextStyle(fontWeight: FontWeight.bold,),),
                        Text("February 2, 2020")
                      ],
                    )
                  ],
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),
          // #post image
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            imageUrl: post.imgPost.toString(),
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
          ),
          // #buttons
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(FontAwesome.heart, color: Colors.red,),
                SizedBox(width: 10,),
                Icon(FontAwesome.paper_plane),
              ],
            ),
          ),
          // #caption
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Text("Post caption"),
          ),
        ],
      ),
    );
  }

}





