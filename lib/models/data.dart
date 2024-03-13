import 'package:flutter/material.dart';
import 'package:gym_app/models/treadmill.dart';
import 'package:gym_app/models/image_machine.dart';

final listCategory = ["Caminadora", "Escaladora", "Bicicleta"];

final ListMachine = [
  Treadmill(
    "Caminadora Model X",
    "Caminadora XXX",
    '\$1.0',
    4,
    [
      ImageMachine("assets/machines/treadmill/machine1.png", const Color(0xffEAA906),),
      ImageMachine("machines/treadmill/machine2.png", const Color(0xff08B894),),
      ImageMachine("machines/treadmill/machine3.png", const Color(0xffB50D0D),),
      ImageMachine("machines/treadmill/machine4.png", const Color(0xff229954),),
    ],
  ),
  Treadmill(
    "Caminadora Model Y",
    "Caminadoras Y",
    '\$1.0',
    4,
    [
      ImageMachine("assets/machines/treadmill/machine1.png", const Color(0xffEAA906),),
      ImageMachine("machines/treadmill/machine2.png", const Color(0xff0502BA),),
      ImageMachine("machines/treadmill/machine3.png", const Color(0xffB50D0D),),
      ImageMachine("machines/treadmill/machine4.png", const Color(0xff229954),),
    ],
  ),
  Treadmill(
    "Caminadora Model W",
    "Caminadoras W",
    '\$1.0',
    4,
    [
      ImageMachine("assets/machines/treadmill/machine1.png", const Color(0xffEAA906),),
      ImageMachine("machines/treadmill/machine2.png", const Color(0xff08B894),),
      ImageMachine("machines/treadmill/machine3.png", const Color(0xffB50D0D),),
      ImageMachine("machines/treadmill/machine4.png", const Color(0xff229954),),
    ],
  ),
];
