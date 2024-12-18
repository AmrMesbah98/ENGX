import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimationTestPage extends StatelessWidget {
  const AnimationTestPage({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150.h,),

          Animate(
            effects: [FadeEffect(), ScaleEffect()],
            child: Text("Hello World!"),
          ),

          SizedBox(height: 20.h,),

          Text("Hello World!").animate().fade().scale(),

          SizedBox(height: 20.h,),

          Text("Hello").animate()
              .fade(duration: 500.ms)
              .scale(delay: 500.ms) ,// runs after fade.

          SizedBox(height: 20.h,),

          Text("Hello World!").animate()
              .fadeIn() // uses `Animate.defaultDuration`
              .scale() // inherits duration from fadeIn
              .move(delay: 300.ms, duration: 600.ms) // runs after the above w/new duration
              .blurXY(), // inherits the delay & duration from move

          SizedBox(height: 20.h,),

          Text("Hello").animate(
            delay: 1000.ms, // this delay only happens once at the very start
            onPlay: (controller) => controller.repeat(), // loop
          ).fadeIn(delay: 500.ms), // this delay happens at the start of each loop

          SizedBox(height: 20.h,),


          // an opacity of 1 is "neutral"
          Text("Hello").animate().fade(), // begin=0, end=1
          Text("Hello").animate().fade(begin: 0.5) ,// end=1
          Text("Hello").animate().fade(end: 0.5), // begin=1

          SizedBox(height: 20.h,),

          Text('Hello').animate().tint(color: Colors.purple),

          SizedBox(height: 20.h,),

          Text("Hello").animate()
              .fadeIn(duration: 600.ms)
              .then(delay: 200.ms) // baseline=800ms
              .slide(),

          SizedBox(height: 20.h,),

          Column(children: AnimateList(
            interval: 400.ms,
            effects: [FadeEffect(duration: 300.ms)],
            children: [Text("Hello"), Text("World"),  Text("Goodbye")],
          )),

// or shorthand:
          Column(
            children: [Text("Hello"), Text("World"),  Text("Goodbye")]
                .animate(interval: 400.ms).fade(duration: 300.ms),
          ),

          SizedBox(height: 20.h,),

          Text("text").animate().custom(
              duration: 300.ms,
              builder: (context, value, child) => Container(
                color: Color.lerp(Colors.red, Colors.blue, value),
                padding: EdgeInsets.all(8),
                child: child, // child is the Text widget being animated
              )
          ),

          SizedBox(height: 20.h,),


          Animate().custom(
            duration: 10.seconds,
            begin: 10,
            end: 0,
            builder: (_, value, __) => Text(value.round().toString()),
          ).fadeOut(),

          SizedBox(height: 20.h,),

          Animate().toggle(
            duration: 2.seconds,
            builder: (_, value, __) => Text(value ? "Before" : "After"),
          ),

          SizedBox(height: 20.h,),

          Text("Horrible Pulsing Text")
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .fadeOut(curve: Curves.easeInOut),

          SizedBox(height: 20.h,),

          Text("Hello").animate().fadeIn(curve: Curves.easeOutExpo)
              .listen(callback: (value) => print('current opacity: $value')),

          SizedBox(height: 20.h,),

        ],
      ),
    );
  }
}
