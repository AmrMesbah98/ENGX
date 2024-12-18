import 'package:asec_application/Constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../bloc/CV/cv_control_cubit.dart';
import '../../shared/components/components.dart';
import '../resources/color_manager.dart';
import 'CV_DETAILS_PAGE.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController SearchController = TextEditingController();
  TextEditingController searchPositionController = TextEditingController();

  List<String> categoryCvItems = [
    "Mechanical",
    "Electrical",
    "Civil",
    "Architecture"
  ];

  List<String> positionCvItem = [
    "Trainee Engineer",
    "Site Engineer",
    "Design Engineer",
    "Technical Engineer",
  ];

  List<String> experienceYearItem = [
    "1990",
    "1991",
    "1992",
    "1993",
    "1994",
    "1995",
    "1996",
    "1997",
    "1998",
    "1999",
    "2000",
    "2001",
    "2002",
    "2003",
    "2004",
    "2005",
    "2006",
    "2007",
    "2008",
    "2009",
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
  ];

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String selectItemCategory = "Mechanical";
  String selectItemPosition = "Site Engineer";
  String selectItemYear = "2020";

  @override
  Widget build(BuildContext context) {
    SearchController.text = selectItemCategory;
    searchPositionController.text = selectItemPosition;

    //String specializationItem = "Electricity";

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('CV')
        .where('specialization', isEqualTo: selectItemCategory)
        .snapshots();

    final Stream<QuerySnapshot> positionCvFunction = FirebaseFirestore.instance
        .collection('CV')
        .where(
          'positionCv',
          isEqualTo: selectItemPosition,
        )
        .where('specialization', isEqualTo: selectItemCategory)
        .where('graduationYear', isEqualTo: selectItemYear)
        .snapshots();

    double _w = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          title: const Text(
            'CV Search',
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black54),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          bottom: TabBar(
            indicatorColor: Colors.blue.withOpacity(.0),
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.hdr_strong_sharp,
                  color: Colors.black54,
                ),
                child: Text("Category",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w600)),
              ),
              Tab(
                icon: Icon(Icons.polymer_sharp, color: Colors.black54),
                child: Text("Manual Filter",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: Stack(children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Choose Category",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        Icon(
                                          Icons.list,
                                          size: 16,
                                          color: ColorManager.Black,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "Specialization",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.Black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    items: categoryCvItems
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorManager.Black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: selectItemCategory,
                                    onChanged: (value) {
                                      setState(() {
                                        selectItemCategory = value as String;
                                        constantvar.selectspecializationItem =
                                            value;
                                        print(selectItemCategory);
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: (Colors.grey[100])!,
                                        ),
                                        color: (Colors.grey[100])!,
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: ColorManager.Black,
                                      iconDisabledColor: ColorManager.Black,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 200,
                                      padding: null,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: (Colors.grey[100])!,
                                      ),
                                      elevation: 8,
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder(
                        stream: _usersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("something is wrong");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.all(_w / 30),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  verticalOffset: -250,
                                  child: ScaleAnimation(
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: GestureDetector(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            CvDetailsView(
                                              stNum: CvControlCubit.get(context)
                                                  .cvModelList[index]
                                                  .addressStNum!,
                                              stName:
                                                  CvControlCubit.get(context)
                                                      .cvModelList[index]
                                                      .addressStName!,
                                              cvModel:
                                                  CvControlCubit.get(context)
                                                      .cvModelList[index],
                                              pro: CvControlCubit.get(context)
                                                  .cvModelList[index]
                                                  .pro!,
                                            ));
                                        /*
                                            navigateTo(
                                                context,
                                                CvDetailsView(
                                                  cvModel: CvControlCubit
                                                      .get(context)
                                                      .cvModelList[index],
                                                  pro: CvControlCubit
                                                      .get(context)
                                                      .cvModelList[index]
                                                      .pro!,
                                                  stName: CvControlCubit.get(context)
                                                      .cvModelList[index].addressStName!,
                                                  stNum: CvControlCubit.get(context)
                                                      .cvModelList[index].addressStNum!,
                                                )
                                            );
                                             */
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              elevation: 6,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .95,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons.person,
                                                                  color: Colors
                                                                      .grey),
                                                              SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .005),
                                                              Text(
                                                                "${snapshot.data!.docChanges[index].doc['firstname']} ${snapshot.data!.docChanges[index].doc['lastname']} "
                                                                    .toTitleCase(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons
                                                                      .phone_android,
                                                                  color: Colors
                                                                      .grey),
                                                              SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .005),
                                                              Text(
                                                                "${snapshot.data!.docChanges[index].doc['phone']} ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons.folder,
                                                                  color: Colors
                                                                      .grey),
                                                              SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .005),
                                                              Text(
                                                                "${snapshot.data!.docChanges[index].doc['specialization']} ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons
                                                                      .accessibility_new,
                                                                  color: Colors
                                                                      .grey),
                                                              SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .005),
                                                              Text(
                                                                "${snapshot.data!.docChanges[index].doc['positionCv']} ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 20),
                                                        child: Column(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .contact_mail_outlined,
                                                              size: 60,
                                                              color:
                                                                  Colors.grey,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Scaffold(
              body: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      // search
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    "Specialization",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .46,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Row(
                                            children: [
                                              Icon(
                                                Icons.list,
                                                size: 16,
                                                color: ColorManager.Black,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Specialization",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorManager.Black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: categoryCvItems
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            ColorManager.Black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectItemCategory,
                                          onChanged: (value) {
                                            setState(() {
                                              selectItemCategory =
                                                  value as String;
                                              constantvar
                                                      .selectspecializationItem =
                                                  value;
                                              print(selectItemCategory);
                                            });
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            height: 50,
                                            width: 200,
                                            padding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: (Colors.grey[100])!,
                                              ),
                                              color: (Colors.grey[100])!,
                                            ),
                                            elevation: 2,
                                          ),
                                          iconStyleData: IconStyleData(
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            ),
                                            iconSize: 14,
                                            iconEnabledColor:
                                                ColorManager.Black,
                                            iconDisabledColor:
                                                ColorManager.Black,
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 200,
                                            width: 200,
                                            padding: null,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: (Colors.grey[100])!,
                                            ),
                                            elevation: 8,
                                            offset: const Offset(-20, 0),
                                            scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: MaterialStateProperty
                                                  .all<double>(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all<
                                                      bool>(true),
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Position",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .46,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Row(
                                            children: [
                                              Icon(
                                                Icons.list,
                                                size: 16,
                                                color: ColorManager.Black,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "positionCv",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorManager.Black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: positionCvItem
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            ColorManager.Black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectItemPosition,
                                          onChanged: (value) {
                                            setState(() {
                                              selectItemPosition =
                                                  value as String;
                                              constantvar
                                                      .selectspecializationItem =
                                                  value;
                                              print(selectItemPosition);
                                            });
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            height: 50,
                                            width: 200,
                                            padding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: (Colors.grey[100])!,
                                              ),
                                              color: (Colors.grey[100])!,
                                            ),
                                            elevation: 2,
                                          ),
                                          iconStyleData: IconStyleData(
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            ),
                                            iconSize: 14,
                                            iconEnabledColor:
                                                ColorManager.Black,
                                            iconDisabledColor:
                                                ColorManager.Black,
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 200,
                                            width: 200,
                                            padding: null,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: (Colors.grey[100])!,
                                            ),
                                            elevation: 8,
                                            offset: const Offset(-20, 0),
                                            scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: MaterialStateProperty
                                                  .all<double>(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all<
                                                      bool>(true),
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  const Text(
                                    "Graduation Year",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .46,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Row(
                                                children: [
                                                  Icon(
                                                    Icons.list,
                                                    size: 16,
                                                    color: ColorManager.Black,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Experience Year",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            ColorManager.Black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              items: experienceYearItem
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorManager
                                                                .Black,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: selectItemYear,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectItemYear =
                                                      value as String;

                                                  print(selectItemYear);
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 50,
                                                width: 200,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: (Colors.grey[100])!,
                                                  ),
                                                  color: (Colors.grey[100])!,
                                                ),
                                                elevation: 2,
                                              ),
                                              iconStyleData: IconStyleData(
                                                icon: const Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                ),
                                                iconSize: 14,
                                                iconEnabledColor:
                                                    ColorManager.Black,
                                                iconDisabledColor:
                                                    ColorManager.Black,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight: 200,
                                                width: 200,
                                                padding: null,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: (Colors.grey[100])!,
                                                ),
                                                elevation: 8,
                                                offset: const Offset(-20, 0),
                                                scrollbarTheme:
                                                    ScrollbarThemeData(
                                                  radius:
                                                      const Radius.circular(40),
                                                  thickness:
                                                      MaterialStateProperty.all<
                                                          double>(6),
                                                  thumbVisibility:
                                                      MaterialStateProperty.all<
                                                          bool>(true),
                                                ),
                                              ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                height: 40,
                                                padding: EdgeInsets.only(
                                                    left: 14, right: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //view

                      StreamBuilder(
                        stream: positionCvFunction,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("something is wrong");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.all(_w / 30),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  verticalOffset: -250,
                                  child: ScaleAnimation(
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: GestureDetector(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            CvDetailsView(
                                              stNum: CvControlCubit.get(context)
                                                  .cvModelList[index]
                                                  .addressStNum!,
                                              stName:
                                                  CvControlCubit.get(context)
                                                      .cvModelList[index]
                                                      .addressStName!,
                                              cvModel:
                                                  CvControlCubit.get(context)
                                                      .cvModelList[index],
                                              pro: CvControlCubit.get(context)
                                                  .cvModelList[index]
                                                  .pro!,
                                            ));

                                        // navigateTo(context,
                                        //     CvMultiDetails(
                                        //       hobbiesList: snapshot.data!.docChanges[index].doc['listHobbies'],
                                        //       aboutUs:snapshot.data!.docChanges[index].doc['aboutUs'],
                                        //       address: snapshot.data!.docChanges[index].doc['address'],
                                        //       companyName: snapshot.data!.docChanges[index].doc['companyName'],
                                        //       email: snapshot.data!.docChanges[index].doc['email'],
                                        //       endDate: snapshot.data!.docChanges[index].doc['endDate'],
                                        //       facebook: snapshot.data!.docChanges[index].doc['facebook'],
                                        //       faculty: snapshot.data!.docChanges[index].doc['faculty'],
                                        //       firstname: snapshot.data!.docChanges[index].doc['firstname'],
                                        //       gpa: snapshot.data!.docChanges[index].doc['gpa'],
                                        //       graduationYear: snapshot.data!.docChanges[index].doc['graduationYear'],
                                        //       hobbies: snapshot.data!.docChanges[index].doc['hobbies'],
                                        //       lastname: snapshot.data!.docChanges[index].doc['lastname'],
                                        //       linkedin: snapshot.data!.docChanges[index].doc['linkedin'],
                                        //       military: snapshot.data!.docChanges[index].doc['military'],
                                        //       phone: snapshot.data!.docChanges[index].doc['phone'],
                                        //       positionCv: snapshot.data!.docChanges[index].doc['positionCv'],
                                        //       pro: snapshot.data!.docChanges[index].doc['pro'],
                                        //       shareProject: snapshot.data!.docChanges[index].doc['shareProject'],
                                        //       specialization: snapshot.data!.docChanges[index].doc['specialization'],
                                        //       startDate: snapshot.data!.docChanges[index].doc['startDate'],
                                        //       state: snapshot.data!.docChanges[index].doc['state'],
                                        //       work: snapshot.data!.docChanges[index].doc['work'],
                                        //
                                        //
                                        //     )
                                        // );

                                        /*
                                          navigateTo( context,   CvDetailsView(
                                            cvModel: CvControlCubit.get(context)
                                                .cvModelList[index],
                                            pro: CvControlCubit.get(context)
                                                .cvModelList[index]
                                                .pro!,
                                          )




                                          );
                              */
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              elevation: 6,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .95,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons.person),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              Text(
                                                                "${snapshot.data!.docChanges[index].doc['firstname']} ${snapshot.data!.docChanges[index].doc['lastname']} "
                                                                    .toTitleCase(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(Icons
                                                                  .phone_iphone),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              Text(
                                                                "${snapshot.data!.docChanges[index].doc['phone']} ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(Icons
                                                                  .accessibility_outlined),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              Text(
                                                                "${snapshot.data!.docChanges[index].doc['specialization']} ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 20),
                                                        child: Column(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .contact_mail_outlined,
                                                              size: 80,
                                                              color:
                                                                  Colors.grey,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
