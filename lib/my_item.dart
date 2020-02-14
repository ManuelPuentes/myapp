import 'package:flutter/material.dart';

class SelectedWord {
  static String myword = "";

  static void addword(String word) {
    myword += word;
    print("su palabra seleccionada es $myword");
  }

  static void deleteword() {
    myword = "";
    print(" se elimino la palabra $myword");
  }
}

class MyContainer extends StatefulWidget {
  @override
 
   MyContainer({
    Key key,
    @required this.index,
    @required this.color,
    @required this.selected,
    @required this.value,
  }) : super(key: key);

  final int index;
  final MaterialColor color;
   bool selected;
  final String value;
  

  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: widget.selected ? 1.0 : 0.0,
      duration: kThemeChangeDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));
  }

  @override
  void didUpdateWidget(MyContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      if (widget.selected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }




  void actualizar() {
    setState(() {
          widget.selected=!widget.selected;
          if(!widget.selected) SelectedWord.addword("$widget.value");
          print("$widget.value");
    });


  }

  @override
  Widget build(BuildContext context) {
        return AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (BuildContext context , Widget child,){
            final color= Colors.blue[600];
            return Transform.scale(scale: _scaleAnimation.value,
            child: DecoratedBox(
              decoration:BoxDecoration(color:color),
              child:child,
            ),
            );

        },
        child:Container(
          alignment: Alignment.center,
          child: Text(
              '${widget.value}',
              style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              ),
        ),
        )
        

      );
  
  }
}

