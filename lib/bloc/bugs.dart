class Bug {
  String id;

  String name;

  String emailId;

  String title;

  String description;

  String screenshot;

  String timeAdded;

  Bug(
      {this.title,
      this.description,
      this.emailId,
      this.id,
      this.name,
      this.screenshot,
      this.timeAdded});

  Bug.fromJson(Map<String, dynamic> json) {
    emailId = json['emailId'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    screenshot = json['screenshot'];
    id = json['id'];
    timeAdded = json['timeAdded'];
  }

  Map<String, dynamic> toJson() => {
        'timeAdded': timeAdded,
        'name': name,
        'title': title,
        'description': description,
        'id': id,
        'screenshot': screenshot,
        'emailId': emailId
      };
}
