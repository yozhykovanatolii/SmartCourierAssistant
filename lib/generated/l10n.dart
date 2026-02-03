// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Fill information about yourself below`
  String get fillInformationAboutYourselfBelow {
    return Intl.message(
      'Fill information about yourself below',
      name: 'fillInformationAboutYourselfBelow',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your full name`
  String get enterYourFullName {
    return Intl.message(
      'Enter your full name',
      name: 'enterYourFullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterYourPhoneNumber {
    return Intl.message(
      'Enter your phone number',
      name: 'enterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Success registration`
  String get successRegistration {
    return Intl.message(
      'Success registration',
      name: 'successRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Success authorization`
  String get successAuthorization {
    return Intl.message(
      'Success authorization',
      name: 'successAuthorization',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Hi! Welcome back, you've been missed`
  String get welcomeBack {
    return Intl.message(
      'Hi! Welcome back, you\'ve been missed',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message('Languages', name: 'languages', desc: '', args: []);
  }

  /// `Select the language that is most convenient for you to use the application in.`
  String get selectTheLanguageThatIsMostConvenientForYouTo {
    return Intl.message(
      'Select the language that is most convenient for you to use the application in.',
      name: 'selectTheLanguageThatIsMostConvenientForYouTo',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we will send you a link to reset your password`
  String get enterYourEmailAddressAndWeWillSendYouA {
    return Intl.message(
      'Enter your email address and we will send you a link to reset your password',
      name: 'enterYourEmailAddressAndWeWillSendYouA',
      desc: '',
      args: [],
    );
  }

  /// `If an account with this email exists, you will receive a password reset email.`
  String get ifAnAccountWithThisEmailExistsYouWillReceive {
    return Intl.message(
      'If an account with this email exists, you will receive a password reset email.',
      name: 'ifAnAccountWithThisEmailExistsYouWillReceive',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Success updating profile`
  String get successUpdatingProfile {
    return Intl.message(
      'Success updating profile',
      name: 'successUpdatingProfile',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message('Full name', name: 'fullName', desc: '', args: []);
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get editProfile {
    return Intl.message(
      'Edit profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Success authorization with Google`
  String get successAuthorizationWithGoogle {
    return Intl.message(
      'Success authorization with Google',
      name: 'successAuthorizationWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `📞 Call`
  String get call {
    return Intl.message('📞 Call', name: 'call', desc: '', args: []);
  }

  /// `💬 Chat`
  String get chat {
    return Intl.message('💬 Chat', name: 'chat', desc: '', args: []);
  }

  /// `✅ Done`
  String get done {
    return Intl.message('✅ Done', name: 'done', desc: '', args: []);
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `Optimize route`
  String get optimizeRoute {
    return Intl.message(
      'Optimize route',
      name: 'optimizeRoute',
      desc: '',
      args: [],
    );
  }

  /// `Your profile`
  String get yourProfile {
    return Intl.message(
      'Your profile',
      name: 'yourProfile',
      desc: '',
      args: [],
    );
  }

  /// `My routes`
  String get myRoutes {
    return Intl.message('My routes', name: 'myRoutes', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Yes, Logout`
  String get yesLogout {
    return Intl.message('Yes, Logout', name: 'yesLogout', desc: '', args: []);
  }

  /// `Are you sure you want to log out?`
  String get areYouSureYouWantToLogOut {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'areYouSureYouWantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Success confirming a delivery`
  String get successConfirmingADelivery {
    return Intl.message(
      'Success confirming a delivery',
      name: 'successConfirmingADelivery',
      desc: '',
      args: [],
    );
  }

  /// `Comment📝`
  String get comment {
    return Intl.message('Comment📝', name: 'comment', desc: '', args: []);
  }

  /// `Photo📸`
  String get photo {
    return Intl.message('Photo📸', name: 'photo', desc: '', args: []);
  }

  /// `Take several photos of your order and select from the gallery.`
  String get takeSeveralPhotosOfYourOrderAndSelectFromThe {
    return Intl.message(
      'Take several photos of your order and select from the gallery.',
      name: 'takeSeveralPhotosOfYourOrderAndSelectFromThe',
      desc: '',
      args: [],
    );
  }

  /// `Enter comment...`
  String get enterComment {
    return Intl.message(
      'Enter comment...',
      name: 'enterComment',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Proof of delivery`
  String get proofOfDelivery {
    return Intl.message(
      'Proof of delivery',
      name: 'proofOfDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Success saving an order`
  String get successSavingAnOrder {
    return Intl.message(
      'Success saving an order',
      name: 'successSavingAnOrder',
      desc: '',
      args: [],
    );
  }

  /// `Address🏠`
  String get address {
    return Intl.message('Address🏠', name: 'address', desc: '', args: []);
  }

  /// `Client👤`
  String get client {
    return Intl.message('Client👤', name: 'client', desc: '', args: []);
  }

  /// `Contact Phone📱`
  String get contactPhone {
    return Intl.message(
      'Contact Phone📱',
      name: 'contactPhone',
      desc: '',
      args: [],
    );
  }

  /// `Category🗂️`
  String get category {
    return Intl.message('Category🗂️', name: 'category', desc: '', args: []);
  }

  /// `Delivery by⏰`
  String get deliveryBy {
    return Intl.message('Delivery by⏰', name: 'deliveryBy', desc: '', args: []);
  }

  /// `Enter address of order`
  String get enterAddressOfOrder {
    return Intl.message(
      'Enter address of order',
      name: 'enterAddressOfOrder',
      desc: '',
      args: [],
    );
  }

  /// `Enter client full name`
  String get enterClientFullName {
    return Intl.message(
      'Enter client full name',
      name: 'enterClientFullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter client phone number`
  String get enterClientPhoneNumber {
    return Intl.message(
      'Enter client phone number',
      name: 'enterClientPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Save order`
  String get saveOrder {
    return Intl.message('Save order', name: 'saveOrder', desc: '', args: []);
  }

  /// `Deleting order`
  String get deletingOrder {
    return Intl.message(
      'Deleting order',
      name: 'deletingOrder',
      desc: '',
      args: [],
    );
  }

  /// `You're going to delete an order. Are you sure?`
  String get youreGoingToDeleteAnOrderAreYouSure {
    return Intl.message(
      'You\'re going to delete an order. Are you sure?',
      name: 'youreGoingToDeleteAnOrderAreYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Route Detail`
  String get routeDetail {
    return Intl.message(
      'Route Detail',
      name: 'routeDetail',
      desc: '',
      args: [],
    );
  }

  /// `Order #{order.id}`
  String get orderOrderid {
    return Intl.message(
      'Order #{order.id}',
      name: 'orderOrderid',
      desc: '',
      args: [],
    );
  }

  /// `No, Keep It.`
  String get noKeepIt {
    return Intl.message('No, Keep It.', name: 'noKeepIt', desc: '', args: []);
  }

  /// `No, Cancel It.`
  String get noCancelIt {
    return Intl.message(
      'No, Cancel It.',
      name: 'noCancelIt',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Delete It!`
  String get yesDeleteIt {
    return Intl.message(
      'Yes, Delete It!',
      name: 'yesDeleteIt',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Confirm It!`
  String get yesConfirmIt {
    return Intl.message(
      'Yes, Confirm It!',
      name: 'yesConfirmIt',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
