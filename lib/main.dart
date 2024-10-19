import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const List list = ['cm', 'km', 'm'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController firstTextController = TextEditingController();
  final TextEditingController secondTextController = TextEditingController();

  String selectedValue1 = 'cm';
  String selectedValue2 = 'cm';

  void updateResult(double result){
    secondTextController.text = result.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Converter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Center(
            child: Text('Mobile Converter', style: TextStyle(fontSize: 30),),
          ),
          Row(
            children: [
          SizedBox(width: 50,),
          CustomTextField(controller: firstTextController, Mutedable: false,),
          SizedBox(width: 30,),
          dropDownList(
            onValueChanged: (value){
            setState(() {
              selectedValue1 = value;
            });
            },
          ),
            ],
          ),
          SizedBox(height: 30,),
          Text('TO', style: TextStyle(fontSize: 20)),
          SizedBox(height: 30,),
          Row(
            children: [
          SizedBox(width: 50,),
          CustomTextField(controller: secondTextController, Mutedable: true,),
          SizedBox(width: 30,),
          dropDownList(
            onValueChanged: (value) {
              setState(() {
                selectedValue2 = value;
              });
            },
          ),
            ],
          ),
          SizedBox(height: 30,),
          CustomButton(firstTextController: firstTextController, firstDropdownValue: selectedValue1,secondDropdownValue: selectedValue2, onResult: updateResult,),
        ],
          )
      );
  }
}

class CustomTextField extends StatelessWidget{
  final TextEditingController controller;
  final bool Mutedable;

  CustomTextField({required this.controller, required this.Mutedable});
  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: 200,
      child: TextField(
        readOnly: Mutedable,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: controller.text,
        )
      )
    );
  }
}

class CustomButton extends StatefulWidget{
  final TextEditingController firstTextController;
  final String firstDropdownValue;
  final String secondDropdownValue;
  final Function(double) onResult;
  CustomButton({
    required this.firstTextController,
    required this.firstDropdownValue,
    required this.secondDropdownValue,
    required this.onResult,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  final dataProcess processor = dataProcess();
  double result = 0;


  void typeOfConverter(double a, String type1, String type2){
    if(type1 == "cm" && type2 == "km"){
      result = processor.CmtoKm(a);
    }else if(type1 == "cm" && type2 == "m"){
      result = processor.CmtoM(a);
    }else if(type1 == "km" && type2 == "cm"){
      result = processor.KmtoCm(a);
    }else if(type1 == "km" && type2 == "m"){
      result = processor.KmtoCm(a);
    }else if(type1 == "m" && type2 == "cm"){
      result = processor.MtoCm(a);
    }else if(type1 == "m" && type2 == "km"){
      result = processor.MtoKm(a);
    }else{
      print('INVALID');
    }
    print(result);
    widget.onResult(result);
  }

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        String firstInput = widget.firstTextController.text;
        double a = double.parse(firstInput);
        typeOfConverter(a, widget.firstDropdownValue, widget.secondDropdownValue);
        print('First Input : $a \n\nDrop Input ${widget.firstDropdownValue} \nDropInput 2 : ${widget.secondDropdownValue}');
      },
      child: const Text('Submit')
    );
  }
}

class dropDownList extends StatefulWidget{
  final Function(String) onValueChanged;
  const dropDownList({super.key, required this.onValueChanged});
  @override
  State<dropDownList> createState() => _dropDownListState();
}

class _dropDownListState extends State<dropDownList> {
  String dropDownValue = list.first;

  @override

Widget build(BuildContext context) {
    return DropdownMenu(
      width: 95,
      initialSelection: list.first,
      onSelected: ( value) {
        // This is called when the user selects an item.
        setState(() {
          dropDownValue = value!;
        });
      widget.onValueChanged(dropDownValue);
      },
      dropdownMenuEntries: list.map((value) {
        return DropdownMenuEntry(value: value, label: value);
      }).toList(),
    );
  }
}

class dataProcess{
  double CmtoKm(double cm){
    return cm*0.00001;
  }

  double CmtoM(double cm){
    return cm/100;
  } 
  double KmtoM(double km){
    return km/1000;
  }
  double KmtoCm(double km){
    return km/100000;
  }
  double MtoKm(double m){
    return m/1000;
  }
  double MtoCm(double m){
    return m/100;
  }
}