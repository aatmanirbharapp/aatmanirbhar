class Company {
  String id;

  String companyId;

  String companyName;

  String wikiPage;

  String aboutCompany;

  String addedByImage;

  String addedByName;

  String addedByPlace;

  String dateAdded;

  String dateUpdated;

  String firstCountry;

  String secondCountry;

  String image;

  int isActive;

  String moderatorByImage;

  String moderatorByPlace;

  String moderatorByName;

  String keyPerson;

  String website;

  String sector;

  String country;

  int isService;

  String description;

  String story;

  String logoFileName;

  String cin;

  var makesInIndia;

  Company(
      {this.id,
      this.companyId,
      this.companyName,
      this.wikiPage,
      this.website,
      this.keyPerson,
      this.sector,
      this.country,
      this.secondCountry,
      this.story,
      this.description,
      this.logoFileName,
      this.makesInIndia,
      this.aboutCompany,
      this.addedByImage,
      this.addedByName,
      this.addedByPlace,
      this.dateAdded,
      this.dateUpdated,
      this.image,
      this.isActive,
      this.isService,
      this.moderatorByImage,
      this.moderatorByName,
      this.moderatorByPlace,
      this.firstCountry,
      this.cin});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    companyId = json['companyId'] as String;
    companyName = json['companyName'] as String;
    wikiPage = json['wikiPage'] as String;
    website = json['website'] as String;
    keyPerson = json['keyPerson'] as String;
    sector = json['sector'] as String;
    country = json['country'] as String;
    story = json['story'] as String;
    description = json['description'] as String;
    logoFileName = json['logoFileName'] as String;
    makesInIndia = json['makesInIndia'];
    aboutCompany = json['aboutCompany'] as String;
    addedByImage = json['addedByImage'] as String;
    addedByName = json['addedByName'] as String;
    addedByPlace = json['addedByPlace'] as String;
    cin = json['cin'] as String;
    image = json['image'] as String;
    isActive = json['isActive'] as int;
    moderatorByImage = json['moderatorByImage'] as String;
    moderatorByName = json['moderatorByName'] as String;
    moderatorByPlace = json['moderatorByPlace'] as String;
    firstCountry = json['firstCountry'] as String;
    isService = json['isService'] as int;
    secondCountry = json['secondCountry'] as String;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyId': companyId,
        'companyName': companyName,
        'cin': cin,
        'wikiPage': wikiPage,
        'website': website,
        'keyPerson': keyPerson,
        'sector': sector,
        'country': country,
        'story': story,
        'description': description,
        'logoFileName': logoFileName,
        'makesInIndia': makesInIndia,
        'aboutCompany': aboutCompany,
        'addedByImage': addedByImage,
        'addedByName': addedByName,
        'addedByPlace': addedByPlace,
        'dateAdded': dateAdded,
        'dateUpdated': dateUpdated,
        'image': image,
        'isActive': isActive,
        'moderatorByImage': moderatorByImage,
        'moderatorByName': moderatorByName,
        'moderatorByPlace': moderatorByPlace,
        'firstCountry': firstCountry,
        'isService': isService,
        'secondCountry': secondCountry
      };
}
