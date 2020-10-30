import 'package:flutter_country_picker/flutter_country_picker.dart';

class Company {
  String name;

  String wikipedia;

  String keyPerson;

  String website;

  String sector;

  Country country;

  String description;

  String stories;

  String logoFileName;
  Company(
      {this.name,
      this.wikipedia,
      this.website,
      this.keyPerson,
      this.sector,
      this.country,
      this.stories,
      this.description,
      this.logoFileName});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        name: json['name'] as String,
        wikipedia: json['wikipedia'] as String,
        website: json['website'] as String,
        keyPerson: json['keyPerson'] as String,
        sector: json['sector'] as String,
        country: json['country'] as Country,
        stories: json['stories'] as String,
        description: json['description'] as String,
        logoFileName: json['logoFileName'] as String);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'wikipedia': wikipedia,
        'website': website,
        'keyPerson': keyPerson,
        'sector': sector,
        'country': country,
        'stories': stories,
        'description': description,
        'logoFileName': logoFileName
      };
}
