// ignore_for_file: prefer_const_constructors

class CategoryChip {
  String name;
  String image;
  CategoryChip({
    required this.name,
    required this.image,
  });
}

List<CategoryChip> chips = [
  CategoryChip(
    name: 'Shirts', 
    image: 'assets/shirt.jpg'//Image(image: AssetImage('assets/shirt.jpg'),)
  ),
  CategoryChip(
    name: 'Shorts', 
    image: 'assets/shorts.jpeg'//Image(image: AssetImage('assets/shorts.jpg'),)
  ),
  CategoryChip(
    name: 'Cap', 
    image: 'assets/cap.jpeg'//Image(image: AssetImage('assets/shorts.jpg'),)
  ),
  CategoryChip(
    name: 'Trousers', 
    image: 'assets/trousers.jpeg'//Image(image: AssetImage('assets/trousers.jpg'),)
  ),
  CategoryChip(
    name: 'Hoodie', 
    image: 'assets/hoodie.jpeg'//Image(image: AssetImage('assets/shorts.jpg'),)
  ),
  CategoryChip(
    name: 'Watch', 
    image: 'assets/watch.jpeg'//Image(image: AssetImage('assets/watch.jpg'),)
  ),
  CategoryChip(
    name: 'Shoe', 
    image: 'assets/shoe.jpeg'//Image(image: AssetImage('assets/shoe.jpg'),)
  ),
  CategoryChip(
    name: 'Perfume', 
    image: 'assets/perfume.jpeg'//Image(image: AssetImage('assets/perfume.jpg'),)
  ),
  CategoryChip(
    name: 'Rings', 
    image: 'assets/ring.jpeg'//Image(image: AssetImage('assets/ring.jpg'),)
  ),
];

