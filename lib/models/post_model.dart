
class Post {

  String? uid;
  String? id;
  String? imgPost;
  String? caption;
  String? date;
  String? likes;

  Post({
    this.imgPost,
    this.caption,
  });

  Post.fromJson(Map<String, dynamic> json) {
        uid = json["uid"];
        id = json["id"];
        imgPost = json["imgPost"];
        caption = json["caption"];
        date = json["date"];
        likes = json["likes"];
      }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "id": id,
    "imgPost": imgPost,
    "caption": caption,
    "date": date,
    "likes": likes,
  };
}
