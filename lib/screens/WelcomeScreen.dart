library finance_management_app.globals;

import 'dart:async';
import 'dart:developer';

//import 'package:finance_management_app/Components/WelcomeBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

//import 'package:permission_handler/permission_handler.dart' ;
//import 'package:notification_permissions/notification_permissions.dart';

import 'dart:io' show Platform;

import '../component/bottomnavigationbar.dart';
import '../data/model/add_date.dart'; // phiên bản OS




class WelcomeScreen extends StatefulWidget  {
  //const WelcomeScreen({Key? key}) : super(key: key);
   const WelcomeScreen({ super.key});



  /*const WelcomeScreen({super.key});*/
  /*const WelcomeScreen({Key? key}) : super(key: key);*/




  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}
//with TickerProviderStateMixin

class  WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  Timer? timer,timer2;

  Map<String, dynamic> Map1 = <String, dynamic>{};
  Map<String, dynamic> Map2 = <String, dynamic>{};
  late String user ="";
  var finalMap ;
  var db = FirebaseFirestore.instance;
  var history;
  var All;
  var All2;
  bool isShrink = false;
  bool isNotStorage = false;
  int _counter = 0;
  late  AnimationController animationController;
  static late  Animation<double> animation;
  //PermissionStatus _permissionStatus = PermissionStatus.denied;
  Box<Add_data> box = Hive.box<Add_data>('data');

  bool userT = false ;
  bool dataT = true;


  /*showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK",style: TextStyle(fontSize: 22),),
      onPressed: () {Permission.storage.request();
      Navigator.pop(context, 'OK');
        },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Lưu ý",style: TextStyle(fontSize: 24)),
      content: Text("Ứng dụng cần quyền truy cập lưu trữ để lưu lại các chi tiêu của bạn",style: TextStyle(fontSize: 21)),
      actions: [
        okButton,
      ],
    );
    *//*Visibility visible= Visibility(
      visible: isNotStorage ? true : false,
      child: alert,
    );*//*

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }*/

  void getUser() async {




    final docRef = db.collection("ACC").doc("Admin");
    docRef.get().then((value) {
      setState(() {
        user = value.get('name');
        log('TUNG1: $user');
        userT = true;
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
    /*docRef.get().then((value) {
      setState(() {
        All = value.docs.toString();
        log('All1: $All');
      });
    });*/

    await docRef.get().then(
          (querySnapshot) {
        for (var value in querySnapshot.docs) {
         /* print('${value.id} => ${value.data()}');
          Map1 = value.data();*/
          GetOwnData(value);
          //finalMap.addAll(Map1);
      /*    log('All1: $Map1');*/
          don1 = true;

        }
      },
      onError: (e) => print("Error completing: $e"),
    );



    final docRef2 = db.collection("ACC").doc("Admin").collection("Income");
   /* docRef2.get().then((value) {
      setState(() {
        All2 = value.docs.toString();
        log('All2: $All2');
      });
    });*/

    await docRef2.get().then(
          (querySnapshot) {
        for (var value in querySnapshot.docs) {
         /* print('${value.id} => ${value.data()}');
          Map2 = value.data();*/
          GetOwnData(value);

          //finalMap.addAll(Map2);
         /* log('All2: $Map2');*/
          don2 = true;

        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    if(don1 == true && don2 == true) {
      dataT = true;


      /*finalMap = [Map1,Map2];
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
      }*/
    }

  }

  void switchPage(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Bottom(user : user),
        ),
        ModalRoute.withName("/Home")
    );
  }




  void _isShrink()  {
    setState(()   {
      isShrink = true;
      _counter++;
      //_isNotShrink();
      log('isShrink = $isShrink');

      getUser();


      if(box.length == 0){
         getNewData();
      }

      if(userT == true && dataT == true) {
       switchPage();
      }
      timer2 = Timer(const Duration(milliseconds: 1200),() {
        switchPage();
      });
    /*  if(_permissionStatus.isRestricted || _permissionStatus.isDenied || _permissionStatus.isPermanentlyDenied || _permissionStatus.isLimited){
        showAlertDialog(context);
        log('isNotStorage = $isShrink');
        //Permission.storage.request();
      }*/

    });
  }
/*  void _listenForPermissionStatus() async {
    final status = await Permission.storage.status;
    setState(() => _permissionStatus = status);
  }*/


  @override
  void initState() {
    super.initState();

    /*_listenForPermissionStatus();*/

    /*permissionStatusFuture = getCheckNotificationPermStatus();*/

    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.2,
      upperBound: 1.0,
      duration: Duration(seconds: 1),
      //reverseDuration: Duration(milliseconds: 5),
    )..reverse()//..repeat(reverse: true)
      ;

    //animation =  Tween(begin: 255, end: 50).animate(animationController) as Animation<double>;
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );

//milliseconds: 500
   //timer = Timer(Duration(seconds: 5),() { animation =  Tween(begin: 0, end: 255).animate(animationController) as Animation<double>;});
timer = Timer(const Duration(milliseconds: 500),() {
  _isShrink();

  /*Future<PermissionStatus> permissionStatus =
  NotificationPermissions.getNotificationPermissionStatus();

  if(permissionStatusFuture== permDenied ||permissionStatusFuture== permProvisional  || permissionStatusFuture== permUnknown){
    NotificationPermissions.requestNotificationPermissions(
        iosSettings: const NotificationSettingsIos(
            sound: true, badge: true, alert: true));
      // when finished, check the permission status

  }*/


  /*if(await Permission.accessNotificationPolicy.status.isDenied){
    Permission.accessNotificationPolicy.request();
  }*/
  /*if(await Permission.notification.status.isDenied){
    Permission.notification.request();
  }*/

});

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom, //Ẩn Status bar
    ]);

  }

  @override
  void dispose() {
    timer?.cancel();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
      backgroundColor: Color.fromRGBO(89, 138, 116, 1),
      body:
      Container(
        width: double.infinity,
        height: size.height,
        child:  Stack(
          children:  <Widget>[
            Positioned.fill(
              child:  Align(
               alignment: const Alignment(0, -0.6),
                child:
                    //----------------------
                /*Image.asset(
                  'assets/images/moneysavingicon.png',
                  width: isShrink ? size.width/3 : size.width/1.1,
                  height: isShrink ? size.height/3 : size.width/1.1,
                  //fit: BoxFit.none,
                ),*/
                    //---------------------------------
                AnimatedContainer(
                  width: isShrink ? size.width/3 : size.width/1,
                  height: isShrink ? size.height/3 : size.width/1,
                  //scale: welcomeScreen.WelcomeScreenState.animation,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  child:
                  Image.asset(
                    'images/moneysavingicon.png',
                    //width: size.width/1.5,
                    //height: size.height/1.5,
                    //fit: BoxFit.none,
                  ),
                ),
              ),
              // ),
            ),
            if(isShrink)
               Positioned.fill(
                child: Align(
                  alignment: Alignment(0, -.1),
                  child:
                  Text(
                    'MoneySaver',
                    style: TextStyle(fontSize: 48, color: Colors.yellowAccent),
                    //fit: BoxFit.none,
                  ),
                ),
                // ),
              ),

    //-------------------------------------------------
    // set up the AlertDialog

           /* if(isNotStorage)
            AlertDialog(
              title: Text("Lưu ý") ,
              content: Text("Ứng dụng cần quyền truy cập lưu trữ để lưu lại các chi tiêu của bạn"),
              actions: <Widget>[
                TextButton(
                  child: Text("ok"),
                  onPressed: () {
                    Permission.storage.request();
                  },
                ),
              ],
            )*/
//-----------------------------------------------------------------





          ],
        ),
      ),




    );
  }

}
