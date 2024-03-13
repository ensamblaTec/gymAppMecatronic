import 'package:flutter/material.dart';
import 'package:gym_app/models/treadmill.dart';
import 'package:gym_app/widgets/custom_buttom.dart';
import 'package:gym_app/widgets/transition.dart';

class DetailMachinePage extends StatefulWidget {
  const DetailMachinePage({
    Key? key,
    required this.treadmill,
  }) : super(key: key);

  final Treadmill treadmill;

  @override
  State<DetailMachinePage> createState() => _DetailMachinePageState();
}

class _DetailMachinePageState extends State<DetailMachinePage> {
  int valueIndexColor = 0;
  int valueIndexSize = 1;

  double sizeShoes(
    int index,
    Size size,
  ) {
    switch (index) {
      case 0:
        return (size.height * 0.09);
      case 1:
        return (size.height * 0.07);
      case 2:
        return (size.height * 0.05);
      case 3:
        return (size.height * 0.04);
      default:
        return (size.height * 0.05);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -size.height * 0.15,
            right: -size.height * 0.20,
            child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 250),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, __) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: value * (size.height * 0.5),
                    width: value * (size.height * 0.5),
                    decoration: BoxDecoration(
                      color: widget.treadmill.listImage[valueIndexColor].color,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
          ),
          Positioned(
            top: kToolbarHeight,
            left: 16.0,
            right: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButtom(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.2,
            right: 0.0,
            left: 0.0,
            child: FittedBox(
              child: Text(
                widget.treadmill.category,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[100],
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.22,
            right: sizeShoes(valueIndexSize, size),
            left: sizeShoes(valueIndexSize, size),
            child: Hero(
              tag: widget.treadmill.name,
              child: Image(
                image: AssetImage(
                  widget.treadmill.listImage[valueIndexColor].image,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.6,
            left: 16.0,
            right: 16.0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ShakeTransition(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.treadmill.category,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            widget.treadmill.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ShakeTransition(
                      left: false,
                      child: Text(
                        widget.treadmill.price,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
                ShakeTransition(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: widget.treadmill.punctuation > index
                                ? widget.treadmill.listImage[valueIndexColor].color
                                : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Presets',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: const EdgeInsets.only(
                              right: 16.0,
                            ),
                            child: CustomButtom(
                              onTap: () {
                                valueIndexSize = index;
                                setState(() {
                                  
                                });
                              },
                              color: index == valueIndexSize 
                                  ? widget.treadmill.listImage[valueIndexColor].color
                                  : Colors.white,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0,
                                  color:
                                      index == valueIndexSize ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.84,
            left: 16.0,
            right: 16.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShakeTransition(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Colors',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: List.generate(
                          widget.treadmill.listImage.length,
                          (index) => GestureDetector(
                            onTap: () {
                              valueIndexColor = index;
                              setState(() {
                                
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                color: widget.treadmill.listImage[index].color,
                                shape: BoxShape.circle,
                                border: index == valueIndexColor
                                    ? Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ShakeTransition(
                  left: false,
                  child: CustomButtom(
                    onTap: () {},
                    width: 100.0,
                    color: widget.treadmill.listImage[valueIndexColor].color,
                    child: const Text(
                      'STOP',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
