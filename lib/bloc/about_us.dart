class AboutUs {
  String description;

  List team;

  String last;

  AboutUs({this.description, this.last, this.team});

  AboutUs.fromJson(Map<String, dynamic> json) {
    description = json['description'] as String;
    team = json['team'] as List;
    last = json['last'] as String;
  }

  Map<String, dynamic> toJson() =>
      {'description': description, 'team': team, 'last': last};
}

class Team {
  String name;

  String location;

  String image;

  String ocupation;

  String role;

  Team({this.image, this.name, this.location, this.ocupation, this.role});

  Team.fromJson(Map<String, dynamic> json) {
    image = json['image'] as String;
    name = json['name'] as String;
    location = json['location'] as String;
    role = json['role'] as String;
    ocupation = json['ocupation'] as String;
  }
}
