import 'package:aranduapp/core/network/token_manager/model/user_model.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/edit_profile/model/edit_profile_request.dart';
import 'package:aranduapp/ui/edit_profile/view/edit_profile_view.dart';
import 'package:aranduapp/ui/edit_profile/viewmodel/edit_profile_viewmodel.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<EditProfileViewModel>(), MockSpec<Command1>(), MockSpec<Command0>()])

void main() {
  
  late MockEditProfileViewModel mockEditProfileViewModel;
  late MockCommand1<void, EditProfileRequest> mockEditProfileCommand1;
  late MockCommand0<UserModel> mockGetUserCommand1;

  setUp(() async {
    mockEditProfileViewModel =MockEditProfileViewModel();

    mockEditProfileCommand1 = MockCommand1();
    when(mockEditProfileViewModel.editCommand)
        .thenReturn(mockEditProfileCommand1);
    when(mockEditProfileCommand1.running).thenReturn(false);
    when(mockEditProfileCommand1.isError).thenReturn(false);
    when(mockEditProfileCommand1.isOk).thenReturn(false);

    mockGetUserCommand1 = MockCommand0();
    when(mockEditProfileViewModel.getUserCommand)
        .thenReturn(mockGetUserCommand1);
    when(mockGetUserCommand1.running).thenReturn(false);
    when(mockGetUserCommand1.isError).thenReturn(false);
    when(mockGetUserCommand1.isOk).thenReturn(false);


    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<EditProfileViewModel>(
        () => mockEditProfileViewModel);
  });

  Widget createScreen() {
    return const MaterialApp(
      home: EditProfile(),
    );
  }

  testWidgets('edit profile screen displays', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byKey(const ValueKey('nameController')), findsOneWidget);
    expect(find.byKey(const ValueKey('userNameController')), findsOneWidget);
    expect(find.byKey(const ValueKey('emailNameController')), findsOneWidget);
    expect(find.byType(CommandButton), findsOneWidget);
  });



  testWidgets('edit password right values', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());

    const name = 'gabriel';
    const email = 'gab@gmail.com';
    const userName = 'dark';

    await tester.enterText(find.byKey(const ValueKey('nameController')), name);
    await tester.enterText(find.byKey(const ValueKey('emailNameController')), email);
    await tester.enterText(find.byKey(const ValueKey('userNameController')), userName);

    await tester.tap(find.byKey(const Key('elevated_button_key')));
    await tester.pumpAndSettle();

    verify(mockEditProfileCommand1.execute(argThat(
        predicate<EditProfileRequest>((req) =>
            req.name == name &&
            req.email == email &&
            req.userName == userName
            )))).called(1);
  });

  testWidgets('edit password wrong values', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());

    const name = 'gabriel';
    const email = 'gab';
    const userName = 'dark';

    await tester.enterText(find.byKey(const ValueKey('nameController')), name);
    await tester.enterText(find.byKey(const ValueKey('emailNameController')), email);
    await tester.enterText(find.byKey(const ValueKey('userNameController')), userName);

    await tester.tap(find.byKey(const Key('elevated_button_key')));
    await tester.pumpAndSettle();

    verifyNever(mockEditProfileCommand1.execute(argThat(isNotNull)));
  });

}

