import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: IMCStateful(),
    );
  }
}

class IMCStateful extends StatefulWidget{
  @override
  IMCState createState() => IMCState();
}

class IMCState extends State<IMCStateful>{
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  GlobalKey <FormState> formState = GlobalKey<FormState>();
  String messages = "Welcome!!";

  void reiniciar(){
    weight.text = "";
    height.text = "";
    setState(() {
      messages = "Calculate your BMI";
    });
  }

  void calculateBMI(){
    setState(() {
      double weight_d = double.parse(weight.text);
      double height_d = double.parse(height.text);
      double bmi = weight_d / (height_d * height_d);

      if(bmi < 18.5){
        messages = "You are underweight: (your bmi is ${bmi.toStringAsPrecision(2)})";
      }
      else if(bmi>18.5 && bmi<24.9){
        messages = "You are normal: (your bmi is ${bmi.toStringAsPrecision(2)})";
      }
      else if(bmi>25 && bmi<29.9){
        messages = "You are overweight: (your bmi is ${bmi.toStringAsPrecision(2)})";
      }
      else if(bmi>30 && bmi<34.9){
        messages = "You have obesity type 1: (your bmi is ${bmi.toStringAsPrecision(2)})";
      }
      else if(bmi>35 && bmi<39.9){
        messages = "You have obesity type 2: (your bmi is ${bmi.toStringAsPrecision(2)})";
      }
      else {
        messages = "You have obesity type 3: (your bmi is ${bmi.toStringAsPrecision(2)})";
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC APP"),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: reiniciar,
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Form(
          key: formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon( Icons.account_circle_outlined, size: 100, color: Colors.amberAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weight in kilograms",
                  labelStyle: TextStyle(color: Colors.blue)
                ),
                textAlign: TextAlign.center,
                controller: weight,
                style: TextStyle(color: Colors.deepPurple, fontSize: 30.0),
                validator: (value){
                  if(value.isEmpty){
                    return "Weight is empty";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Height in meters",
                    labelStyle: TextStyle(color: Colors.blue)
                ),
                textAlign: TextAlign.center,
                controller: height,
                style: TextStyle(color: Colors.deepPurple, fontSize: 30.0),
                validator: (value){
                  if(value.isEmpty){
                    return "Height is empty";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (formState.currentState.validate()) {
                        calculateBMI();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                messages,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),

    );
  }
}


