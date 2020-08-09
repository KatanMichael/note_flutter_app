// CR: use data classes from freezed library
class User
{
  final String useruid;
  final String userEmail;
  final String username;
  // CR: use @required annotation
  User({this.useruid, this.userEmail, this.username});
}