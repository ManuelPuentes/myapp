import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/my_item.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:myapp/sopas.dart';
import 'package:myapp/widget-palabras.dart';


void main() {
  int size=6;
  List<String> nums=["1","3","2","4","5","6","7","8","9","10","1","2","3","4","5","6","7","8","9","10","1","2","3","4","5","6","7","8","9","10","1","2","3","4","5","6"];
  List<String> items=[];

  List<String> palabras=["aaa","132456"];


  nums=sopa(6);


  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyGrid(
            padding: EdgeInsets.all(50.0),
            itemCount: size*size,
            itemBuilder: (BuildContext context, int index, bool selected) { items.add(nums[index]); return  MyContainer(index:index,color:Colors.blue[600],selected:selected, value:nums[index]);},
            items: items,
            size: size,
            words:palabras,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
      ),
    ),
  );
}
typedef ItemBuilder = Widget Function(BuildContext context, int index, bool selected);

class MyGrid extends StatefulWidget {
  
  MyGrid({    
    Key key,
    this.padding,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.gridDelegate,
    @required this.items,
    @required this.size,
    @required this.words,
    this.scrollPadding = const EdgeInsets.all(10.0),
    }):super (key: key);
  
     int itemCount;// numero de items del grid
    ItemBuilder itemBuilder;// constructor de los objetos que van en el grid
    final EdgeInsetsGeometry padding;
     SliverGridDelegate gridDelegate;
    final EdgeInsets scrollPadding;
    List<String> items;
    List<String> words;
    int size;
     SnackBar mysnack = SnackBar( content: Chip(  labelStyle: TextStyle( color: Colors.white , fontFamily: "Poppins-Bold"),      backgroundColor: Colors.green, label: Text("Bien hecho encontaste una palabra !!"), avatar:Icon(Icons.check),), elevation: 50.0, backgroundColor: Colors.green, duration: Duration(seconds:3,),);
    int estado=-1;
    String player="";
    String selectedword="";
    Palabras search;
  
  
  
  @override
  _MyGridState createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> {
  
  final _elements = List<_MultiSelectChildElement>();
  final controller = DragSelectGridViewController();
  final globalKey = GlobalKey<ScaffoldState>();
  LocalHistoryEntry _historyEntry;
       


  bool _isSelecting = false;
  int _startIndex = -1;
  int _endIndex = -1;

    @override
  void initState() {
    super.initState();
    initSopa();
    controller.addListener(scheduleRebuild);
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }
 void actualizar(int estado ){

   //widget.player= controller.text;
  setState(() {
    widget.estado+=estado;
  });
}
Widget mymenu(){

return Scaffold(

  

body:Container(

  padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/3, left: 15.0, right: 15.0 ),

   

child: Center(

  
  child:ListView(children: <Widget>[




 RaisedButton.icon(onPressed:(){ actualizar(1);} , icon: Icon(Icons.play_circle_filled), label: Text("Start Game ! " ,style: TextStyle(color: Colors.white),) ,color: Color.alphaBlend(Colors.blue[600], Colors.black12,), hoverColor: Colors.green[100],),
 Padding(padding: EdgeInsets.only(top:10.0, bottom: 10.0)),
 RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.search), label: Text("Instrucciones")),
 Padding(padding: EdgeInsets.only(top:10.0, bottom: 10.0)),
 Container(child : Text(" manten presionada una letra  y luego desliza hasta donde acabe la palabra, asi de facil es jugar si consigues todas las palabras de un nivel pasas directo al siguiente. suerte!", textAlign: TextAlign.center,))


  ],
  ),),


  


),

);

}
void netLevel(){

  if(widget.size==11){

    
    setState(() {
      widget.estado=-1;
    });
  }else{
      setState(() {

        
      widget.size++;
      widget.gridDelegate= SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.size,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                );
      widget.words= palabras(widget.size);
      widget.items= sopa(widget.size);
      widget.itemCount= widget.size* widget.size;
      });
  }



}

