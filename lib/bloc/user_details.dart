class UserDetails {
  String uid;

  String name;

  String email;

  String phonenumber;

  String bio;

  String birthdate;

  UserDetails(
      {this.uid,
      this.name,
      this.email,
      this.bio,
      this.phonenumber,
      this.birthdate});

  UserDetails.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] as String;
    name = json['name'] as String;
    email = json['email'] as String;
    phonenumber = json['phonenumber'] as String;
    bio = json['bio'] as String;
    birthdate = json['birthdate'] as String;
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'phonenumber': phonenumber,
        'bio': bio,
        'birthdate': birthdate
      };
}
