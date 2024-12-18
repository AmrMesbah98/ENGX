
import 'package:asec_application/bloc/get_instructor/get_instructor_cubit.dart';
import 'package:asec_application/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

import '../../Dashbord.dart';
import '../../master.dart';
import '../Instructor/Instructor.dart';
import '../courses/Method_Payment/Support_system.dart';
import '../courses/See_more_Courses.dart';
import '../courses/price/category_price.dart';
import '../homepage/homepage.dart';
import '../login/intro_chosse.dart';
import '../login/login_view.dart';
import '../project/order_project.dart';
import '../project/project.dart';
import '../whatsUp/whatsuo_Page.dart';
import '../onboarding/onboarding_view.dart';
import '../register/register_view.dart';



class Routes {
  static const String splashRoute = "/";
  static const String intro = "/intro";
  static const String loginRoute = "/login";
  static const String master = "/Master";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String homePageRoute = "/homePage";
  static const String coursesPage = "/CoursesPage";
  static const String projectPage = "/Projectpage";
  static const String allProjectPage = "/AllprojectPage";
  static const String monitorPage = "/MonitorPage";
  static const String whatsup = "/WhatsWp";
  static const String order = "/Order";
  static const String dashBorad = "/DashBorad";
  static const String support = "/Support";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.intro:
        return MaterialPageRoute(builder: (_) => const Intro());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginViewApp());
        case Routes.master:
        return MaterialPageRoute(builder: (_) => const Master());
      case Routes.support:
        return MaterialPageRoute(builder: (_) => const UserProfile());
        case Routes.homePageRoute:
        return MaterialPageRoute(builder: (_) =>  MasterHomePagee());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) =>  OnBoardingViewApp());
        case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.whatsup:
        return MaterialPageRoute(builder: (_) =>  WhatsUp());
        case Routes.coursesPage:
        return MaterialPageRoute(builder: (_) => const ShowAllCourses());
        case Routes.dashBorad:
        return MaterialPageRoute(builder: (_) =>  DashBorad());
        case Routes.projectPage:
        return MaterialPageRoute(builder: (_) =>  ShowAllProject());
      case Routes.order:
        return MaterialPageRoute(builder: (_) =>  OrderProject());
        case Routes.monitorPage:
        return MaterialPageRoute(builder: (_) =>  const AllInstructor());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