void initSopa(){

  //print("se ejecuto este metodo");
  widget.words= palabras(widget.size); 
  widget.items= sopa(widget.size);
  //print(widget.words);
}
  @override
  Widget build(BuildContext context) {

    if(widget.estado==-1){


       return  mymenu();
    
    }else if(widget.estado==0){

    TextEditingController textfieldcontroller = new TextEditingController();
     return Scaffold(

       
    backgroundColor:  Colors.white,
    resizeToAvoidBottomPadding: true,
    body: Stack(
      fit: StackFit.expand,
      children: <Widget>[

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top : 20.0,),
                child: Image.asset("assets/image.png"),
            ),
              Expanded(
                child: Container(),
              ),
          Image.asset("assets/image2.png"),
            ],
          ),
          SingleChildScrollView(
            padding:EdgeInsets.only( left: 28.0 , right: 28.0, top : 60.0 ),
            child:Column(
              children: <Widget>[

                SizedBox(
                  height:180,
                ),
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration:  BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow:[
                      BoxShadow(
                        color:Colors.black12,
                        offset:Offset(0.0, 15.0),
                        blurRadius: 
                        15.0
                      ),
                      BoxShadow(
                        color:Colors.black12,
                        offset:Offset(0.0, -10.0),
                        blurRadius:10.0
                      ),

                    ]),
                    child: Padding(
                      padding: EdgeInsets.only( left: 16.0 , top: 16.0),
                      child: Column(
                        children: <Widget>[
                          Text("Login", 
                            style: TextStyle(
                              fontSize: 45,
                              fontFamily: "Popping-Bold", letterSpacing: .6
                              ),),
                              
                              Padding(padding: EdgeInsets.only(top:45,),),
                              
                              SizedBox(
                                height:30,
                              
                              ),
                              Text("Username",
                              style:TextStyle(
                                fontFamily: "Popping-Medium",
                                fontSize: 26,
                              ),
                              ),

                              TextField(
                               controller:textfieldcontroller, onSubmitted:(String value){ print(value);} ,decoration: InputDecoration(hintText:  "Username", hintStyle:TextStyle(color:Colors.grey, fontSize: 12.0) ),
                              ),

                              

                              Padding(padding: EdgeInsets.only(top:20, )),

                      ButtonTheme(

                        minWidth: 200,
                        height: 50,
                        child:  RaisedButton( child: Text("Log in !" ,style: TextStyle( color:Colors.white ),) ,color: Colors.blue, onPressed:(){widget.player=textfieldcontroller.text;  actualizar(1);},),
                      ),
                           


                        ],
                      ),
                    ),
                )

              ],

            )
          )


      ],
    ),



  );

    }else if(widget.estado==1){

    widget.itemBuilder= (BuildContext context, int index, bool selected) { /*widget.items.add(nums[index]);*/  widget.items = sopa(widget.size);  return MyContainer(index:index,color:Colors.green,selected:selected, value:widget.items[index]);};

    

      return Scaffold( 
      //appBar: AppBar( title: Text(widget.player,),),
      key:globalKey,
      body: 

      ListView(children: <Widget>[

            GestureDetector(

        onLongPressStart: _onLongPressStart,
        onLongPressEnd: _onLongPressEnd,


        child: IgnorePointer(
          ignoring: _isSelecting,
          child:Container(
            
          //width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
            
              //gradient:LinearGradient(colors: [Colors.black, Color.fromARGB(1, 255, 75, 15)]),
              borderRadius: BorderRadius.circular(12) 
              ),
            child:GridView.builder(
            padding: widget.padding,
            itemCount: widget.itemCount,
            itemBuilder: (BuildContext context, int index) {
            final start = (_startIndex < _endIndex) ? _startIndex : _endIndex;
            final end = (_startIndex < _endIndex) ? _endIndex : _startIndex;
            final selected = (index >= start && index <= end);
            return _MultiSelectChild(
              index: index,
              child: widget.itemBuilder(context, index, selected),
            );
          },
          gridDelegate: widget.gridDelegate,
        ),
            ), 
          

      ),
      ),
        
      Container(
       
      height: MediaQuery.of(context).size.height/4,
       
       child: GridView.count(
         crossAxisCount: 4,
         children: mimetodito(),
         
         )
       ),


      ],),
 
       
    //bottomNavigationBar: BottomAppBar(child: Text(widget.player), clipBehavior: Clip.hardEdge,),
       

           

    
    );}
    

  }

