class UserData{
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String uid;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toJson(){
    return {
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
      'email': email,
      'uid': uid
    };
  }

  factory UserData.fromJson(Map<String, dynamic> jsonUser){
    return UserData(
      firstName: jsonUser['first_name'],
      lastName: jsonUser['last_name'],
      userName: jsonUser['username'],
      email: jsonUser['email'],
      uid: jsonUser['uid']
    );
  }
}