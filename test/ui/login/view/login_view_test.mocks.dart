// Mocks generated by Mockito 5.4.4 from annotations
// in aranduapp/test/ui/login/view/login_view_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:aranduapp/ui/login/viewModel/login_view_model.dart' as _i3;
import 'package:flutter/material.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeBuildContext_0 extends _i1.SmartFake implements _i2.BuildContext {
  _FakeBuildContext_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGlobalKey_1<T extends _i2.State<_i2.StatefulWidget>>
    extends _i1.SmartFake implements _i2.GlobalKey<T> {
  _FakeGlobalKey_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTextEditingController_2 extends _i1.SmartFake
    implements _i2.TextEditingController {
  _FakeTextEditingController_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginViewModel extends _i1.Mock implements _i3.LoginViewModel {
  @override
  _i2.BuildContext get context => (super.noSuchMethod(
        Invocation.getter(#context),
        returnValue: _FakeBuildContext_0(
          this,
          Invocation.getter(#context),
        ),
        returnValueForMissingStub: _FakeBuildContext_0(
          this,
          Invocation.getter(#context),
        ),
      ) as _i2.BuildContext);

  @override
  bool get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  set isLoading(bool? _isLoading) => super.noSuchMethod(
        Invocation.setter(
          #isLoading,
          _isLoading,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.GlobalKey<_i2.FormState> get formKey => (super.noSuchMethod(
        Invocation.getter(#formKey),
        returnValue: _FakeGlobalKey_1<_i2.FormState>(
          this,
          Invocation.getter(#formKey),
        ),
        returnValueForMissingStub: _FakeGlobalKey_1<_i2.FormState>(
          this,
          Invocation.getter(#formKey),
        ),
      ) as _i2.GlobalKey<_i2.FormState>);

  @override
  _i2.TextEditingController get emailController => (super.noSuchMethod(
        Invocation.getter(#emailController),
        returnValue: _FakeTextEditingController_2(
          this,
          Invocation.getter(#emailController),
        ),
        returnValueForMissingStub: _FakeTextEditingController_2(
          this,
          Invocation.getter(#emailController),
        ),
      ) as _i2.TextEditingController);

  @override
  _i2.TextEditingController get passwordController => (super.noSuchMethod(
        Invocation.getter(#passwordController),
        returnValue: _FakeTextEditingController_2(
          this,
          Invocation.getter(#passwordController),
        ),
        returnValueForMissingStub: _FakeTextEditingController_2(
          this,
          Invocation.getter(#passwordController),
        ),
      ) as _i2.TextEditingController);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i4.Future<void> loginWithEmailAndPassword() => (super.noSuchMethod(
        Invocation.method(
          #loginWithEmailAndPassword,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> validateToken() => (super.noSuchMethod(
        Invocation.method(
          #validateToken,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<bool> loginWithDeviceAuth() => (super.noSuchMethod(
        Invocation.method(
          #loginWithDeviceAuth,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  void goToHome() => super.noSuchMethod(
        Invocation.method(
          #goToHome,
          [],
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
