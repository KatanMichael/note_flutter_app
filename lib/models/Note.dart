// Use data classes from the `freezed` library
class Note
{
  final String _text;
  final String _title;
  final String _noteUserId;

  Note.name(this._text, this._title, this._noteUserId);

  String get text => _text;

  String get title => _title;

  String get noteUserId => _noteUserId;
}