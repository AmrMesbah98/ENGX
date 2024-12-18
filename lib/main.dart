import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:asec_application/bloc/CV/cv_control_cubit.dart';
import 'package:asec_application/bloc/Free_Courses/free_courses_cubit.dart';
import 'package:asec_application/bloc/profile/profile_cubit.dart';
import 'package:asec_application/presentation/DashBoard_Student/presentation/manger/dash_board_student_cubit.dart';
import 'package:asec_application/presentation/Download/presentation/manager/download_cubit.dart';
import 'package:asec_application/presentation/Work/presentation/manager/get_work_cubit.dart';
import 'package:asec_application/presentation/cources%20Video/presentation/manager/get_courses_cubit.dart';
import 'package:asec_application/presentation/new_Auth/new_login.dart';
import 'package:asec_application/presentation/new_Auth/presentation/manager/id_signin_with_google_cubit.dart';
import 'package:asec_application/presentation/onboarding/onboarding_view.dart';
import 'package:asec_application/presentation/shorts/presentation/manager/shorts_cubit.dart';
import 'package:asec_application/presentation/student_degree/presentation/manager/student_degree_cubit.dart';
import 'package:asec_application/shared/network/dio_helper.dart';
import 'package:asec_application/shared_prefrance/shard_prefrance.dart';
import 'package:asec_application/theme/lets_theme.dart';
import 'package:asec_application/zoomVideo/presentation/manager/zoom_meeting_cubit.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Constant/constant.dart';
import 'api_service/api_service.dart';
import 'bloc/Auth/auth_cubit.dart';
import 'bloc/Certification/certification_cubit.dart';
import 'bloc/DataId/id_data_cubit.dart';
import 'bloc/Get_Partners/partners_cubit.dart';
import 'bloc/Get_Sponser/get_sponser_cubit.dart';
import 'bloc/PodCast/pod_cast_cubit.dart';
import 'bloc/Support/supoort_data_cubit.dart';
import 'bloc/delete_Doc/delete_doc_cubit.dart';
import 'bloc/get_courses/courses_cubit.dart';
import 'bloc/get_information/user_information_cubit.dart';
import 'bloc/get_instructor/get_instructor_cubit.dart';
import 'bloc/get_package/get_package_cubit.dart';
import 'bloc/get_project/project_cubit.dart';
import 'bloc/get_quiz/quiz_cubit.dart';
import 'bloc/get_topFive/top_five_cubit.dart';
import 'bloc/loclization/bloc_cubit.dart';
import 'bloc/news/news_cubit.dart';
import 'bloc/order/order_cubit.dart';
import 'bloc/person_FCM/individual_notification_cubit.dart';
import 'bloc/post/post_cubit.dart';
import 'bloc/publicNotification/publicnotification_cubit.dart';
import 'bloc/updateCode/code_update_cubit.dart';
import 'bloc_observer/bloc_observer.dart';
import 'firebase_options.dart';
import 'firebase_services/firestore_service.dart';
import 'generated/l10n.dart';
import 'master.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeMode? themeMode = await LetsTheme.getThemeMode();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  MobileAds.instance.initialize();
  await CacheHelper.init();

  /// Initialize Ip Address
//  var ipAddress = IpAddress(type: RequestType.json);

  /// Get the IpAddress based on requestType.
  // dynamic data = await ipAddress.getIpAddress();
  // print(" ip is ${data.toString()}");

  // final _mobileDeviceIdentifier = MobileDeviceIdentifier().getDeviceId();
  // print(" idMAC is $_mobileDeviceIdentifier");

  /*
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness:Brightness.light // status bar color
  ));

   */
  Bloc.observer = MyBlocObserver();
  await DioHelperPayment.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.requestPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  var onBoarding = CacheHelper.getData(key: 'onBoarding');

  var languagee = CacheHelper.getData(key: "languages");
  debugPrint('lang data is >>>>>$languagee');
  id = CacheHelper.getData(key: 'uId');
  constantvar.uid = CacheHelper.getData(key: "uId");
  idGoogle = CacheHelper.getData(key: 'uIdGoogle');
  constantvar.mainShow = CacheHelper.getData(key: "showLast");
  print("show last is ======>>>>>>> ${constantvar.mainShow}");
  debugPrint('id data is >>>>>$id');
  debugPrint('id Google >>>>>$idGoogle');
  debugPrint('on boarding data is >>>>>$onBoarding');
  Widget widget;

  // id = CacheHelper.getData(key: 'uId');
  // debugPrint('on boarding data is >>>>>$onBoarding');
  // debugPrint('id data is >>>>>$id');

  if (onBoarding != null) {
    if (id != null || idGoogle != null) {
      widget = const Master();
    } else {
      //widget = const LoginViewApp();
      widget = const NewLoginPage();
    }
  } else {
    widget = OnBoardingViewApp();
  }

  //for adaptive_theme
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(
    MyApp(themeMode,
        startWidget: widget,
        lang: languagee,
        //for adaptive_theme
        savedThemeMode: savedThemeMode),
  );
}

class MyApp extends StatelessWidget {
  //for adaptive_theme
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp(this.themeMode,
      {super.key, required this.startWidget, this.lang, this.savedThemeMode});

