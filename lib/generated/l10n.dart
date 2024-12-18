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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `SEE THE BEST COURSE #1`
  String get onBoardingTitle1 {
    return Intl.message(
      'SEE THE BEST COURSE #1',
      name: 'onBoardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `SEE THE BEST COURSE #2`
  String get onBoardingTitle2 {
    return Intl.message(
      'SEE THE BEST COURSE #2',
      name: 'onBoardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `SEE THE BEST COURSE #3`
  String get onBoardingTitle3 {
    return Intl.message(
      'SEE THE BEST COURSE #3',
      name: 'onBoardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `SEE THE BEST COURSE #4`
  String get onBoardingTitle4 {
    return Intl.message(
      'SEE THE BEST COURSE #4',
      name: 'onBoardingTitle4',
      desc: '',
      args: [],
    );
  }

  /// `Tut app is an awesome flutter application using clean architecture #1`
  String get onBoardingSubTitle1 {
    return Intl.message(
      'Tut app is an awesome flutter application using clean architecture #1',
      name: 'onBoardingSubTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Tut app is an awesome flutter application using clean architecture #2`
  String get onBoardingSubTitle2 {
    return Intl.message(
      'Tut app is an awesome flutter application using clean architecture #2',
      name: 'onBoardingSubTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Tut app is an awesome flutter application using clean architecture #3`
  String get onBoardingSubTitle3 {
    return Intl.message(
      'Tut app is an awesome flutter application using clean architecture #3',
      name: 'onBoardingSubTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get EmailFormlogin {
    return Intl.message(
      'Email',
      name: 'EmailFormlogin',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordFormlogin {
    return Intl.message(
      'Password',
      name: 'passwordFormlogin',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get Welcome {
    return Intl.message(
      'Welcome',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get SigninForm {
    return Intl.message(
      'Sign in',
      name: 'SigninForm',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get validateformtext {
    return Intl.message(
      'Please enter some text',
      name: 'validateformtext',
      desc: '',
      args: [],
    );
  }

  /// `Courses Video`
  String get courses {
    return Intl.message(
      'Courses Video',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Accpted Certification`
  String get AccptedCertification {
    return Intl.message(
      'Accpted Certification',
      name: 'AccptedCertification',
      desc: '',
      args: [],
    );
  }

  /// `PodCast`
  String get BroadCast {
    return Intl.message(
      'PodCast',
      name: 'BroadCast',
      desc: '',
      args: [],
    );
  }

  /// `this account not register please make sure to your information`
  String get ErrorMsgLogin {
    return Intl.message(
      'this account not register please make sure to your information',
      name: 'ErrorMsgLogin',
      desc: '',
      args: [],
    );
  }

  /// `you make Error`
  String get ErrortitleLogin {
    return Intl.message(
      'you make Error',
      name: 'ErrortitleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to ASEC`
  String get SuccessTitleLogin {
    return Intl.message(
      'Welcome to ASEC',
      name: 'SuccessTitleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Emailregister {
    return Intl.message(
      'Email',
      name: 'Emailregister',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordFormRegister {
    return Intl.message(
      'Password',
      name: 'passwordFormRegister',
      desc: '',
      args: [],
    );
  }

  /// `ConfirmPassword`
  String get ConfirmPasswordRegister {
    return Intl.message(
      'ConfirmPassword',
      name: 'ConfirmPasswordRegister',
      desc: '',
      args: [],
    );
  }

  /// `Wait For New Update`
  String get coursesUpdate {
    return Intl.message(
      'Wait For New Update',
      name: 'coursesUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Don't Have An Account?`
  String get RegisterTextforaccount {
    return Intl.message(
      'Don\'t Have An Account?',
      name: 'RegisterTextforaccount',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get Registerforaccount {
    return Intl.message(
      'Signup',
      name: 'Registerforaccount',
      desc: '',
      args: [],
    );
  }

  /// `if you register you will gain some features that can make you more unique  `
  String get titileforRegister {
    return Intl.message(
      'if you register you will gain some features that can make you more unique  ',
      name: 'titileforRegister',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to ASEC`
  String get SuccesstitleRegister {
    return Intl.message(
      'Welcome to ASEC',
      name: 'SuccesstitleRegister',
      desc: '',
      args: [],
    );
  }

  /// `Success Registration`
  String get SuccessMsgRegister {
    return Intl.message(
      'Success Registration',
      name: 'SuccessMsgRegister',
      desc: '',
      args: [],
    );
  }

  /// `Sorry`
  String get ErrortitleRegister {
    return Intl.message(
      'Sorry',
      name: 'ErrortitleRegister',
      desc: '',
      args: [],
    );
  }

  /// `You have error`
  String get ErrorMsgRegister {
    return Intl.message(
      'You have error',
      name: 'ErrorMsgRegister',
      desc: '',
      args: [],
    );
  }

  /// `Login here`
  String get SwapLogin {
    return Intl.message(
      'Login here',
      name: 'SwapLogin',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get Back {
    return Intl.message(
      'Back',
      name: 'Back',
      desc: '',
      args: [],
    );
  }

  /// `Your order`
  String get yourOrderButton {
    return Intl.message(
      'Your order',
      name: 'yourOrderButton',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get titleOfCourses {
    return Intl.message(
      'Courses',
      name: 'titleOfCourses',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get titleOfProject {
    return Intl.message(
      'Projects',
      name: 'titleOfProject',
      desc: '',
      args: [],
    );
  }

  /// `Technical Support`
  String get titleOfMonitor {
    return Intl.message(
      'Technical Support',
      name: 'titleOfMonitor',
      desc: '',
      args: [],
    );
  }

  /// `Package Courses`
  String get packageCourses {
    return Intl.message(
      'Package Courses',
      name: 'packageCourses',
      desc: '',
      args: [],
    );
  }

  /// `Package Courses`
  String get titleOfPackage {
    return Intl.message(
      'Package Courses',
      name: 'titleOfPackage',
      desc: '',
      args: [],
    );
  }

  /// `Top Five`
  String get topFive {
    return Intl.message(
      'Top Five',
      name: 'topFive',
      desc: '',
      args: [],
    );
  }

  /// `DashBord`
  String get message {
    return Intl.message(
      'DashBord',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `INFO`
  String get info {
    return Intl.message(
      'INFO',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Create Post`
  String get createpost {
    return Intl.message(
      'Create Post',
      name: 'createpost',
      desc: '',
      args: [],
    );
  }

  /// `Review Post`
  String get reviewPost {
    return Intl.message(
      'Review Post',
      name: 'reviewPost',
      desc: '',
      args: [],
    );
  }

  /// `privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `See More`
  String get SeeMore {
    return Intl.message(
      'See More',
      name: 'SeeMore',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get AllCourses {
    return Intl.message(
      'Courses',
      name: 'AllCourses',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get AllProject {
    return Intl.message(
      'Projects',
      name: 'AllProject',
      desc: '',
      args: [],
    );
  }

  /// `Instructor`
  String get AllInstructor {
    return Intl.message(
      'Instructor',
      name: 'AllInstructor',
      desc: '',
      args: [],
    );
  }

  /// `What You’ll  learn`
  String get CouresDescrption {
    return Intl.message(
      'What You’ll  learn',
      name: 'CouresDescrption',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get ShowMore {
    return Intl.message(
      'Show more',
      name: 'ShowMore',
      desc: '',
      args: [],
    );
  }

  /// `Rate this`
  String get RateThis {
    return Intl.message(
      'Rate this',
      name: 'RateThis',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get Price {
    return Intl.message(
      'Price',
      name: 'Price',
      desc: '',
      args: [],
    );
  }

  /// `Your order`
  String get yourOrder {
    return Intl.message(
      'Your order',
      name: 'yourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
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

  /// `Project type`
  String get projectType {
    return Intl.message(
      'Project type',
      name: 'projectType',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get Send {
    return Intl.message(
      'Send',
      name: 'Send',
      desc: '',
      args: [],
    );
  }

  /// `order success`
  String get orderSuccess {
    return Intl.message(
      'order success',
      name: 'orderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to  ASEC`
  String get orderSuccessTitle {
    return Intl.message(
      'Welcome to  ASEC',
      name: 'orderSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Price Category`
  String get PriceCategory {
    return Intl.message(
      'Price Category',
      name: 'PriceCategory',
      desc: '',
      args: [],
    );
  }

  /// `Open System`
  String get Open {
    return Intl.message(
      'Open System',
      name: 'Open',
      desc: '',
      args: [],
    );
  }

  /// `Support System`
  String get Support {
    return Intl.message(
      'Support System',
      name: 'Support',
      desc: '',
      args: [],
    );
  }

  /// `Saving System`
  String get Saving {
    return Intl.message(
      'Saving System',
      name: 'Saving',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Why Need Support`
  String get whyNeedSupport {
    return Intl.message(
      'Why Need Support',
      name: 'whyNeedSupport',
      desc: '',
      args: [],
    );
  }

  /// `Egypt`
  String get Egypt {
    return Intl.message(
      'Egypt',
      name: 'Egypt',
      desc: '',
      args: [],
    );
  }

  /// `Lebanon`
  String get lebanon {
    return Intl.message(
      'Lebanon',
      name: 'lebanon',
      desc: '',
      args: [],
    );
  }

  /// `Sudan`
  String get sudan {
    return Intl.message(
      'Sudan',
      name: 'sudan',
      desc: '',
      args: [],
    );
  }

  /// `Syria`
  String get syria {
    return Intl.message(
      'Syria',
      name: 'syria',
      desc: '',
      args: [],
    );
  }

  /// `Yemen`
  String get yemen {
    return Intl.message(
      'Yemen',
      name: 'yemen',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get uploadPhoto {
    return Intl.message(
      'Upload Photo',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Death Certificate Father`
  String get DeathCertificate {
    return Intl.message(
      'Death Certificate Father',
      name: 'DeathCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Order Project`
  String get orderProject {
    return Intl.message(
      'Order Project',
      name: 'orderProject',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get count {
    return Intl.message(
      'Country',
      name: 'count',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message(
      'Contact us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `pay by Visa`
  String get joinUs {
    return Intl.message(
      'pay by Visa',
      name: 'joinUs',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Become an Instructor`
  String get BecomeAnInstructor {
    return Intl.message(
      'Become an Instructor',
      name: 'BecomeAnInstructor',
      desc: '',
      args: [],
    );
  }

  /// `Hey! Make sure you sign in to can complete your process`
  String get alertContent {
    return Intl.message(
      'Hey! Make sure you sign in to can complete your process',
      name: 'alertContent',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastname {
    return Intl.message(
      'Last Name',
      name: 'lastname',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstname {
    return Intl.message(
      'First Name',
      name: 'firstname',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get conttinue {
    return Intl.message(
      'Continue',
      name: 'conttinue',
      desc: '',
      args: [],
    );
  }

  /// `login`
  String get login {
    return Intl.message(
      'login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Welcome in ASEC`
  String get welcomeInASEC {
    return Intl.message(
      'Welcome in ASEC',
      name: 'welcomeInASEC',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Open Chat`
  String get OpenChat {
    return Intl.message(
      'Open Chat',
      name: 'OpenChat',
      desc: '',
      args: [],
    );
  }

  /// `DashBoard`
  String get DashBoard {
    return Intl.message(
      'DashBoard',
      name: 'DashBoard',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get Project {
    return Intl.message(
      'Project',
      name: 'Project',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get Courses {
    return Intl.message(
      'Courses',
      name: 'Courses',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `By`
  String get By {
    return Intl.message(
      'By',
      name: 'By',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Developer Team`
  String get DeveloperTeam {
    return Intl.message(
      'Developer Team',
      name: 'DeveloperTeam',
      desc: '',
      args: [],
    );
  }

  /// `clarification Page`
  String get clarificationPage {
    return Intl.message(
      'clarification Page',
      name: 'clarificationPage',
      desc: '',
      args: [],
    );
  }

  /// `pay by WhatsUp`
  String get paywhatsup {
    return Intl.message(
      'pay by WhatsUp',
      name: 'paywhatsup',
      desc: '',
      args: [],
    );
  }

  /// `Technical Support Application`
  String get TechnicalSupportApplication {
    return Intl.message(
      'Technical Support Application',
      name: 'TechnicalSupportApplication',
      desc: '',
      args: [],
    );
  }

  /// `whatsapp`
  String get whatsapp {
    return Intl.message(
      'whatsapp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `CV`
  String get CV {
    return Intl.message(
      'CV',
      name: 'CV',
      desc: '',
      args: [],
    );
  }

  /// `The Egyptian pound is dealt with inside Egypt, but the dollar is dealt with outside Egypt`
  String get priceDes {
    return Intl.message(
      'The Egyptian pound is dealt with inside Egypt, but the dollar is dealt with outside Egypt',
      name: 'priceDes',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait`
  String get attention {
    return Intl.message(
      'Please Wait',
      name: 'attention',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Comment`
  String get EnterYourComment {
    return Intl.message(
      'Enter Your Comment',
      name: 'EnterYourComment',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Comment`
  String get PleaseEnterYourComment {
    return Intl.message(
      'Please Enter Your Comment',
      name: 'PleaseEnterYourComment',
      desc: '',
      args: [],
    );
  }

  /// `Review This Instructor`
  String get ReviewThisInstructor {
    return Intl.message(
      'Review This Instructor',
      name: 'ReviewThisInstructor',
      desc: '',
      args: [],
    );
  }

  /// `Show Reviews`
  String get ShowReviews {
    return Intl.message(
      'Show Reviews',
      name: 'ShowReviews',
      desc: '',
      args: [],
    );
  }

  /// `Review Page`
  String get ReviewPage {
    return Intl.message(
      'Review Page',
      name: 'ReviewPage',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get Rate {
    return Intl.message(
      'Rate',
      name: 'Rate',
      desc: '',
      args: [],
    );
  }

  /// `All Comments`
  String get AllComments {
    return Intl.message(
      'All Comments',
      name: 'AllComments',
      desc: '',
      args: [],
    );
  }

  /// `Zoom Meeting Videos`
  String get ZoomVideo {
    return Intl.message(
      'Zoom Meeting Videos',
      name: 'ZoomVideo',
      desc: '',
      args: [],
    );
  }

  /// `Wait For New Update`
  String get ZoomUpdate {
    return Intl.message(
      'Wait For New Update',
      name: 'ZoomUpdate',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
