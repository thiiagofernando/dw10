import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/storage/session_storage.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import '../order/order_page.dart';
import './menu/menu_bar.dart' as menu;

class BaseLayout extends StatelessWidget {
  final Widget body;
  const BaseLayout({Key? key, required this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scrennWidth = context.screenWidth;
    final shortestSide = context.screenShortestSide;
    return Scaffold(
      body: SizedBox(
        height: context.screenHeight,
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              constraints: BoxConstraints(
                minWidth: scrennWidth,
                minHeight: shortestSide * .15,
                maxHeight: shortestSide * .15,
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                width: shortestSide * .13,
                margin: const EdgeInsets.only(left: 60),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Modular.get<SessionStorage>().clean();
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)), // <-- Does not work
                  child: const Icon(Icons.exit_to_app),
                ),
              ),
            ),
            Positioned.fill(
              top: shortestSide * .13,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    const menu.MenuBar(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: Colors.grey[50],
                        child: body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
