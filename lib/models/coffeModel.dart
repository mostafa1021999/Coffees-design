final coffees=List.generate(names.length, (index) => Coffee(name :names[index],image: 'assets/${index+1}.png',price: prices[index]));

class Coffee{
  Coffee({required this.name,required this.image,required this.price});
  final String name;
  final String image;
  final String price;
}

final names=['tea','milk','mmmmmmm','tea','milk','mmmmmmm',
  'tea','milk','mmmmmmm','tea','milk','mmmmmmm'];
final prices=['20','30','40','20','30','40','20','30','40','20','30','40'];
