class ComplaintsModel {
  String subject, imgUrl, message, id;
  List listDiscussions;

  ComplaintsModel(
      {this.subject, this.imgUrl, this.message, this.listDiscussions, this.id});

  ComplaintsModel.fromJSON(Map<String, dynamic> jsn)
      : subject = jsn['subject'],
        imgUrl = jsn['img_url'],
        message = jsn['message'],
        id = jsn['_id'],
        listDiscussions = jsn['discussions'];

  Map<String, dynamic> toJson() => {
        'subject': subject,
        'img_url': imgUrl,
        'message': message,
        'id': id,
        'discussions': listDiscussions
      };
}

class DiscussionsModel {
  String user;
  String msg;
  DiscussionsModel(this.user, this.msg);
  DiscussionsModel.fromJSON(Map<String, dynamic> jsn)
      : user = jsn['user'],
        msg = jsn['message'];
}
