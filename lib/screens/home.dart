import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import '../data/model/add_date.dart';
import '../data/utlity.dart';
import 'dart:developer';
import '../component/bottomnavigationbar.dart' as bottom;


//Firebase
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class Home1 extends StatefulWidget {
  Function callback;
  String user;
  Home1({Key? key, required this.callback,required this.user}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();

}


class _Home1State extends State<Home1> {
  Map<String, dynamic> Map1 = <String, dynamic>{};
  Map<String, dynamic> Map2 = <String, dynamic>{};
  var finalMap ;
  var db = FirebaseFirestore.instance;
  var history;
  var All;
  var All2;
  Box<Add_data> box = Hive.box<Add_data>('data');
  late String nameChange ;



  /*var box2 = Hive.openBox<Add_data>('data');*/



  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];


  /*void getUser() async {




    final docRef = db.collection("ACC").doc("Admin");
    docRef.get().then((value) {
      setState(() {
        user = value.get('name');
        log('TUNG1: $user');
      });
    });
  }
  void getNewData() async {
    bool don1 = false;
    bool don2 = false;
    DateTime newdate;

    void GetOwnData(QueryDocumentSnapshot<Map<String, dynamic>> val) {

      try{
      DateFormat format = DateFormat("dd-MM-yyyy – HH:mm");
      newdate = (format.parse(val.get('date')));
      log('newdate: $newdate');

      var add = Add_data(
          val.get('In'), val.get('amount'), format.parse(val.get('date')), val.get('explain'),val.get('type'));
      box.add(add);
      log('Box1: ${box.values.toString()}');
      }
      catch(e){
      log('Error: $e');
      }

    }


    final docRef = db.collection("ACC").doc("Admin").collection("Expense");
    docRef.get().then((value) {
      setState(() {
        All = value.docs.toString();
        log('All: $All');
      });
    });

    await docRef.get().then(
          (querySnapshot) {
        for (var value in querySnapshot.docs) {
          print('${value.id} => ${value.data()}');
          Map1 = value.data();
          GetOwnData(value);
          finalMap.addAll(Map1);
          log('All1: $Map1');
          don1 = true;

        }
      },
      onError: (e) => print("Error completing: $e"),
    );



    final docRef2 = db.collection("ACC").doc("Admin").collection("Income");
    docRef2.get().then((value) {
      setState(() {
        All2 = value.docs.toString();
        log('All: $All2');
      });
    });

    await docRef2.get().then(
          (querySnapshot) {
        for (var value in querySnapshot.docs) {
          print('${value.id} => ${value.data()}');
          Map2 = value.data();
          GetOwnData(value);

          finalMap.addAll(Map2);
          log('All2: $Map2');
          don2 = true;

        }
      },
      onError: (e) => print("Error completing: $e"),
    );

if(don1 == true && don2 == true) {
finalMap = [Map1,Map2];
log('finalMap: $finalMap');

for(var item  in finalMap){

  var onlyValues = item.values.toList();
  log('onlyValue: ${onlyValues.toString()}');
  try{
    newdate = DateTime.parse(onlyValues[0]);
    DateFormat format = DateFormat("dd-MM-yyyy – HH:mm");
    newdate = (format.parse(onlyValues[0]));
    log('newdate: $newdate');

    var add = Add_data(
        onlyValues[3], onlyValues[2], format.parse(onlyValues[0]), onlyValues[1],onlyValues[4]);
    box.add(add);
    log('Box1: ${box.values.toString()}');
  }
  catch(e){
    log('Error: $e');
  }

 *//* log('ADD: ${add.toString()}');*//*
}
}

  }*/



  @override
  void initState() {

    log('Box1: ${box.values.toString()}');
    log('BoxL: ${box.length}');
    /*var nes2;
    var i = 0;
    late String formattedDate ;
    Map<String, dynamic> MapTemp= <String, dynamic>{};
    Map<String, String> ResultMap= <String, String>{};
    var nes = box.values.toString();
    for(i; i<box.length; i++) {
      nes2 = box.values.toList()[i];
      formattedDate = DateFormat('dd-MM-yyyy – HH:mm').format(nes2.datetime);
      var temp = <String, String>{
        "explain": nes2.explain,
        "date": formattedDate,
        "amount": nes2.amount,
        "type": nes2.name,
        "In": nes2.IN
      };
      for (var entry in temp.entries) {
        // Add an empty `List` to `ResultMap` if the key doesn't already exist
        // and then merge the `List`s.
        (ResultMap[entry.key] ??= "").addAll(entry.value);
      }
    *//*  MapTemp.addAll(temp);*//*
    }
    if(i == box.length) {
      log('ResultMap: $ResultMap');
    }*/

    /*final list = box2.get('data');*/
    setState(()   {
      box = Hive.box<Add_data>('data');
      nameChange = widget.user;
      log('Home: $nameChange');
/*      print('Box: $nes');
      log('Box: $nes');*/
 /*     getUser();


      if(box.length == 0){
        getNewData();
      }*/


 /*     if(Map1.toString().isNotEmpty && Map2.toString().isNotEmpty&&finalMap.toString().isNotEmpty) {
        log('finalMap: $finalMap');
      }*/


     /* getNewData();
      if(Map1.isNotEmpty && Map2.isNotEmpty&&finalMap.isNotEmpty) {
        log('finalMap: $finalMap');
      }*/

    });
    super.initState();
  }

  showAlertDialog(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    _textFieldController.text = nameChange;
    bool _validate = false ;

    void checkEmpty(){
      if(_textFieldController.text.isEmpty || _textFieldController.text==""||_textFieldController.text.trim() == ''){
        _textFieldController.text = nameChange;
        _validate = true;
      }
      else {
        nameChange = _textFieldController.text;
        _validate = false;
        //save the _textFieldController.text to a variable
      }
    }

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK",style: TextStyle(fontSize: 22),),
      onPressed: () {
        setState(() {

          if(_textFieldController.text.isEmpty || _textFieldController.text==""||_textFieldController.text.trim() == ''){
            _textFieldController.text = nameChange;
          }
          else {
            nameChange = _textFieldController.text;
            db
                .collection("ACC")
                .doc("Admin").update({"name": nameChange}).then(
                    (value) => {print("Update thành công!"),
                    Navigator.pop(context, 'OK')},
                onError: (e) => print("Error updating document $e with $nameChange")
            );

            //save the _textFieldController.text to a variable
          }

        });

      },
    );

    Widget BackButton = TextButton(
      child: Text("Back",style: TextStyle(fontSize: 22),),
      onPressed: () {
        setState(() {
          nameChange = nameChange;
        });
        Navigator.pop(context, 'Back');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Bạn có chắc muốn thay đổi tên  ?",style: TextStyle(fontSize: 24)),
      content: TextField(
        onChanged: (value) {
          //nameChange = value;
          //save the _textFieldController.text to a variable
        },
        controller: _textFieldController,

        onEditingComplete: () {
         checkEmpty();
        },
        onSubmitted: (value) {
        checkEmpty();
        },
        onTapOutside: (value) {
          checkEmpty();
        },
        decoration: InputDecoration(hintText: _validate ? "Tên không được để trống" : "Nhập tên của bạn",
         errorText: _validate ? "Tên không được để trống" : null,)
      ),   //style: TextStyle(fontSize: 21)
      actions: [
        okButton,
        BackButton,
      ],
    );
    Visibility visible= Visibility(
      visible: true,//isNotStorage ? true : false,
      child: alert,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: 340, child: _head()),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Transactions History',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                                color: Colors.black,
                              ),
                            ),


