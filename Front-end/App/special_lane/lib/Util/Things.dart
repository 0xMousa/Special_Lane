import 'package:special_lane/Classes/classes.dart';

class Things {
  static final cities = [
    'Amman',
    'Zarqa',
    'Irbid',
    'Aqaba',
    'Salt',
    'Jerash',
    'Ma\'an',
    'Karak',
    'Tafilah',
    'Mafraq',
    'Madaba',
    'Ajloun',
  ];

  static final prizes = [
    'Drinks',
    'Food',
    'Cobons',
    'Health',
    'Beauty',
  ];

  static final drinks = {
    'Drinks': [
      Prise(
        name: 'French Press',
        shop: 'Starbucks',
        points: 1000,
      ),
      Prise(
        name: 'Latte',
        shop: 'Starbucks',
        points: 500,
      ),
      Prise(
        name: 'Orange juices',
        shop: 'Juice Shop',
        points: 150,
      ),
      Prise(
        name: 'Tea',
        shop: 'Tchaba',
        points: 100,
      ),
    ],
  };
}
