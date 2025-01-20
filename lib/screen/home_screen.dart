import 'package:echo/bloc/cubit/app_cubit.dart';
import 'package:echo/controller/home_controller.dart';
import 'package:echo/screen/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  factory HomeScreen({Key? key}) {
    HomeController controller = HomeController();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return HomeScreen._(key: key, controller: controller);
  }

  const HomeScreen._({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainState<int>, int>(
        bloc: controller.selectedIndex,
        builder: (context, currentIndex) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(controller.titles[currentIndex],
                    style: Theme.of(context).textTheme.titleMedium),
                centerTitle: false,
                titleSpacing: 0,
                leading: Icon(
                  controller.icons[currentIndex],
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              body: ChatsScreen(),
              bottomNavigationBar: BottomNavigationBar(
                  onTap: (val) =>
                      controller.selectedIndex.setState(newState: val),
                  currentIndex: currentIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(controller.icons[0]),
                        label: controller.titles[0]),
                    BottomNavigationBarItem(
                        icon: Icon(controller.icons[1]),
                        label: controller.titles[1]),
                    BottomNavigationBarItem(
                        icon: Icon(controller.icons[2]),
                        label: controller.titles[2]),
                  ]),
            ));
  }
}
