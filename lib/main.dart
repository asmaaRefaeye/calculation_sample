import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'calculator app',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pink,
        accentColor: Colors.pinkAccent,
      ),
    )
  );
}
class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _SIFormState();
  }

}
class _SIFormState extends State<SIForm>{
  var _formKey =GlobalKey<FormState>();

    var _currences =['Rupes' ,'Dollars','Pounds'];
    final _minimumPadding=5.0;
    var _currentItemselected = '';


    @override
    void initState() {
      super.initState();
       _currentItemselected = _currences[0];
    }

    TextEditingController principleController =TextEditingController();
    TextEditingController roiController =TextEditingController();
    TextEditingController termController =TextEditingController();

    var displayResult ='';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(top:_minimumPadding,bottom: _minimumPadding),
        child: ListView(
          children: <Widget>[
          getImageAssets(),

           Padding(
            padding: EdgeInsets.only(top:_minimumPadding,bottom: _minimumPadding),
            child:TextFormField(
              keyboardType: TextInputType.number,
              style: textStyle,
              controller: principleController,
              validator: (String value){
                if(value.isEmpty){
                  return 'please enter principle amount';
                }
              },
              decoration: InputDecoration(
                labelText: 'principal',
                    hintText: 'Enter Pricipal e.g.1200',
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  color: Colors.amberAccent
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            )),

         Padding(
             padding: EdgeInsets.only(top:_minimumPadding,bottom: _minimumPadding),
             child:TextFormField(
            keyboardType: TextInputType.number,
               style: textStyle,
            controller: roiController,
               validator: (String value){
                 if(value.isEmpty){
                   return 'please enter right rate';
                 }
               },
            decoration: InputDecoration(
                labelText: 'Rate of Interest',
                hintText: 'In Percent',
                labelStyle: textStyle,
                errorStyle: TextStyle(
                    color: Colors.amberAccent
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                )
            ),
          )),

           Padding(
               padding: EdgeInsets.only(top:_minimumPadding,bottom: _minimumPadding),
               child: Row(
              children: <Widget>[
               Expanded(child : TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: termController,
                 validator: (String value){
                   if(value.isEmpty){
                     return 'please enter term of years';
                   }
                 },
                  decoration: InputDecoration(
                      labelText: 'Term',
                      hintText: 'Time in year',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                          color: Colors.amberAccent
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )),

              Container(width: _minimumPadding*5,),
              Expanded(child :  DropdownButton <String>(
                    items: _currences.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                }).toList(),
                    value: _currentItemselected,
                     onChanged: (String newValueSelected){

                      _onDrowpdownItemSelected(newValueSelected);
                     },))
                
              ],
            )),

           Padding(
               padding: EdgeInsets.only(top:_minimumPadding,bottom: _minimumPadding),
               child: Row(children: <Widget>[

              Expanded(
                  child :RaisedButton(
                    color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child:Text('Calculate'),
                      onPressed: (){
                        setState(() {
                          if(_formKey.currentState.validate()) {
                            this.displayResult = _calculateTotalReturns();
                          }
                        });
                      })
              ),

              Expanded(
                  child :RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child:Text('Reset'),
                      onPressed: (){
                         setState(() {
                           _reset();
                         });
                      })
              )

            ],)),

            Padding(
              padding: EdgeInsets.all(_minimumPadding*2.0),
              child: Text(this.displayResult,style: textStyle,),
            )
          ],
        )),
      ),
    );


  }
    Widget getImageAssets (){
         AssetImage assetImage = AssetImage("images/ic_snow.png");
         Image image = Image(image: assetImage,width: 125.0,height: 125.0,);

         return Container(child:image , margin: EdgeInsets.all(_minimumPadding*10),);
    }


    void _onDrowpdownItemSelected(String newValueSelected) {

      setState((){
        this._currentItemselected=newValueSelected;
      });

    }

    String _calculateTotalReturns(){

    double princpale = double.parse(principleController.text);
    double roi=double.parse(roiController.text);
    double term =double.parse(termController.text);

    double totalAmountPayable = princpale+(princpale * roi * term )/100;
    String result ='After $term years , your investment will be $totalAmountPayable $_currentItemselected';
    return result;

    }

    void _reset(){
    principleController.text='';
    roiController.text='';
    termController.text='';
    displayResult='';
    _currentItemselected=_currences[0];
    }
}
