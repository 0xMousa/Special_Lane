class Location {
  String location, date, points;

  Location({
    this.location,
    this.date,
    this.points,
  });

  fromMap(Map<String, dynamic> map) {
    this.location = map['location'] ?? '';
    this.date = map['date'] ?? '';
    this.points = map['points'] ?? '';
  }
}
