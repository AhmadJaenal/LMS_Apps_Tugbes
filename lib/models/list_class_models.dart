class ListClass {
  final String teachersName;
  final String id;

  const ListClass({this.teachersName = '', this.id = ''});

  factory ListClass.fromJson(Map<String, dynamic> json) {
    return ListClass(
      teachersName: json['name'],
      id: json['id'],
    );
  }
}
