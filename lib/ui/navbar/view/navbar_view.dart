import 'package:aranduapp/ui/home/view/home_view.dart';
import 'package:aranduapp/ui/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:aranduapp/ui/navbar/viewmodel/navbar_viewmodel.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavbarViewModel viewModel = GetIt.I<NavbarViewModel>();

    return Scaffold(
      body: page(context, viewModel),
    );
  }
}

Widget page(BuildContext context, NavbarViewModel viewModel) {
  final List<Widget> pages = [
    const HomeView(),
    const Center(child: Text('Friends', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Dashbord', style: TextStyle(fontSize: 20))),
    const Profile(),
  ];

  return Scaffold(
    body: pages[viewModel.selectedIndex],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: viewModel.selectedIndex,
      onTap: viewModel.changeTab,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups_outlined),
          label: "Amigos",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Perfil",
        ),
      ],
    ),
  );
}
