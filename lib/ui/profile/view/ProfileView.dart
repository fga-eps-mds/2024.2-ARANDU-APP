import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/ui/profile/viewModel/ProfileViewModel.dart';
import 'package:aranduapp/ui/shared/ErrorPopUp.dart';
import 'package:aranduapp/ui/shared/TextAndLink.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/TitleSlogan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(), // Corrigido
      body: ChangeNotifierProvider(
        create: (context) => ProfileViewModel(context),
        builder: (context, child) {
          return _buildPage(context);
        },
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: const Text("Profile"),
    centerTitle: true,
    backgroundColor: Colors.blue,
  );
}

Widget _buildPage(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: const Text(
        'This is the next page',
        style: TextStyle(fontSize: 24),
      ),
    ),
  );
}
