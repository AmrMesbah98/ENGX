import 'package:asec_application/zoomVideo/data/zoomMeetingModel.dart';

import '../model/CV_Model.dart';
import '../model/Certification_model.dart';
import '../model/Top_FIveModel.dart';
import '../model/courses_model.dart';
import '../model/free_courses_model/free_courses_model.dart';
import '../model/instructor_model.dart';
import '../model/package_courses.dart';
import '../presentation/Work/data/inner_request_model.dart';

String? id;
String? idGoogle;
bool _switchValue = true;

class constantvar {
  static String? uid;
  static String? coder;
  static String? reviewScreenInstructor;
  static String? coderDash;
  static String? uidMsg;
  static bool showState = false;
  static dynamic mainShow = false;
  static bool changestate = true;
  static String lang = 'en';
  static String paymentPrice = '';
  static String halfPaymentPrice = '';
  static String packageCourses = '';
  static String packageCoursesHalf = '';
  static String Uid = "all";
  static dynamic total;
  static String? idCategory;
  static String? idZoomVideoCategory;
  static String? idWorkCollection;
  static String? idRequestWorkCollection;
  static String? idResponseWorkCollection;
  static String? idCategoryQuiz;
  static String? idFreeCoursesCategory;
  static String? titleCategoryQuiz;
  static List<ZoomMeetingModel>? categoryQuiz;

  static String selectTrack = "";
  static String selectspecializationItem = "Mechanical";

  static List<String> hobbiesList = [];

  static List<String> selectedItem = ["no choose"];

  static CertificationModel? certificationModel;
  static CvModel? cvModel;
  static InstructorModel? instructorModel;
  static TopFiveModel? topFiveModel;
  static CoursesModel? coursesModel;
  static FreeCoursesModel? freeCoursesModel;
  static PackageCourses? packageCoursesModel;

  static InnerRequestModel? innerRequestModel;
  static String? idWork;
  static dynamic innerResponseCounter;

  static String? emailUserOfGoogle;
  static String? idUserOfGoogle;

  static List<String> track = [
    "Mechanical",
    "Electricity",
    "Civil",
    "Architecture"
  ];

  static bool selectWork = false;

  static List<String> specializationList = [
    "Mechanical",
    "Electrical",
    "Civil",
    "Architecture"
  ];

  static List<String> positionCv = [
    "Trainee Engineer",
    "Site Engineer",
    "Design Engineer",
    "Technical Engineer",
  ];

//////////////////////////////////////////////

  static List<dynamic> zeroRate = [
    "0.0",
    "0",
    "0.1",
    "0.2",
    "0.3",
    "0.4",
    "0.5",
    "0.6",
    "0.7",
    "0.8",
    "0.9",
  ];

  static List<dynamic> oneRate = [
    "1.0",
    "1",
    "1.1",
    "1.2",
    "1.3",
    "1.4",
    "1.5",
    "1.6",
    "1.7",
    "1.8",
    "1.9",
  ];

  static List<dynamic> twoRate = [
    "2.0",
    "2",
    "2.1",
    "2.2",
    "2.3",
    "2.4",
    "2.5",
    "2.6",
    "2.7",
    "2.8",
    "2.9",
  ];

  static List<dynamic> threeRate = [
    "3.0",
    "3",
    "3.1",
    "3.2",
    "3.3",
    "3.4",
    "3.5",
    "3.6",
    "3.7",
    "3.8",
    "3.9",
  ];

  static List<dynamic> fourRate = [
    "4.0",
    "4",
    "4.1",
    "4.2",
    "4.3",
    "4.4",
    "4.5",
  ];

  static List<dynamic> fiveRate = ["4.6", "4.7", "4.8", "4.9", "5", "5.0"];

  static String selectPositionCv = "";

  static int totalLikeCv = 0;

  static double? rateUser;
  static double? calculateRating;
  static double? rateUserTopFive;
  static double? calculateRatingTopFive;
  static double? rateUserCourses;
  static double? calculateRatingCourses;
  static double? rateUserFreeCourses;
  static double? calculateRatingFreeCourses;
  static double? rateUserPackage;
  static double? calculateRatingPackage;

  static List<String> timeList = [
    "Full-Time",
    "Part-Time",
  ];

  static List<String> jobTypeList = [
    "Remote",
    "In Company",
  ];

  static List<String> stateJobList = [
    "Active",
    "Not Active",
  ];

  static bool hobbiesOne = false;
  static bool hobbiesTwo = false;
  static bool hobbiesThree = false;
  static bool trainAsec = false;

  static String hobbiesOneVal = "";
  static String hobbiesTwoVal = "";
  static String hobbiesThreeVal = "";

  static int? updateShowCode;
  static int? updateShowCodeUser;

  static String? nameCourse;

  static List<dynamic>? promoCode;
}
