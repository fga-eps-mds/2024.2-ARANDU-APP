// Mocks generated by Mockito 5.4.4 from annotations
// in aranduapp/test/ui/register_account/view/register_account_view_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:aranduapp/core/state/command.dart' as _i3;
import 'package:aranduapp/ui/register_account/viewModel/register_view_model.dart'
    as _i5;
import 'package:async/async.dart' as _i4;
import 'package:flutter/material.dart' as _i1;
import 'package:mockito/mockito.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGlobalKey_0<T extends _i1.State<_i1.StatefulWidget>>
    extends _i2.SmartFake implements _i1.GlobalKey<T> {
  _FakeGlobalKey_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTextEditingController_1 extends _i2.SmartFake
    implements _i1.TextEditingController {
  _FakeTextEditingController_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCommand0_2<T> extends _i2.SmartFake implements _i3.Command0<T> {
  _FakeCommand0_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResult_3<T1> extends _i2.SmartFake implements _i4.Result<T1> {
  _FakeResult_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RegisterAccountViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegisterAccountViewModel extends _i2.Mock
    implements _i5.RegisterAccountViewModel {
  @override
  _i1.GlobalKey<_i1.FormState> get formKey => (super.noSuchMethod(
        Invocation.getter(#formKey),
        returnValue: _FakeGlobalKey_0<_i1.FormState>(
          this,
          Invocation.getter(#formKey),
        ),
        returnValueForMissingStub: _FakeGlobalKey_0<_i1.FormState>(
          this,
          Invocation.getter(#formKey),
        ),
      ) as _i1.GlobalKey<_i1.FormState>);

  @override
  _i1.TextEditingController get nameController => (super.noSuchMethod(
        Invocation.getter(#nameController),
        returnValue: _FakeTextEditingController_1(
          this,
          Invocation.getter(#nameController),
        ),
        returnValueForMissingStub: _FakeTextEditingController_1(
          this,
          Invocation.getter(#nameController),
        ),
      ) as _i1.TextEditingController);

  @override
  _i1.TextEditingController get emailController => (super.noSuchMethod(
        Invocation.getter(#emailController),
        returnValue: _FakeTextEditingController_1(
          this,
          Invocation.getter(#emailController),
        ),
        returnValueForMissingStub: _FakeTextEditingController_1(
          this,
          Invocation.getter(#emailController),
        ),
      ) as _i1.TextEditingController);

  @override
  _i1.TextEditingController get userNameController => (super.noSuchMethod(
        Invocation.getter(#userNameController),
        returnValue: _FakeTextEditingController_1(
          this,
          Invocation.getter(#userNameController),
        ),
        returnValueForMissingStub: _FakeTextEditingController_1(
          this,
          Invocation.getter(#userNameController),
        ),
      ) as _i1.TextEditingController);

  @override
  _i1.TextEditingController get passwordController => (super.noSuchMethod(
        Invocation.getter(#passwordController),
        returnValue: _FakeTextEditingController_1(
          this,
          Invocation.getter(#passwordController),
        ),
        returnValueForMissingStub: _FakeTextEditingController_1(
          this,
          Invocation.getter(#passwordController),
        ),
      ) as _i1.TextEditingController);

  @override
  bool get isTermsAccepted => (super.noSuchMethod(
        Invocation.getter(#isTermsAccepted),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  set isTermsAccepted(bool? _isTermsAccepted) => super.noSuchMethod(
        Invocation.setter(
          #isTermsAccepted,
          _isTermsAccepted,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Command0<void> get registerCommand => (super.noSuchMethod(
        Invocation.getter(#registerCommand),
        returnValue: _FakeCommand0_2<void>(
          this,
          Invocation.getter(#registerCommand),
        ),
        returnValueForMissingStub: _FakeCommand0_2<void>(
          this,
          Invocation.getter(#registerCommand),
        ),
      ) as _i3.Command0<void>);

  @override
  set registerCommand(_i3.Command0<void>? _registerCommand) =>
      super.noSuchMethod(
        Invocation.setter(
          #registerCommand,
          _registerCommand,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void toggleTermsAccepted(bool? value) => super.noSuchMethod(
        Invocation.method(
          #toggleTermsAccepted,
          [value],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(dynamic listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(dynamic listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [Command0].
///
/// See the documentation for Mockito's code generation for more information.
class MockCommand0<T> extends _i2.Mock implements _i3.Command0<T> {
  @override
  _i6.Future<_i4.Result<T>> Function() get action => (super.noSuchMethod(
        Invocation.getter(#action),
        returnValue: () => _i6.Future<_i4.Result<T>>.value(_FakeResult_3<T>(
          this,
          Invocation.getter(#action),
        )),
        returnValueForMissingStub: () =>
            _i6.Future<_i4.Result<T>>.value(_FakeResult_3<T>(
          this,
          Invocation.getter(#action),
        )),
      ) as _i6.Future<_i4.Result<T>> Function());

  @override
  bool get isError => (super.noSuchMethod(
        Invocation.getter(#isError),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get isOk => (super.noSuchMethod(
        Invocation.getter(#isOk),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get running => (super.noSuchMethod(
        Invocation.getter(#running),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i6.Future<_i4.Result<T>> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i6.Future<_i4.Result<T>>.value(_FakeResult_3<T>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Result<T>>.value(_FakeResult_3<T>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Result<T>>);

  @override
  void addListener(dynamic listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(dynamic listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}