  final Widget startWidget;
  final String? lang;
  final ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    constantvar.lang = lang ?? "en";

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => blockManagement()..buildSwitchLang()),
        BlocProvider(
            create: (context) => CodeUpdateCubit(FireStoreService())
              ..getCodeUpdateFunction()
              ..codeUpdateModel),

        BlocProvider(
            create: (context) =>
                SupoortDataCubit(FireStoreService())..getSupportData()),
        BlocProvider(
            create: (context) => OrderCubit(FireStoreService())..getOrder()),
        BlocProvider(
            create: (context) =>
                GetTopFiveCubit(FireStoreService())..getTopFiveSnap()),

        BlocProvider(
            create: (context) => CertificationCubit(FireStoreService())
              ..getCertificate()
              ..getCertificateAccpted()),

        BlocProvider(
            create: (context) =>
                GetCoursesCubit(FireStoreService())..getCourses()),

        BlocProvider(
            create: (context) =>
                DownloadCubit(FireStoreService())..getFileData()),

        BlocProvider(
            create: (context) => DashBoardStudentCubit(FireStoreService())
              ..getWeakCollection()
              ..getDashBoardCollection()
              ..getNameInstructor()
              ..getDashBoardCollectionReview()),

        BlocProvider(
            create: (context) =>
                StudentDegreeCubit(FireStoreService())..getStudentDegree()),

        BlocProvider(
            create: (context) =>
                FreeCoursesCubit(FireStoreService())..getFreeCoursesVideo()),
        BlocProvider(
            create: (context) =>
                ProjectCubit(FireStoreService())..getProject()),

        BlocProvider(
            create: (context) => NewsCubit(FireStoreService())..getNews()),

        BlocProvider(
            create: (context) =>
                PodCastCubit(FireStoreService())..getPodCast()),

        BlocProvider(
            create: (context) =>
                GetInstructorCubit(FireStoreService())..geInstructor()),

        BlocProvider(
            create: (context) =>
                GetCoursesVideoCubit(FireStoreService())..getVideosCourses()),

        BlocProvider(
            create: (context) =>
                UserAppInformationCubit(FireStoreService())..getInformation()),
        BlocProvider(create: (context) => DeleteDocCubit(FireStoreService())),
        BlocProvider(
            create: (context) =>
                GetPackageCubit(FireStoreService())..getPackdgeFunction()),

        BlocProvider(
            create: (context) =>
                QuizCubit(FireStoreService())..getQuizFunction()),

        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
            create: (context) => PostCubit(FireStoreService())
              ..getPostFunction()
              ..getFinalPostFunction()),
        BlocProvider(
            create: (context) =>
                PartnersCubit(FireStoreService())..getPartner()),
        BlocProvider(
            create: (context) =>
                GetSponserCubit(FireStoreService())..getSponser()),
        BlocProvider(
            create: (context) => CvControlCubit(FireStoreService())
              ..getCv()
              ..getMyCv),
        // ..getCv()
        BlocProvider(
            create: (context) =>
                IndividualNotificationCubit(ApiService(DioHelperPayment.dio))),
        BlocProvider(
            create: (context) => PublicNotificationCubit(
                ApiService(
                  DioHelperPayment.dio,
                ),
                FireStoreService())
              ..getFcm()),
        //get zoomMeeting
        BlocProvider(
            create: (context) => ZoomMeetingCubit(FireStoreService())
              ..getZoomMeetingVideo()
              ..getQuizDegreeFunction()),

        // get id
        BlocProvider(
            create: (context) => IdDataCubit(FireStoreService())..getId()),

        //get works
        BlocProvider(
            create: (context) =>
                GetWorkCubit(FireStoreService())..getAllJobs()),

        //get id sign in with google
        BlocProvider(
            create: (context) =>
                IdSigninWithGoogleCubit(FireStoreService())..getId()),

        BlocProvider(
            create: (context) => ProfileCubit(FireStoreService())
              ..getUserData()
              ..getUsersMsg()
              ..getInformation()),

        BlocProvider(
            create: (context) =>
                ShortsCubit(FireStoreService())..getShortsVideos()),
      ],
      child: BlocConsumer<blockManagement, cubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          // SystemChrome.setPreferredOrientations([
          //   DeviceOrientation.portraitUp,
          //   DeviceOrientation.portraitDown,
          // ]);

          // comment here
          return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              child: LetsTheme(
                  light: ThemeData.light(),
                  dark: ThemeData.dark(),
                  initialMode: themeMode ?? ThemeMode.light,
                  builder: (ThemeData light, ThemeData dark) {
                    return AdaptiveTheme(
                      light: ThemeData(
                        useMaterial3: true,
                        brightness: Brightness.light,
                        colorSchemeSeed: Colors.blue,
                        scaffoldBackgroundColor: Colors.white,
                      ),
                      dark: ThemeData(
                        useMaterial3: true,
                        brightness: Brightness.dark,
                        colorSchemeSeed: Colors.blue,
                        scaffoldBackgroundColor: Color(0xff323232),
                      ),
                      initial: savedThemeMode ?? AdaptiveThemeMode.light,
                      builder: (theme, darkTheme) => MaterialApp(
                        theme: theme,
                        darkTheme: darkTheme,
                        /*
                        theme: ThemeData(
                            colorScheme:
                                ColorScheme.fromSeed(seedColor: Colors.white),
                            useMaterial3: false,
                            pageTransitionsTheme:
                                const PageTransitionsTheme(builders: {
                              TargetPlatform.android:
                                  FadeUpwardsPageTransitionsBuilder(),
                            }),
                            fontFamily: 'Alexandria'),

                         */
                        locale: Locale(constantvar.lang),
                        localizationsDelegates: const [
                          S.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          CountryLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                        ],
                        supportedLocales: S.delegate.supportedLocales,
                        debugShowCheckedModeBanner: false,
                        home: startWidget,
                        //home: NewLoginPage(),
                        navigatorKey: navigatorKey,
                      ),
                    );
                  }));
        },
      ),
    );
  }
}
