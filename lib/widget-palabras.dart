import 'package:flutter/material.dart';
import 'package:myapp/main.dart';



class Palabras extends StatefulWidget {


    Palabras({
      Key key,
      @required this.items,
      @required this.palabras,
      this.padding= const  EdgeInsets.all(25.0),
    }):super(key:key);


  int items;
  List<String> palabras;
  EdgeInsetsGeometry padding;



  _PalabrasState createState() => _PalabrasState();
}

class _PalabrasState extends State<Palabras> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 4,
        children: elements(widget.palabras),
        )
    );
  }


  void actualizar(){
    setState(() {
      widget.items--;
    });
  }
}

List<Widget> elements (List<String> items){

  List<Widget> items = [];

  for(int i=0;i<items.length; i++){

      items.add(Text("$items[i]"),);

  }
return items;

}

