import 'package:flutter/material.dart';

class MyCustomWidget extends StatefulWidget {
  MyCustomWidget({super.key, required this.TapToExpandIt, required this.Sentence, required this.isExpanded, required this.isExpanded2});
  String TapToExpandIt;
  List Sentence ;
  bool isExpanded = true;
  bool isExpanded2 = true;
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          widget.isExpanded = !widget.isExpanded;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          horizontal: widget.isExpanded ? 10 : 0,
          vertical: 20,
        ),
        padding: const EdgeInsets.all(20),
        height: widget.isExpanded ? 75 : 250,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 1200),
        decoration: BoxDecoration(
          boxShadow: [
            /*
            BoxShadow(
              color: Color(0xff6F12E8).withOpacity(0.5),
              blurRadius: 20,
              offset: Offset(5, 10),
            ),

             */
          ],
          color: Colors.blue[400],
          borderRadius: BorderRadius.all(
            Radius.circular(widget.isExpanded ? 20 : 0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.TapToExpandIt,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  widget.isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: Colors.white,
                  size: 27,
                ),
              ],
            ),
            widget.isExpanded ? SizedBox() : SizedBox(height: 30),
            AnimatedCrossFade(
              firstChild: const Text(
                '',
                style: TextStyle(
                  fontSize: 0,
                ),
              ),
              secondChild: ListView.builder(
                  itemCount: widget.Sentence.length,
                  itemBuilder:(context, index)
                  {
                    return widget.Sentence[index];
                  }
              ),

              crossFadeState: widget.isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 1200),
              reverseDuration: Duration.zero,
              sizeCurve: Curves.fastLinearToSlowEaseIn,
            ),
          ],
        ),
      ),
    );
  }
}