/*                            Text(
                              'See all',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),*/


                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          history = box.values.toList()[index];
                          return getList(history, index);
                        },
                        childCount: box.length,
                      ),
                    )
                  ],
                );
              })),
    );
  }

  Widget getList(Add_data history, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) async {

          void delete (){
            history.delete();
            log('History: $history have been delete');
            widget.callback();
          }

          String formattedDate = DateFormat('dd-MM-yyyy – HH:mm').format(history.datetime);
          log('FormattedDate: $formattedDate');
          if(history.IN == 'Income'){
           await db
                .collection("ACC")
                .doc("Admin")
                .collection("Income")
                .doc(formattedDate)
                .delete()
            .then((_) =>delete(),)
                .onError((e, _) => log("Error writing document: $e"));
            
          }
          if(history.IN == 'Expense'){
           await db
                .collection("ACC")
                .doc("Admin")
                .collection("Expense")
                .doc(formattedDate)
                .delete()
                .then((_) =>delete(),)
                .onError((e, _) => print("Error writing document: $e"));
          }



        },
        child: get(index, history));
  }

  ListTile get(int index, Add_data history) {
    return ListTile(
        leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
          child: Image.asset('images/${history.name}.jpg', height: 40),
        ),
      title: Text(
        history.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${day[history.datetime.weekday - 1]}  ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  Widget _head() {
    return Stack(
      children: [
    Column(
    children: [
    Container(
    width: double.infinity,
      height: 240,
      decoration: const BoxDecoration(
        color: Color(0xff368983),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [

          /*Positioned(
            top: 35,
            left: 340,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Container(
                height: 40,
                width: 40,
                color: Color.fromRGBO(250, 250, 250, 0.1),
                child: const Icon(
                  Icons.notification_add_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),*/

          Padding(
            padding: const EdgeInsets.only(top: 35, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good afternoon',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 224, 223, 223),
                  ),
                ),

      new GestureDetector(
        onTap: () {
          showAlertDialog(context)  ;
        },
        child: new Text(nameChange,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,),
      )
      ),

               /*TextField(
                 controller: TextEditingController(text: widget.user),
                 style: const TextStyle(
                   fontWeight: FontWeight.w600,
                   fontSize: 20,
                   color: Colors.white,
                 ),
               )*/

               /* Text(
                  widget.user,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),*/


              ],
            ),
          )
        ],
      ),
    ),
    ],
    ),
    Positioned(
    top: 140,
    left: 37,
    child: Container(
    height: 200,   //170
    width: 320,
    decoration: BoxDecoration(
    boxShadow: [
    BoxShadow(
    color: Color.fromRGBO(47, 125, 121, 0.3),
    offset: Offset(0, 6),
    blurRadius: 12,
    spreadRadius: 6,
    ),
    ],
    color: Color.fromARGB(255, 47, 125, 121),
    borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
    children: [
    SizedBox(height: 10),
    const Padding(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'Total Balance',
    style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: Colors.white,
    ),
    ),
      Text(
        'Today Balance',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.white,
        ),
      ),

/*    Icon(
    Icons.more_horiz,
    color: Colors.white,
    ),*/

    ],
    ),
    ),
    SizedBox(height: 7),
    Padding(
    padding: const EdgeInsets.only(left: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    '\$ ${total()}',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: Colors.white,
    ),
    ),

      Text(
        '\$ ${totalToday()}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
      ),


    ],
    ),
    ),
    SizedBox(height: 15), //25
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Row(
    children: [
    CircleAvatar(
    radius: 13,
    backgroundColor: Color.fromARGB(255, 85, 145, 141),
    child: Icon(
    Icons.arrow_downward,
    color: Colors.white,
    size: 19,
    ),
    ),
    SizedBox(width: 7),
    Text(
    'Total Income',
    style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: Color.fromARGB(255, 216, 216, 216),
    ),
    ),
    ],
    ),
      Row(
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: Color.fromARGB(255, 85, 145, 141),
            child: Icon(
              Icons.arrow_upward,
              color: Colors.white,
              size: 19,
            ),
          ),
          SizedBox(width: 7),
          Text(
            'Total Expenses',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color.fromARGB(255, 216, 216, 216),
            ),
          ),
        ],
      ),
    ],
    ),
    ),
      SizedBox(height: 6),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$ ${income()}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            Text(
              '\$ ${expenses()}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Color.fromARGB(255, 85, 145, 141),
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
                SizedBox(width: 7),
                Text(
                  'Today Income',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color.fromARGB(255, 216, 216, 216),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Color.fromARGB(255, 85, 145, 141),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
                SizedBox(width: 7),
                Text(
                  'Today Expenses',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color.fromARGB(255, 216, 216, 216),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 6),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$ ${Todayincome()}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            Text(
              '\$ ${Todayexpenses()}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      )


    ],
    ),
    ),
    )
      ],
    );
  }
}