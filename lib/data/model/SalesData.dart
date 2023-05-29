


class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;

  @override
  String toString() {
    return 'SalesData{year: $year, sales: $sales}';
  }
}

class SalesData2 {
  SalesData2(this.year, this.sales);
  final DateTime  year;
  final int sales;

  @override
  String toString() {
    return 'SalesData{year: $year, sales: $sales}';
  }
}