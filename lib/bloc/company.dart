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

  int makesInIndia;
  Company(
      {this.id,
      this.companyId,
      this.companyName,
      this.wikiPage,
      this.website,
      this.keyPerson,
      this.sector,
      this.country,
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
      this.firstCountry});

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
    makesInIndia = json['makesInIndia'] as int;
    aboutCompany = json['aboutCompany'] as String;
    addedByImage = json['addedByImage'] as String;
    addedByName = json['addedByName'] as String;
    addedByPlace = json['addedByPlace'] as String;
    dateAdded = json['dateAdded'] as String;
    dateUpdated = json['dateUpdated'] as String;
    image = json['image'] as String;
    isActive = json['isActive'] as int;
    moderatorByImage = json['moderatorByImage'] as String;
    moderatorByName = json['moderatorByName'] as String;
    moderatorByPlace = json['moderatorByPlace'] as String;
    firstCountry = json['firstCountry'] as String;
    isService = json['isService'] as int;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyId': companyId,
        'companyName': companyName,
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
        'isService': isService
      };
}
