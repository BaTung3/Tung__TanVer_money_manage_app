import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/model/add_date.dart';
import '../data/top.dart';
import '../data/utlity.dart';
import '../component/chart.dart';

List<Add_data> kq = SortIn(0);

class StatisticsCHI extends StatefulWidget {
  bool update;
  StatisticsCHI({Key? key,required this.update}) : super(key: key);

  @override
  State<StatisticsCHI> createState() => _StatisticsCHIState();
}

ValueNotifier kj = ValueNotifier(0);

ValueNotifier watch = ValueNotifier(false);

void Update2() {
  watch.value = true;
}

class _StatisticsCHIState extends State<StatisticsCHI> {


  List day = ['Day', 'Week', 'Month', 'Year'];
  List f = [today(kq), week(kq), month(kq), year(kq)];
  List<Add_data> a = [];
  int index_color = 0;
  late int currenI;


/*
  @override
  void setState(VoidCallback fn) {
    kq = SortIn(0);
  }
*/
 /* @override
  void activate() {
    if(widget.update) {
      setState(() {
        kq = SortIn(1);
        log('press : kq : $kq');
        f = [today(kq), week(kq), month(kq), year(kq)];
        a = f[index_color];
        log('press : a : $a');
        widget.update = false;
      });

    }
  }*/


  @override
  Widget build(BuildContext context) {

    watch.addListener(() {

      setState(() {
        currenI = index_color;
        kj.value = index_color-1;
        kq = SortIn(0);
        log('press : kq : $kq');
        f = [today(kq), week(kq), month(kq), year(kq)];
        a = f[index_color];
        log('press : a : $a');
        watch.value = false;
        kj.value = currenI;
      });
    });

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: kj,
          builder: (BuildContext context, dynamic value, Widget? child) {
            kq = SortIn(0);
            log('press : kq : $kq');
            f = [today(kq), week(kq), month(kq), year(kq)];
            a = f[value];
            log('press : a : $a');            return custom();
          },
        ),
      ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
        slivers: [
    SliverToBoxAdapter(
    child: Column(
    children: [
        SizedBox(height: 20),
    Text(
    'Chi theo thời gian',
    style: TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    ),
    ),
    SizedBox(height: 20),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    ...List.generate(
    4,
    (index) {
    return GestureDetector(
    onTap: () {
    setState(() {
      kq = SortIn(0);
      log('press : kq : $kq');
       f = [today(kq), week(kq), month(kq), year(kq)];

      index_color = index;
    kj.value = index;

      a = f[index];

    });
    },
    child: Container(
    height: 40,
    width: 80,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: index_color == index
    ? Color.fromARGB(255, 47, 125, 121)
        : Colors.white,
    ),
    alignment: Alignment.center,
    child: Text(
    day[index],
    style: TextStyle(
    color: index_color == index
    ? Colors.white
        : Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    ),
    ),
    ),
    );
    },
    ),
    ],
    ),
    ),
      SizedBox(height: 20),
      Chart(
        indexx: index_color,
        data : kq,
        type : 0,
      ),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Spending',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
        /*    Icon(
              Icons.swap_vert,
              size: 25,
              color: Colors.grey,
            ),*/
          ],
        ),
      ),
    ],
    ),
    ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset('images/${a[index].name}.jpg', height: 40),
                    ),
                    title: Text(
                      a[index].name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      ' ${a[index].datetime.year}-${a[index].datetime.day}-${a[index].datetime.month}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      a[index].amount,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: a[index].IN == 'Income' ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
                childCount: a.length,
              ))
        ],
    );
  }
}