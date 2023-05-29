import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/model/SalesData.dart';
import '../data/model/add_date.dart';
import '../data/utlity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';




class Chart extends StatefulWidget {
   int indexx;
   int type; //1:Thu , 0: Chi
   List<Add_data> data ;


  /*const Chart(this.indexx, this.type, this.data, {super.key});*/

  Chart({Key? key, required this.indexx, required this.data, required this.type}) : super(key: key);




  @override
  State<Chart> createState() => _ChartState();


}

class _ChartState extends State<Chart> {
  List<Add_data>? a;
  List<Add_data>? duong ;
  List<SalesData>? newsale;
  late bool m ;
  bool b = true;
  bool j = true;
  late List <SalesData2> newTol;
  late String type ;
  late bool NotIn = true;
  var box = Hive.box<Add_data>('data');


/*
  @override
  void initState() {
    super.initState();
    List<Add_data> kq = SortIn(1);//log('w
  } //bool  m = true;
*/
  @override
  Widget build(BuildContext context) {

    List<String> sortedDays = ["Monday","Tuesday", "Wednesday","Thursday", "Friday","Saturday","Sunday"];

    if(widget.type == 0) {
      type = 'Chi';
    } else {
      type = 'Thu';
    }

    switch (widget.indexx) {
      case 0:
        a = today(widget.data);//.cast<Add_data>();
        duong = today(box.values.toList());
        duong?.sort((a, b) => a.datetime.compareTo(b.datetime)) ;
        b = true;
        j = true;
        break;
      case 1:
        a = week(widget.data);//.cast<Add_data>();
        duong = week(box.values.toList());
        duong?.sort((a, b) => a.datetime.compareTo(b.datetime)) ;
        b = false;
        j = true;
        m = false;
        log('week: a : $a?');
        log('week : duong : $duong');

        break;
      case 2:
        a = month(widget.data);//.cast<Add_data>();
        duong = month(box.values.toList());
        duong?.sort((a, b) => a.datetime.compareTo(b.datetime)) ;
        b = false;
        j = true;
        m = true;
        break;
      case 3:
        a = year(widget.data);//.cast<Add_data>();
        duong = year(box.values.toList());
        duong?.sort((a, b) => a.datetime.compareTo(b.datetime)) ;
        b = false;
        j = false;
        break;
      default:
    }
    log('a.lenght: ${a?.length}');

    List<Add_data>? AddEmpty(List<Add_data>? A ,List<Add_data>? B){
      for (int c = 0; c < B!.length; c++) {
        //a.add(history2[c]);
        NotIn = true; // kiem tra xem co trung khong
        bool done = false;
        for (int i = 0; i < A!.length; i++) {
          if (B[c].datetime.compareTo(A[i].datetime)==0 && B[c].amount == A[i].amount &&B[c].IN == A[i].IN &&  B[c].name == A[i].name) {
            NotIn = false;
          }
          if(i == (A.length)-1) done = true;
          }

        if(done && NotIn ){
          Add_data tmp = Add_data(
              B[c].IN,
              "0",
              B[c].datetime,
              B[c].explain,
              B[c].name);//&& B[c].datetime.compareTo(A[i].datetime)==0
          A.add(tmp);
          log('Add to A: ${tmp.toString()}');
        }


        }
      A?.sort((a, b) => a.datetime.compareTo(b.datetime));
      log('B list: ${B.toString()}');
      log('A list: ${A.toString()}');

      return A;

      }

    List<SalesData> GenList(List<Add_data>? data,int type){
      newTol = time(data!, b ? true : false);
       newsale = <SalesData>[
        ...List.generate(newTol.length, (index) { //time(a!, b ? true : false).length
          return SalesData(
              j
                  ? b
                  ? newTol[index].year.hour.toString()
                  : !m
                  ? newTol[index].year.weekdayName().toString()
                  : newTol[index].year.day.toString()
                  : newTol[index].year.day.toString() +"/" + newTol[index].year.month.toString(),
                         newTol[index].sales);


/*
              b
                  ? index > 0
                  ? time(data!, true)[index] + time(data!, true)[index - 1]
                  : time(data!, true)[index]
                  : index > 0
                  ? time(data!, false)[index] +
                  time(data!, false)[index - 1]
                  : time(data!, false)[index]);*/

        })
      ];


      if(widget.indexx == 1) {
        newsale?.sort((a, b) => sortedDays.indexOf(a.year).compareTo(sortedDays.indexOf(b.year)));
      }

      log('newTol: $newTol');
      if(type == 0) {
        log('newsale COT: ${newsale?.toString()}');
      }
      if(type == 1) {
        log('newsale Duong: ${newsale?.toString()}');
      }
      return newsale!;
    }


    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior( enable: true),
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries<SalesData, String>>[
          ColumnSeries<SalesData, String>(
            color: Color.fromARGB(255, 47, 125, 121),
            width: 0.3, //3,
            name:type,
            dataSource: GenList(AddEmpty(a, duong),0),//newsale!,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              emptyPointSettings: EmptyPointSettings(
                // Mode of empty point
                  mode: EmptyPointMode.drop,
              )

          ),

          LineSeries<SalesData, String>(
            name:'Số dư Thu Chi',
            dataSource: GenList(duong!,1),//newsale!,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true),



          )


        ],





/*        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            color: Color.fromARGB(255, 47, 125, 121),
            width: 3,
            dataSource: <SalesData>[
              ...List.generate(time(a!, b ? true : false).length, (index) { //time(a!, b ? true : false).length
                return SalesData(
                    j
                        ? b
                        ? a![index].datetime.hour.toString()
                        : !m
                        ? a![index].datetime.day.toString()
                        : a![index].datetime.month.toString()
                        : a![index].datetime.year.toString(),

                    b
                        ? index > 0
                        ? time(a!, true)[index] + time(a!, true)[index - 1]
                        : time(a!, true)[index]
                        : index > 0
                        ? time(a!, false)[index] +
                        time(a!, false)[index - 1]
                        : time(a!, false)[index]);
              })
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          )
        ],*/
      ),
    );
  }
}

