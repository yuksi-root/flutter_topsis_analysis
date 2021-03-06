import 'package:flutter/material.dart';
import 'package:flutter_topsis_analysis/core/extension/context_extension.dart';
import 'package:flutter_topsis_analysis/components/utils.dart';
import 'package:flutter_topsis_analysis/core/constants/data.dart';

class NormalizationTable extends StatefulWidget {
  const NormalizationTable({
    Key? key,
  }) : super(key: key);

  @override
  _NormalizationTableState createState() => _NormalizationTableState();
}

class _NormalizationTableState extends State<NormalizationTable> {
  late List<dynamic> rowData;
  late List<dynamic> columnData;

  @override
  void initState() {
    super.initState();

    this.rowData = List.of(Data.NormalizationRowData);
    this.columnData = List.of(Data.columnData);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          height: context.mediaQuery.size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: SizedBox(), flex: 1),
              Expanded(
                child: Container(
                  color: Color(0xff1c0f45),
                  child: Center(
                    child: Text(
                      "Normalize Karar Matrisi",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w300, color: Colors.white),
                    ),
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                flex: 20,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: buildDataTable(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildDataTable() {
    return Center(
        child: Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(20),
        child: Table(
          defaultColumnWidth: FixedColumnWidth(120.0),
          border: TableBorder.all(
              color: Colors.black, style: BorderStyle.solid, width: 1),

          children: [getColumns(), ...getRows()], //liste kopyalama kodu
        ),
      ),
    ]));
  }

  TableRow getColumns() {
    return TableRow(
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.black, style: BorderStyle.solid, width: 1),
      ),
      children: Utils.modelBuilder(
        columnData,
        (i, column) {
          return InkWell(
              customBorder: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 0.5),
              highlightColor: Colors.pinkAccent,
              hoverColor: Colors.purpleAccent,
              child: Ink(
                color: Color(0xff00b2ee),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        column.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {});
        },
      ),
    );
  }

  List<TableRow> getRows() => rowData.map((row) {
        return TableRow(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 0.5),
          ),
          children: Utils.modelBuilder(row['row'], (index, cell) {
            return InkWell(
              customBorder: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 0.5),
              child: Ink(
                color: row['isRow'] && index != 0
                    ? Colors.white
                    : Color(0xff00b2ee),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Text(
                      cell is int
                          ? cell.toString()
                          : cell is double
                              ? cell.toStringAsFixed(4)
                              : cell.toString(),
                      style: row['isRow'] && index != 0
                          ? TextStyle(fontWeight: FontWeight.normal)
                          : TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ),
              onTap: () {},
            );
          }),
        );
      }).toList();
}
