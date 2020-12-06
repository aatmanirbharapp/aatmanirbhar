class Product {
  String id;

  String companyId;
  String productId;

  String productName;

  String wikiPage;

  String aboutproduct;

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

  String description;

  String logoFileName;

  String manufacture;

  String keywords;

  int makeInIndia;
  Product(
      {this.id,
      this.companyId,
      this.productId,
      this.productName,
      this.wikiPage,
      this.website,
      this.keyPerson,
      this.sector,
      this.country,
      this.description,
      this.logoFileName,
      this.makeInIndia,
      this.aboutproduct,
      this.addedByImage,
      this.addedByName,
      this.addedByPlace,
      this.dateAdded,
      this.dateUpdated,
      this.image,
      this.isActive,
      this.moderatorByImage,
      this.moderatorByName,
      this.moderatorByPlace,
      this.manufacture,
      this.keywords,
      this.firstCountry});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    productId = json['productId'] as String;
    productName = json['productName'] as String;
    wikiPage = json['wikiPage'] as String;
    website = json['website'] as String;
    keyPerson = json['keyPerson'] as String;
    sector = json['sector'] as String;
    country = json['country'] as String;
    companyId = json['companyId'] as String;
    description = json['description'] as String;
    logoFileName = json['logoFileName'] as String;
    makeInIndia = json['makeInIndia'] as int;
    aboutproduct = json['aboutproduct'] as String;
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
    manufacture = json['manufacture'] as String;
    keywords = json['keywords'] as String;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'productName': productName,
        'wikiPage': wikiPage,
        'website': website,
        'keyPerson': keyPerson,
        'sector': sector,
        'country': country,
        'description': description,
        'logoFileName': logoFileName,
        'makeInIndia': makeInIndia,
        'aboutproduct': aboutproduct,
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
        'manufacture': manufacture,
        'keywords': keywords,
        'firstCountry': firstCountry,
      };
}
