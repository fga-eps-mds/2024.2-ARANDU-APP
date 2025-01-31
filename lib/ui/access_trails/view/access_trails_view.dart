import 'package:aranduapp/ui/access_trails/view/flecha.dart';
import 'package:aranduapp/ui/access_trails/viewmodel/access_trails_viewmodel.dart';
import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'grafismo.dart';

class AccessTrails extends StatelessWidget {
  final JourneyModel journey;

  const AccessTrails({super.key, required this.journey});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccessTrailsViewmodel>.value(
      value: GetIt.instance<AccessTrailsViewmodel>(),
      child: _AccessTrailsScreen(journey: journey),
    );
  }
}

class _AccessTrailsScreen extends StatelessWidget {
  final JourneyModel journey;

  const _AccessTrailsScreen({required this.journey});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final viewModel =
        Provider.of<AccessTrailsViewmodel>(context, listen: false);

    viewModel.getAccessTrailsCommand.execute(journey.id);

    final ColorScheme lightColors = ColorScheme(
      brightness: Brightness.light,
      primary: const Color(0xFFE65100),
      onPrimary: Colors.white,
      secondary: Colors.green,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.grey[200]!,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      onInverseSurface: const Color(0xFFEDE5E0),
    );
    final ColorScheme darkColors = ColorScheme(
      brightness: Brightness.dark,
      primary: const Color(0xFFFFB300),
      onPrimary: Colors.black,
      secondary: const Color(0xFF03DAC6),
      onSecondary: Colors.black,
      error: const Color(0xFFCF6679),
      onError: Colors.black,
      background: const Color(0xFF121212),
      onBackground: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      onInverseSurface: const Color(0xFF463F2C),
    );

    final colors = brightness == Brightness.dark ? darkColors : lightColors;
    return Scaffold(
        appBar: _buildAppBar(context),
        body: ListenableBuilder(
            listenable: viewModel.getAccessTrailsCommand,
            builder: (context, child) {
              if (viewModel.getAccessTrailsCommand.isOk)
                return SingleChildScrollView(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: Center(
                      child: Column(
                        children: [
                          CustomPaint(
                            painter: Fundo(colors),
                            child: const SizedBox(
                              height: 100,
                              width: 200,
                            ),
                          ),
                          CustomPaint(
                            painter: Square(colors),
                            child: const SizedBox(
                              height: 100,
                              width: 200,
                            ),
                          ),
                          CustomPaint(
                            painter: Base(colors),
                            child: const SizedBox(
                              height: 50,
                              width: 200,
                            ),
                          ),
                          CorpoList(colors: colors),
                          CustomPaint(
                            painter: Ponta(colors),
                            child: const SizedBox(
                              height: 250,
                              width: 225,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              else if (viewModel.getAccessTrailsCommand.isError)
                return ErrorScreen(
                    message:
                        "Não foi possível carregar trilha \n ${viewModel.getAccessTrailsCommand.result!.asError!.error.toString()}");

              return Text("a");
            }));
  }

  AppBar _buildAppBar(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final ColorScheme lightColors = ColorScheme(
      brightness: Brightness.light,
      primary: const Color(0xFFE65100),
      onPrimary: Colors.white,
      secondary: Colors.green,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.grey[200]!,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      onInverseSurface: const Color(0xFF463F2C),
    );

    final ColorScheme darkColors = ColorScheme(
      brightness: Brightness.dark,
      primary: const Color(0xFFFFB300),
      onPrimary: Colors.black,
      secondary: const Color(0xFF03DAC6),
      onSecondary: Colors.black,
      error: const Color(0xFFCF6679),
      onError: Colors.black,
      background: const Color(0xFF121212),
      onBackground: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
    );

    // Escolher o esquema de cores baseado no tema atual
    final colors = brightness == Brightness.dark ? darkColors : lightColors;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      flexibleSpace: CustomPaint(
        size: Size(double.infinity, kToolbarHeight),
        painter: CustomPatternPainter(colors),
      ),
      toolbarHeight: 60,
      title: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Lógica booleana',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}
