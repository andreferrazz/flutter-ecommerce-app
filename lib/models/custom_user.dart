class CustomUser {
  String _id;
  String _name;
  String _email;

  CustomUser(
    this._id,
    this._name,
    this._email,
  );

  CustomUser.fromJson(Map<String, dynamic> map)
      : _id = map['id'],
        _name = map['name'],
        _email = map['email'];

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
    };
  }

  @override
  String toString() {
    return 'CustomUser{_id: $_id, _name: $_name, _email: $_email}';
  }

  String get id => _id;

  set name(String name) {
    _name = name;
  }
}
