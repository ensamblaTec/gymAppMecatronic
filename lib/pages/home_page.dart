import 'package:flutter/material.dart';
import 'package:gym_app/models/data.dart';
import 'package:gym_app/pages/detail_machine_page.dart';
import 'package:gym_app/widgets/custom_app_bar.dart';
import 'package:gym_app/widgets/custom_bottom_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(viewportFraction: 0.75);

  double _currentPage = 0.0;

  double indexPage = 0.0;

  void _listener() {
    setState(() {
      _currentPage = _pageController.page!;
      if (_currentPage >= 0.0 && _currentPage < 0.7) {
        indexPage = 0;
      } else if (_currentPage > 0.7 && _currentPage < 1.7) {
        indexPage = 1;
      } else if (_currentPage > 1.7 && _currentPage < 2.7) {
        indexPage = 2;
      }
    });
  }

  Color getColor() {
    late final Color color;
    if (_currentPage >= 0.0 && _currentPage < 0.7) {
      color = ListMachine[0].listImage[0].color;
    } else if (_currentPage > 0.7 && _currentPage < 1.7) {
      color = ListMachine[1].listImage[0].color;
    } else if (_currentPage > 1.7 && _currentPage < 2.7) {
      color = ListMachine[2].listImage[0].color;
    }
    return color;
  }

  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  @override
  void initState() {
    _pageController.addListener(_listener);

    _requestPermission();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          // const CustomAppBar(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: List.generate(
                listCategory.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    listCategory[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0,
                      color: index == indexPage ? getColor() : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: ListMachine.length,
                controller: _pageController,
                itemBuilder: (context, index) {
                  final machine = ListMachine[index];
                  final listTitle = machine.category.split(' ');
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, _) {
                        return DetailMachinePage(treadmill: machine);
                      }));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: index == indexPage ? 30.0 : 60.0),
                      child: Transform.translate(
                        offset: Offset(index == indexPage ? 0.0 : 20.0, 0.0),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 250,
                            ),
                            margin: EdgeInsets.only(
                              top: index == indexPage ? 30.0 : 50.0,
                              bottom: 30.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36.0),
                              color: Colors.white,
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 40.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        machine.category,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        machine.name,
                                        style: const TextStyle(
                                          fontSize: 28.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        machine.price,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      FittedBox(
                                        child: Text(
                                          '${listTitle[0]} \n ${listTitle[1]}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: constraints.maxHeight * 0.2,
                                  left: constraints.maxWidth * 0.05,
                                  right: -constraints.maxWidth * 0.16,
                                  bottom: constraints.maxHeight * 0.2,
                                  child: Hero(
                                    tag: machine.name,
                                    child: Image(
                                      image: AssetImage(
                                        machine.listImage[0].image,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  right: 0.0,
                                  child: Material(
                                    color: machine.listImage[0].color,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(36.0),
                                      bottomRight: Radius.circular(36.0),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      onTap: () {},
                                      child: const SizedBox(
                                        height: 100.0,
                                        width: 100.0,
                                        child: Icon(
                                          Icons.add,
                                          size: 40.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 120.0,
            child: CustomBottomBar(
              color: getColor(),
            ),
          )
        ],
      ),
    );
  }
}
