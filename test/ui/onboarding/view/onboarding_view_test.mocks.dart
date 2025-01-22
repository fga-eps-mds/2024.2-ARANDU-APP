// Mocks generated by Mockito 5.4.4 from annotations
// in aranduapp/test/ui/onboarding/view/onboarding_view_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:aranduapp/ui/onboarding/viewmodel/onboarding_viewmodel.dart'
    as _i3;
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

class _FakePageController_0 extends _i1.SmartFake
    implements _i2.PageController {
  _FakePageController_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [OnboardingViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockOnboardingViewModel extends _i1.Mock
    implements _i3.OnboardingViewModel {
  @override
  _i2.PageController get pageController => (super.noSuchMethod(
        Invocation.getter(#pageController),
        returnValue: _FakePageController_0(
          this,
          Invocation.getter(#pageController),
        ),
        returnValueForMissingStub: _FakePageController_0(
          this,
          Invocation.getter(#pageController),
        ),
      ) as _i2.PageController);

  @override
  int get currentPage => (super.noSuchMethod(
        Invocation.getter(#currentPage),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  set currentPage(int? _currentPage) => super.noSuchMethod(
        Invocation.setter(
          #currentPage,
          _currentPage,
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
  void goToNextPage() => super.noSuchMethod(
        Invocation.method(
          #goToNextPage,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void updateCurrentPage(int? page) => super.noSuchMethod(
        Invocation.method(
          #updateCurrentPage,
          [page],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void navigateToNextPage(_i2.BuildContext? context) => super.noSuchMethod(
        Invocation.method(
          #navigateToNextPage,
          [context],
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
