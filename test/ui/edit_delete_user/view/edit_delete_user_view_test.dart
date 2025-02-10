import 'package:aranduapp/core/network/token_manager/model/user_model.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/edit_delete_user/view/edit_delete_user_view.dart';
import 'package:aranduapp/ui/edit_delete_user/viewmode/edit_delte_user_viewmodel.dart';
import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:aranduapp/ui/login/viewmodel/login_viewmodel.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_delete_user_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<EditDelteUserViewmodel>(), MockSpec<Command0>()])

void main(){
  late MockEditDelteUserViewmodel mockEditDelteUserViewmodel;
  late MockCommand0 mockdeleteUserCommand0;

  //final user = UserModel(id: '123456789', name: 'usertest', userName: 'usertest2', email: 'usertest@gmail.com', role: 'estudante');

  setUp(() async {
    mockEditDelteUserViewmodel = MockEditDelteUserViewmodel();
    mockdeleteUserCommand0 = MockCommand0();

    when(mockEditDelteUserViewmodel.deleteUserCommand).thenReturn(mockdeleteUserCommand0);


    when(mockdeleteUserCommand0.running).thenReturn(false);
    when(mockdeleteUserCommand0.isError).thenReturn(false);
    when(mockdeleteUserCommand0.isOk).thenReturn(false);

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<EditDelteUserViewmodel>(
            () => mockEditDelteUserViewmodel);
    GetIt.I.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  });

  Widget createScreen() {
    return const MaterialApp(
      home: EditDeleteUser(),
    );
  }

  testWidgets('Edit delete user screen display', (WidgetTester tester) async{
    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    expect(find.text('Tem certeza de que deseja excluir sua conta? Essa ação não pode ser desfeita.'), findsOneWidget);
    expect(find.byType(CommandButton), findsOneWidget);
  });

  testWidgets('checks if when pressing the button is success', (WidgetTester tester) async{
    //when(mockEditDelteUserViewmodel.deleteUserCommand.isOk).thenReturn(true);

    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Deletar'));
    await tester.pump();

    verify(mockdeleteUserCommand0.execute()).called(1);

  });

  testWidgets('navigates to Login after successful delete', (WidgetTester tester) async {
    when(mockdeleteUserCommand0.isOk).thenReturn(true);

    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    expect(find.byType(Login), findsOneWidget);
  });

}