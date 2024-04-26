import 'package:flutter/material.dart';
import 'package:gym_app/pages/bluetooth/bluetooth_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/icon.jpg',
              width: 40.0,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const BluetoothPage(),)),
                  icon: const Icon(
                    Icons.bluetooth_rounded,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size(double.maxFinite, kToolbarHeight + 80);
}
