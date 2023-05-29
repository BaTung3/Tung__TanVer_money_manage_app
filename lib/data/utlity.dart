import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../data/model/add_date.dart';
import 'model/SalesData.dart';

int totals = 0;
int totalstoday = 0;


 Box<Add_data> box = Hive.box<Add_data>('data');

int total() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}


int income() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? int.parse(history2[i].amount) : 0);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int expenses() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? 0 : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}


int totalToday() {
  var history2 = today(box.values.toList());
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  totalstoday = a.reduce((value, element) => value + element);
  return totalstoday;
}

int Todayincome() {
  var history2 = today(box.values.toList());
      List a = [0, 0];
      for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? int.parse(history2[i].amount) : 0);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int Todayexpenses() {
  var history2 = today(box.values.toList());
      List a = [0, 0];
      for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? 0 : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List<Add_data> SortIn(int z) {
  //i = 0 -chi =1 thu
  box = Hive.box<Add_data>('data');
  List<Add_data> a = [];
  var history3 = box.values.toList();
  log('history3: ${history3.length.toString()}');
  log('SortIn: $z');

  for (var i = 0; i < history3.length; i++) {
    switch(z) {
      case 0:
        if (history3[i].IN == 'Expense') {
          a.add(history3[i]);
        }
        break; // The switch statement must be told to exit, or it will execute every case.
      case 1:
        if (history3[i].IN == 'Income') {
          a.add(history3[i]);
        }
        break;
    }
  }
  return a;
}

List<Add_data> today(List<Add_data> data) {
  List<Add_data> a = [];
  //var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < data.length; i++) {
    if (data[i].datetime.day == date.day) {
      a.add(data[i]);
    }
  }
  return a;
}

List<Add_data> week(List<Add_data> data) {
  List<Add_data> a = [];
  DateTime date = new DateTime.now();
  //var history2 = box.values.toList();
  for (var i = 0; i < data.length; i++) {
    if (date.day - 7 < data[i].datetime.day &&
        data[i].datetime.day <= date.day) {
      a.add(data[i]);
    }
  }
  return a;
}

List<Add_data> month(List<Add_data> data) {
  List<Add_data> a = [];
  //var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < data.length; i++) {
    if (data[i].datetime.month == date.month) {
      a.add(data[i]);
    }
  }
  return a;
}

List<Add_data> year(List<Add_data> data) {
  List<Add_data> a = [];
  //var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < data.length; i++) {
    if (data[i].datetime.year == date.year) {
      a.add(data[i]);
    }
  }
  return a;
}

int total_chartInt(List<Add_data> historyz) {
  List a = [0, 0];


  for (var i = 0; i < historyz.length; i++) {
    a.add(historyz[i].IN == 'Income'
        ? int.parse(historyz[i].amount)
        : int.parse(historyz[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

SalesData2 total_chart(List<Add_data> historyz) {
  List a = [0, 0];
  SalesData2 tmp;

  for (var i = 0; i < historyz.length; i++) {
    a.add(historyz[i].IN == 'Income'
        ? int.parse(historyz[i].amount)
        : int.parse(historyz[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  tmp = SalesData2(historyz[0].datetime, totals);
  return tmp;
}

List<SalesData2> time(List<Add_data> history2, bool hour) {
  List<Add_data> a = [];
  List <SalesData2> total = [];
  int counter = 0;
  log('FOR history 2: ${history2.length.toString()}');
/*if(history2.isEmpty) {
  total.add(0);
  log('Total Null: ${total.toString()}');
  log('Total Null lenght: ${total.length.toString()}');
  print(total);
  return total;
} else*/ if(history2.length == 1) {
    total.add(SalesData2(history2[0].datetime, int.parse(history2[0].amount)));
    log('Total 1: ${total.toString()}');
    print(total);
    return total;
  }
  else {
    for (var c = 0; c < history2.length; c++) {
      //a.add(history2[c]);
      log('history c: ${history2[c]}');
      for (var i = c; i < history2.length; i++) {
        /*log('for i: $i');*/
        log('history i: ${history2[i]}');
        if (hour) {
          if (history2[i].datetime.hour == history2[c].datetime.hour) {
            a.add(history2[i]);
            counter = i;
          }
        } else {
          if (history2[i].datetime.day == history2[c].datetime.day) {
            a.add(history2[i]);
            counter = i;
            log('for counter: $counter');
          }
        }
      }
      total.add(total_chart(a)); //tổng tất cả có trùng ngày ( trừ cái đang xét)
      a.clear();
      c = counter;
    }
    log('TotalSaleData2 : ${total.toString()}');
    print(total);
    return total;
  }
}

extension DateTimeExtension on DateTime {
  String? weekdayName() {
    const Map<int, String> weekdayName = {1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday", 7: "Sunday"};
    return weekdayName[weekday];
  }
}