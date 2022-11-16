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
    image: 'assets/shirt.jpg'
  ),
  CategoryChip(
    name: 'Shorts', 
    image: 'assets/shorts.jpeg'
  ),
  CategoryChip(
    name: 'Cap', 
    image: 'assets/cap.jpeg'
  ),
  CategoryChip(
    name: 'Trousers', 
    image: 'assets/trousers.jpeg'
  ),
  CategoryChip(
    name: 'Hoodie', 
    image: 'assets/hoodie.jpeg'
  ),
  CategoryChip(
    name: 'Watch', 
    image: 'assets/watch.jpeg'
  ),
  CategoryChip(
    name: 'Shoe', 
    image: 'assets/shoe.jpeg'
  ),
  CategoryChip(
    name: 'Perfume', 
    image: 'assets/perfume.jpeg'
  ),
  CategoryChip(
    name: 'Rings', 
    image: 'assets/ring.jpeg'
  ),
];

