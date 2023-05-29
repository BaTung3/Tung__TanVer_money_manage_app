import 'package:flutter/material.dart';
import 'package:moneyapp_v1/screens/home.dart';
import '../screens//add.dart';
import '../screens/statisticsCHI.dart';
import '../screens/statisticsTHU.dart';
import 'package:moneyapp_v1/screens/statisticsTHU.dart' as Thu;



class Bottom extends StatefulWidget {
  String user;
  Bottom({Key? key, required this.user}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index_color = 0;
  late List Screen;

    UpdateOther(){
    setState(() {
      Screen = [new Home1(callback: UpdateOther,user : widget.user), new StatisticsTHU(update: true), new StatisticsCHI(update: true),new Home1(callback: UpdateOther,user : widget.user)];
      Update1();
      Update2();
      /*
      for (var widg  in Screen) {
        widg.setState();
      }*/
      // Call setState to refresh the page.
    });
  }


  @override
  Widget build(BuildContext context) {
    Screen = [Home1(callback: UpdateOther,user : widget.user), StatisticsTHU(update: true), StatisticsCHI(update: true),new Home1(callback: UpdateOther,user : widget.user)];

    return Scaffold(
      body: Screen[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) =>  Add_Screen(callback :UpdateOther)));
        },
        backgroundColor: const Color(0xff368983),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: index_color == 0 ? const Color(0xff368983) : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(
                  //Icons.bar_chart_outlined,
                  Icons.savings,
                  size: 30,
                  color: index_color == 1 ?   const Color(0xff368983) : Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 30,
                  color: index_color == 2 ? const Color(0xff368983) : Colors.grey,
                ),
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                  });
                },


                child: Icon(
                  Icons.person_outlined,
                  size: 30,
                  color: index_color == 3 ? const Color(0xff368983) : Colors.grey,
                ),


              ),
            ],
          ),
        ),
      ),
    );
  }





}

