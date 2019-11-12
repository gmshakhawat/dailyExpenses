import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController=TextEditingController();
  final _priceController=TextEditingController();
  DateTime _selectedDate;

  void _submitData()
  {
    if(_priceController.text.isEmpty)
    {
      return;
    }
    final enteredTitle=_titleController.text;
    final enteredPrice=double.parse(_priceController.text);

    if(enteredTitle.isEmpty || enteredPrice<=0 || _selectedDate==null)
    {
      return;
    }
    widget.addTx(enteredTitle,enteredPrice,_selectedDate);

    Navigator.of(context).pop();
  }


  void _presentDatePicker(){

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
      ).then((pickedDate){
          if(pickedDate==null)
          {
            return;
          }

          setState(() {
            _selectedDate=pickedDate;
          });

      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
              
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_)=>_submitData()
                ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                controller: _priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_)=>_submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Expanded(
                        child: Text(
                          _selectedDate==null 
                          ?'No Date Chosen !':
                          'Picked Dtae : ${DateFormat.yMd().format(_selectedDate)
                          }',
                          style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Conventry'
                          ),

                        )
                      ),
                      FlatButton(
                        child: Text('Chose Date',
                        style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).primaryColorDark,
                          ),
                        ),

                        onPressed: _presentDatePicker,

                      )
                    ],
                  ),
                ),

              RaisedButton(
                child: Text('Add'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).buttonColor,
                onPressed:_submitData,
              )

            ],),
          ),
        );
  }
}
