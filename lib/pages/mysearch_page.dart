
import 'package:flutter/material.dart';
import 'package:instagramclone/models/member_model.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {

  TextEditingController searchController = TextEditingController();
  List<Member> items = [
    Member("fullName", "emaiil"),
    Member("fullName", "emaiil"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Search", style: TextStyle(fontFamily: "billabong", color: Colors.black, fontSize: 28),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // #Search
            Container(
              height: 45,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                style: TextStyle(color: Colors.black87),
                controller: searchController,
                onChanged: (text) {
                  print(text);
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey,),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _itemOfMember(items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemOfMember(Member member) {
    return Container(
      height: 90,
      child: Row(
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
              borderRadius: BorderRadius.circular(22.5),
              child: Image(
                image: AssetImage("assets/images/ic_userImage.png"),
                height: 45,
                width: 45,
              ),
            ),
          ),
          SizedBox(width: 15,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(member.fullName, style: TextStyle(fontWeight: FontWeight.bold),),
              Text(member.email, style: TextStyle(color: Colors.black54),),
            ],
          ),
          Expanded(
            child: member.followed ?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: OutlinedButton(
                    onPressed: (){
                      setState(() {
                        member.followed = false;
                      });
                    },
                    child: Text("Followed"),
                  ),
                ),
              ],
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: MaterialButton(
                    onPressed: (){
                      setState(() {
                        member.followed = true;
                      });
                    },
                    child: Text("Follow", style: TextStyle(color: Colors.white)),
                    color: Colors.blue,
                  ),
                ),
              ],
            ) ,
          ),
        ],
      ),
    );
  }

}
