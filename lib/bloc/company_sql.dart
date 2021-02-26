class CompanySql {
  String companyId;

  String companyName;

  String country;

  String logoFileName;

  String rating;

  int makesInIndia;
  CompanySql(
      {this.companyId,
      this.companyName,
      this.country,
      this.logoFileName,
      this.makesInIndia,
      this.rating});
  Map<String, dynamic> toJson() => {
        'id': companyId,
        'country': country,
        'companyName': companyName,
        'logoFileName': logoFileName,
        'rating': rating
      };

  CompanySql.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'] as String;
    companyName = json['company_name'] as String;
    country = json['country'] as String;
    logoFileName = json['company_logo'] as String;
    rating = json['company_rating'] as String;
  }
}
