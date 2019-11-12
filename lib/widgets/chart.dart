import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/transaction.dart';



class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String,Object>> get getTheTransactionValue{
    return List.generate(7, (index){
      final weekDay=DateTime.now().subtract(Duration(days: index),);

      var totalAmount=0.0;

      for(var i=0;i<recentTransaction.length;i++){
        if(recentTransaction[i].date.day==weekDay.day && recentTransaction[i].date.month==weekDay.month && recentTransaction[i].date.year==weekDay.year){
          totalAmount+=recentTransaction[i].amount;
        }

      }

      print(DateFormat.E().format(weekDay) );
      print(totalAmount);

      return {'day':DateFormat.E().format(weekDay),'amount':totalAmount};

    }).reversed.toList();

  }


  double get totalSpendingInWeek{
    return getTheTransactionValue.fold(0.0, (sum,item){
 
      return sum+item['amount'];

    });
  }

  @override
  Widget build(BuildContext context) {

    print(getTheTransactionValue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getTheTransactionValue.map((data){
        
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'], data['amount'], totalSpendingInWeek==0.0 ? 0.0 : (data['amount'] as double)/totalSpendingInWeek));         

          }).toList(),
        ),
      ),
      
    );
  }
}