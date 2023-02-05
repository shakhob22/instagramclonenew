
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:instagramclone/pages/myupload_page.dart';
import 'package:instagramclone/services/db_service.dart';

import '../models/post_model.dart';

class MyFeedPage extends StatefulWidget {
  final PageController? pageController;
  const MyFeedPage({Key? key, this.pageController}) : super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {

  List<Post> items = [];
  bool isLoading = false;

  void loadFeeds() async {
    setState(() {
      isLoading = true;
    });
    List<Post> posts = await DataService.loadPosts();
    setState(() {
      items = posts;
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadFeeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
        ),
        (isLoading) ?
        Scaffold(
          backgroundColor: Colors.grey.withOpacity(.3),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ) : SizedBox(),
      ],
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
                      child: (post.imgUser!.isEmpty) ?
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
                        Text(post.fullName!, style: TextStyle(fontWeight: FontWeight.bold,),),
                        Text(post.date!),
                      ],
                    )
                  ],
                ),
                (post.mine) ?
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_horiz),
                ) : SizedBox(),
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
                IconButton(
                  onPressed: (){
                    DataService.likePost(post, false);
                  },
                  icon: Icon(FontAwesome.heart, color: Colors.red,),
                ),
                SizedBox(width: 10,),
                Icon(FontAwesome.paper_plane),
              ],
            ),
          ),
          // #caption
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Text(post.caption!),
          ),
        ],
      ),
    );
  }

}





