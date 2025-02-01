import 'package:aranduapp/ui/home/view/home_view.dart';
import 'package:aranduapp/ui/profile/view/profile_view.dart';
import 'package:aranduapp/ui/subjects/view/subjects_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:aranduapp/ui/navbar/viewmodel/navbar_viewmodel.dart';
import 'package:provider/provider.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavbarViewModel>.value(
      value: GetIt.instance<NavbarViewModel>(),
      child: const NavBarScreen(),
    );
  }
}

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavbarViewModel viewModel = Provider.of<NavbarViewModel>(context);

    final List<Widget> pages = [
      const HomeView(),
      const Center(child: Text('Friends', style: TextStyle(fontSize: 20))),
      const Center(child: Text('Dashboard', style: TextStyle(fontSize: 20))),
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
            key: Key('homeTab'),
            icon: Icon(Icons.book_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            key: Key('amigosTab'),
            icon: Icon(Icons.groups_outlined),
            label: "Amigos",
          ),
          BottomNavigationBarItem(
            key: Key('dashboardTab'),
            icon: Icon(Icons.bar_chart),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            key: Key('perfilTab'),
            icon: Icon(Icons.person_outline),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
