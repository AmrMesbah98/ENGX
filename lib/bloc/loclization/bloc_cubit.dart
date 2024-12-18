
import 'package:asec_application/Constant/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';




part 'bloc_state.dart';

class blockManagement extends Cubit<cubitState> {
  blockManagement() : super(BlocInitial());

  static blockManagement get(context) => BlocProvider.of(context);


//  bool test = true;


  buildSwitchLang() {
          return Switch(
            activeColor: Colors.white12 ,
            inactiveTrackColor: Colors.blue,
            value: constantvar.changestate ,
            onChanged: (val) async {
              emit(loadingState());
              if(constantvar.changestate == true)
                {
                  constantvar.changestate = false;
                  constantvar.lang = "ar";
                  print("lang --->>>>> ar");
                 // await CacheHelper.saveData(key: 'languages', value: constantvar.lang);
                  //await CacheHelper.saveData(key: 'switch', value: constantvar.changestate);
                  emit(successStateAr());
                }
              else if (constantvar.changestate == false)
                {
                  constantvar.changestate = true;
                  constantvar.lang = "en";
                  print("lang --->>>>> en");
                //  await CacheHelper.saveData(key: 'languages', value: constantvar.lang);
                 // await CacheHelper.saveData(key: 'switch', value:constantvar.changestate);
                  emit(successStateEn());
                }
              constantvar.changestate =val;
            },
          );

  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibaility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangePaswwordSuccessState());
  }

}


/*
import 'package:asec_app/Constant/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


part 'bloc_state.dart';

class blockManagement extends Cubit<cubitState> {
  blockManagement() : super(BlocInitial());

  static blockManagement get(context) => BlocProvider.of(context);


  buildSwitchLang() {
          return Switch(
            value: constantvar.changestate ,
            onChanged: (val){
              emit(loadingState());
              if(constantvar.changestate == true)
                {
                  constantvar.changestate = false;
                  constantvar.lang = "ar";
                  print("lang --->>>>> ar");
                  emit(successStateAr());
                }
              else if (constantvar.changestate == false)
                {
                  constantvar.changestate = true;
                  constantvar.lang = "en";
                  print("lang --->>>>> en");
                  emit(successStateEn());
                }
              constantvar.changestate =val;
            },
          );

  }
}

 */
