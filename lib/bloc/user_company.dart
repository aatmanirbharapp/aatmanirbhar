class UserData {
  String dataId;

  String name;

  String wikiPage;

  String website;

  String sector;

  String country;

  String description;

  String comments;

  String manufacture;

  UserData(
      {this.dataId,
      this.name,
      this.comments,
      this.country,
      this.description,
      this.manufacture,
      this.sector,
      this.website,
      this.wikiPage});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    comments = json['comments'] as String;
    country = json['country'] as String;
    description = json['description'] as String;
    sector = json['sector'] as String;
    manufacture = json['manufacture'] as String;
    website = json['website'] as String;
    wikiPage = json['wikiPage'] as String;
    dataId = json['dataId'] as String;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'comments': comments,
        'description': description,
        'country': country,
        'dataId': dataId,
        'sector': sector,
        'website': website,
        'wikiPage': wikiPage,
        'manufacture': manufacture
      };
}
