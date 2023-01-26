
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/models/post_model.dart';
import 'package:instagramclone/pages/signin_page.dart';
import 'package:instagramclone/services/auth_service.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  List<Post> items = [
    Post(caption: "Post caption", imgPost: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost.png?alt=media&token=f0b1ba56-4bf4-4df2-9f43-6b8665cdc964"),
    Post(caption: "Post caption", imgPost: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost2.png?alt=media&token=ac0c131a-4e9e-40c0-a75a-88e586b28b72"),
  ];

  void doSignOut() {
    AuthService.signOutUser().then((value) => {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage())),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text("Profile", style: TextStyle(color: Colors.black, fontFamily: "billabong", fontSize: 28)),
        actions: [
          IconButton(
            onPressed: doSignOut,
            icon: Icon(Icons.output),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(
                      width: 1.5,
                      color: Color.fromRGBO(193, 53, 132, 1),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image(
                      height: 70,
                      width: 70,
                      image: AssetImage("assets/images/ic_userImage.png"),
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.add_circle, color: Colors.purple),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text("User Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Text("username@gmail.com", style: TextStyle(color: Colors.black54),),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("675", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Text("POSTS", style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  ),
                  VerticalDivider(indent: 20, endIndent: 20, color: Colors.grey),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("6275", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Text("FOLLOWERS", style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  ),
                  VerticalDivider(indent: 20, endIndent: 20, color: Colors.grey),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("1675", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Text("FOLLOWING", style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _itemOfPost(items[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemOfPost(Post post) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              width: double.infinity,
              imageUrl: post.imgPost!,
              placeholder: (context, url) {
                return Center(child: CircularProgressIndicator(),);
              },
              errorWidget: (context, url, error) {
                return Icon(Icons.error);
              },
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 3,),
          Text(post.caption!)
        ],
      ),
    );
  }

}
