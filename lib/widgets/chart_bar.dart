import 'package:flutter/material.dart';


class ChartBar extends StatelessWidget {
  final String lebel;
  final double spendingAmount;
  final double spendingPercentage;

  ChartBar(this.lebel, this.spendingAmount, this.spendingPercentage);




  @override
  Widget build(BuildContext context) {
    return Column(
      
        children: <Widget>[
         
          Container(
            height: 20,
            child: FittedBox(
              child: Text('৳${spendingAmount.toStringAsFixed(0)}')
              ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 90,
            width: 10,
            child: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),


                )
            ],),
            
          ),
          SizedBox(
            height: 4,
          ),
          Text(lebel),




        ],
    );
  }
}