List<Widget> mimetodito(){

List<Widget> lista=[];

  for(int i=0;i<widget.words.length;i++){
    String pal= widget.words[i];

    lista.add(Chip(
  avatar: CircleAvatar(
    backgroundColor: Colors.white,

   
    child: Text(pal[0]),
  ),
  label: Text(widget.words[i], textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
  backgroundColor: Colors.blue[600],
));

    //lista.add(Text(widget.words[i]));


  }
  return lista;
}



void scheduleRebuild(){setState(() { });}


  void _onLongPressStart(LongPressStartDetails details) {
    final startIndex = _findMultiSelectChildFromOffset(details.localPosition);
    _setSelection(startIndex, startIndex);
    setState(() => _isSelecting = (startIndex != -1));
  }
    void _onLongPressEnd(LongPressEndDetails details) {
    _updateEndIndex(details.localPosition);


   // globalKey.currentState.showSnackBar(widget.mysnack);
    setState(() => _isSelecting = false);
  }

  void _updateEndIndex(Offset localPosition) {
    final endIndex = _findMultiSelectChildFromOffset(localPosition);
    if (endIndex != -1) {
      _setSelection(_startIndex, endIndex);
     // _updateLocalHistory();
    }
  }
    void _updateLocalHistory() {
    final route = ModalRoute.of(context);
    if (route != null) {
      if (_startIndex != -1 && _endIndex != -1) {
        if (_historyEntry == null) {
          _historyEntry = LocalHistoryEntry(
            onRemove: () {
              _setSelection(-1, -1);
              _historyEntry = null;
            },
          );
          route.addLocalHistoryEntry(_historyEntry);
        }
      } else {
        if (_historyEntry != null) {
          route.removeLocalHistoryEntry(_historyEntry);
          _historyEntry = null;
        }
      }
    }
  }

    void dragController(int i, int j){

        int auxi=0;
        int auxj=0;
        int ix=0;
        int iy=0;
        int jx=0;
        int jy=0;

        (i<j)? auxi=i : auxi=j;
        (i>j)? auxj=i : auxj=j; 


      iy=i%widget.size;
      jy= j%widget.size;

      while(true){
        if(i<widget.size){
          break;
        }else{
        i=i-widget.size;
        ix++;
        }

      }
      while(true){
        if(j<widget.size){
          break;
        }else{
        j=j-widget.size;
        jx++;
        }

      }

      int aux=ix+iy;
      int aux2=jx+jy;

     widget.selectedword="";

        if( ix==jx && iy==jy){
          print("no se movio de un mismo punto");
        }else if(ix==jx) {
         // print("horizontal");
          seleccionaHorizontal(auxi, auxj);

        }else if(iy==jy){
          // print("vertical");
           seleccionaVertical(auxi, auxj);

        }else if(ix-jx == iy-jy || jx-ix == jy-i){
           //  print("diago principal");
             seleccionadiagonal(auxi, auxj);
        }else if(aux==aux2){
          //print("diago secundaria ");
          seleccionadiagonal2(auxi,  auxj);

        }

        if(buscar())
         globalKey.currentState.showSnackBar(widget.mysnack);




    }


    bool buscar(){

      String reverse="";

      for(int i=0;i<widget.selectedword.length;i++){

        reverse+=widget.selectedword[widget.selectedword.length-i-1];

      }
      //print("reverse word es $reverse");


      for(int i=0;i<widget.words.length; i++){

        if(widget.words[i]== widget.selectedword || widget.words[i]== reverse){
            //print("palabra encontrada "+ widget.words[i]);
            widget.words.removeAt(i);
            if(widget.words.length==0){
              netLevel();
            }
            return true;
         
        }

      }
return false;
      //print(widget.words);
      //print(widget.words.length);

      /*if(widget.words.length==0){

        //print("Hola");
            netLevel();
 
      }*/

    }


    void seleccionaHorizontal(int i,int y){

        for(int j=0;j<=y-i;j++){

          widget.selectedword+=widget.items[i+j];
        }
        //print("selectd word es : "+widget.selectedword);
    }
    
      void seleccionaVertical(int i,int y){

          while(true){
            if(i>y)break;
            widget.selectedword+=widget.items[i];
            i+=widget.size;
          }

         // print("selected word es : "+widget.selectedword);
        
      }

      void seleccionadiagonal(int i, int y){

        while(true){
          if(i>y)break;
          widget.selectedword+= widget.items[i];
          i+= (widget.size)+1; 

        }
        //print("selected word es : "+widget.selectedword);

      }


      void seleccionadiagonal2(int i, int y){
        while(true){

          if(i>y)break;
          widget.selectedword+= widget.items[i];
          i+= (widget.size)-1;

        }
        //print("selected word es : " + widget.selectedword);

      }

    void _setSelection(int start, int end) {
          _startIndex = start;
          _endIndex = end;
          if(_isSelecting){
             print(" $_startIndex , $_endIndex");
             dragController(start, end);
          }
         
           //controller.selection = Selection( {1,3,7,6,9} );
 
}

  int _findMultiSelectChildFromOffset(Offset offset) {
    final ancestor = context.findRenderObject();
    for (_MultiSelectChildElement element in List.from(_elements)) {
      if (element.containsOffset(ancestor, offset)) {
        if (widget.scrollPadding != null) {
          element.showOnScreen(widget.scrollPadding);
        }
        return element.widget.index;
      }
    }
    return -1;
  }
}

class _MultiSelectChild extends ProxyWidget {
  const _MultiSelectChild({
    Key key,
    @required this.index,
    @required Widget child,
  }) : super(key: key, child: child);

  final int index;

  @override
  _MultiSelectChildElement createElement() => _MultiSelectChildElement(this);
}

class _MultiSelectChildElement extends ProxyElement {
  _MultiSelectChildElement(_MultiSelectChild widget) : super(widget);

  @override
  _MultiSelectChild get widget => super.widget;

  _MyGridState _ancestorState;

  @override
  void mount(Element parent, newSlot) {
    super.mount(parent, newSlot);
    _ancestorState = ancestorStateOfType(TypeMatcher<_MyGridState>());
    _ancestorState?._elements?.add(this);
  }

  @override
  void unmount() {
    _ancestorState?._elements?.remove(this);
    _ancestorState = null;
    super.unmount();
  }

  bool containsOffset(RenderObject ancestor, Offset offset) {
    final RenderBox box = renderObject;
    final rect = box.localToGlobal(Offset.zero, ancestor: ancestor) & box.size;
    return rect.contains(offset);
  }

  void showOnScreen(EdgeInsets scrollPadding) {
    final RenderBox box = renderObject;
    box.showOnScreen(
      rect: scrollPadding.inflateRect(Offset.zero & box.size),
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void notifyClients(ProxyWidget oldWidget) {
    //
  }
}