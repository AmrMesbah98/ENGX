import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/CV/CV_DETAILS_PAGE.dart';
import 'package:asec_application/presentation/CV/Tablet/CV_details_tablet.dart';
import 'package:asec_application/presentation/CV/search_member.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../bloc/CV/cv_control_cubit.dart';
import '../../../shared/components/components.dart';





class Search_CVTablet extends StatefulWidget {
  @override
  _Search_CVTabletState createState() => _Search_CVTabletState();
}

class _Search_CVTabletState extends State<Search_CVTablet>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  Animation<double>? _animation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));

    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery
        .of(context)
        .size
        .width;
    return BlocConsumer<CvControlCubit, CvControlState>(
      listener: (context, state) {

        if(state is CvControlLoading)
        {
          const CircularProgressIndicator();
        }

      },
      builder: (context, state) {

        if(state is CvPersonalLoading)
        {
          return   const Center( child: CircularProgressIndicator());
        }

        else
        {
          return  Scaffold(
            backgroundColor: const Color(0xffF5F5F5),

            body: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: (){
                    return CvControlCubit.get(context).getCv();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.all(_w / 30),
                    physics:
                    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemCount: CvControlCubit.get(context).cvModelList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          verticalOffset: -250,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: GestureDetector(
                              onTap: () {
                                navigateTo(
                                    context,
                                    CvDetailsView(
                                      cvModel:constantvar.cvModel= CvControlCubit.get(context)
                                          .cvModelList[index],
                                      pro: CvControlCubit.get(context)
                                          .cvModelList[index]
                                          .pro!,
                                      stName: CvControlCubit.get(context)
                                          .cvModelList[index].addressStName!,
                                      stNum: CvControlCubit.get(context)
                                          .cvModelList[index].addressStNum!,
                                    )
                                );
                              },
                              child: Card(
                                shadowColor: Colors.white,
                                color: Colors.grey[100],
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),

                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .95,
                                  height: MediaQuery.of(context).size.width * .32,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(

                                      mainAxisAlignment: MainAxisAlignment.start,

                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.account_circle,color: Colors.grey,),
                                                const SizedBox(width: 3),
                                                Text(
                                                  "${CvControlCubit.get(context).cvModelList[index].firstname} ${CvControlCubit.get(context).cvModelList[index].lastname}".toTitleCase(),

                                                  style:  TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.phone_android,color: Colors.grey,),
                                                const SizedBox(width: 3),
                                                Text(
                                                  "${CvControlCubit.get(context).cvModelList[index].phone}",
                                                  style:  TextStyle(
                                                      fontSize: 14.sp,

                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.topic,color: Colors.grey,),
                                                const SizedBox(width: 3),
                                                Text(
                                                  "${CvControlCubit.get(context).cvModelList[index].specialization} ",
                                                  style:  TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.accessibility,color: Colors.grey,),
                                                const SizedBox(width: 3),
                                                Text(
                                                  "${CvControlCubit.get(context).cvModelList[index].positionCv} ",
                                                  style:  TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20 ),
                                          child: const Column(
                                            children: [
                                              Icon(Icons.contact_mail_outlined,size: 80,color: Colors.grey,)
                                            ],
                                          ),
                                        )


                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

// top me rahna
                CustomPaint(
                  painter: MyPainter(),
                  child: Container(height: 0),
                ),
              ],
            ),
          );
        }


      },
    );
  }

  Widget cards() {
    double _w = MediaQuery
        .of(context)
        .size
        .width;
    return Opacity(
      opacity: _animation!.value,
      child: Transform.translate(
        offset: Offset(0, _animation2!.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RouteWhereYouGo(),
                ));
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
            padding: EdgeInsets.all(_w / 20),
            height: _w / 4.4,
            width: _w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffEDECEA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(.1),
                  radius: _w / 15,
                  child: FlutterLogo(size: 30),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Example',
                        textScaleFactor: 1.6,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(.7),
                        ),
                      ),
                      Text(
                        'Example',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(.8),
                        ),
                      )
                    ],
                  ),
                ),
                Icon(Icons.navigate_next_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_1 = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.fill;

    Path path_1 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * .1, 0)
      ..cubicTo(size.width * .05, 0, 0, 20, 0, size.width * .08);

    Path path_2 = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width * .9, 0)
      ..cubicTo(
          size.width * .95, 0, size.width, 20, size.width, size.width * .08);

    Paint paint_2 = Paint()
      ..color = Colors.grey[200]!
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path_3 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0);

    canvas.drawPath(path_1, paint_1);
    canvas.drawPath(path_2, paint_1);
    canvas.drawPath(path_3, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RouteWhereYouGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 50,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Text('EXAMPLE  PAGE',
            style: TextStyle(
                color: Colors.black.withOpacity(.7),
                fontWeight: FontWeight.w600,
                letterSpacing: 1)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black.withOpacity(.8)),
          onPressed: () => Navigator.maybePop(context),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }
}





