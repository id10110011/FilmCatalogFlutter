class User {
  String email = "";
  String firstname = "";
  String lastname = "";
  String dateOfBirth = "";
  String county = "";
  String city = "";
  String gender = "";
  String education = "";
  String description = "";

  User(
    this.email,
    this.firstname,
    this.lastname,
    this.dateOfBirth,
    this.county,
    this.city,
    this.gender,
    this.education,
    this.description
  );

  User.empty();

  User.fromRegistration(
    this.email,
    this.firstname
  );
}