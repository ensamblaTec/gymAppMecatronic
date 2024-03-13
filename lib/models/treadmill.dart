import 'package:gym_app/models/image_machine.dart';

class Treadmill{
  Treadmill(
    this.name,
    this.category,
    this.price,
    this.punctuation,
    this.listImage,
  );

  final String name;

  final String category;

  final String price;

  final int punctuation;

  final List<ImageMachine> listImage;
}