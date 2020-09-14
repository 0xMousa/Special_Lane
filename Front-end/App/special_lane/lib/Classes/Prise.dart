class Prise {
  String name, shop;
  int points;

  Prise({
    this.name,
    this.shop,
    this.points,
  });

  fromMap(Map<String, dynamic> map) {
    this.name = map['name'] ?? '';
    this.shop = map['shop'] ?? '';
    this.points = map['points'] ?? '';
  }
}
