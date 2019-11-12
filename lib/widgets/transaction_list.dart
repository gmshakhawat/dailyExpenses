import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';


class TransactionList extends StatelessWidget {
 
  final List<Transaction> transactions;

  final Function txDelete;

  TransactionList(this.transactions,this.txDelete);
  
  @override
  Widget build(BuildContext context) {
 
    return Container(
      height: MediaQuery.of(context).size.height*0.6,
      child: transactions.isEmpty
       ? Column(
        children: <Widget>[

          Text('No transactions added yet!!!'),
          SizedBox(
            height: 10,
          ),
          Container(height: 200,
            child: Image.asset('assets/images/empty_list.png',fit: BoxFit.cover,),
          )
        ],

       )  : ListView.builder(
        itemBuilder: (contex,index){
          return Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text('৳${transactions[index].amount}',)
                    ),
                ),
              ),
              title: Text('${transactions[index].title}',
               style: Theme.of(context).textTheme.title,),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date)
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: ()=>txDelete(transactions[index].id),),
            ),
                
              );
        },
      itemCount:transactions.length,
      ),
    );
  }
}