class Review {
  String companyId;

  String userId;

  String userName;

  String title;

  String description;

  String dateTime;

  String comments;

  double rating;

  int enable;

  Review(
      {this.companyId,
      this.userId,
      this.title,
      this.description,
      this.comments,
      this.dateTime,
      this.rating,
      this.userName,
      this.enable});

  Review.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    dateTime = json['dateTime'];
    comments = json['comments'];
    enable = json['enable'];
    rating = json['rating'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() => {
        'companyId': companyId,
        'userId': userId,
        'rating': rating,
        'title': title,
        'description': description,
        'comments': comments,
        'enable': enable,
        'dateTime': dateTime,
        'userName': userName
      };
}
