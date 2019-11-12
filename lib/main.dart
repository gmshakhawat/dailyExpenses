import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.blueGrey,
        fontFamily: 'Hand1',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'Hand1',
            fontSize: 20,
          ),
          button: TextStyle(
            color: Colors.white,
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'Fontleroy',
              fontSize: 42,
            
            )
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



final List<Transaction> _transaction=[];

  void _addNewTransaction(String txTitle,double txPrice,DateTime txDate){

    final newTx=Transaction(title: txTitle,amount: txPrice,date: txDate,
    id: DateTime.now().toString());

    setState(() {
      _transaction.add(newTx);
    });
  }



void _startAddNewTransaction(BuildContext ctx){
  showModalBottomSheet(context: ctx,builder: (_){
    return NewTransaction(_addNewTransaction);

  },);
}


List<Transaction> get _recentTransactions{
  return _transaction.where((tx){
    return tx.date.isAfter(
      DateTime.now().subtract(Duration(days: 7)),
    );
  }).toList();
}

void _deleteTransaction(String id){

  setState(() {

        _transaction.removeWhere((tx){
        return tx.id==id;
      });

  });

  
}


 @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      
        title: Text('Daily Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()=>_startAddNewTransaction(context),
            
            ),
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
          
                children: <Widget>[
              
                Chart(_recentTransactions),
                TransactionList(_transaction,_deleteTransaction),
              
              ],),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> _startAddNewTransaction(context),
      ),
        
    );
  }
}


