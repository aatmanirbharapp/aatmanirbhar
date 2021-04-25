class AboutUs {
  String description;

  String descriptionhi;

  List team;

  String last;
  String lasthi;

  AboutUs({this.description, this.last, this.team,this.descriptionhi,this.lasthi});

  AboutUs.fromJson(Map<String, dynamic> json) {
    description = json['description'] as String;
    team = json['team'] as List;
    last = json['last'] as String;
    lasthi = json['lasthi'] as String;
    descriptionhi = json['descriptionhi'] as String;
  }

  Map<String, dynamic> toJson() =>
      {'description': description, 'team': team, 'last': last,'descriptionhi' : descriptionhi,'lasthi' : lasthi};
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
