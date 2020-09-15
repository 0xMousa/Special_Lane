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

  static final prise = {
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
      Prise(
        name: 'Coffee',
        shop: 'Starbucks',
        points: 200,
      ),
    ],
    'Food': [],
    'Cobons': [],
    'Health': [],
    'Beauty': [],
  };

  static final city = {
    'Amman': [
      Location(
        location: 'Tabarbour',
        date: '15 Sep 2020',
        points: '+20',
      ),
      Location(
        location: 'Na\'ur',
        date: '1 Sep 2020',
        points: '+20',
      ),
      Location(
        location: 'Russeifa',
        date: '29 Mar 2020',
        points: '+20',
      ),
      Location(
        location: 'Al Yadudah',
        date: '20 Mar 2020',
        points: '-20',
      ),
    ],
    'Zarqa': [],
    'Irbid': [],
    'Aqaba': [],
    'Salt': [],
    'Jerash': [],
    'Ma\'an': [],
    'Karak': [],
    'Tafilah': [],
    'Mafraq': [],
    'Madaba': [],
    'Ajloun': [],
  };
}
