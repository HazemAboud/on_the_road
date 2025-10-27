import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedDistance = 'Kilometer';
  String selectedEfficency = 'KmL';
  TextEditingController dist = TextEditingController();
  TextEditingController eff = TextEditingController();
  TextEditingController pc = TextEditingController();
  String result = "";
  bool dInvalid = false;
  bool eInvalid = false;
  bool pInvalid = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Road: Fuel Cost Estimator'),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Image.asset('assets/fuel.png', scale: 2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextField(
                        controller: dist,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Distance',
                          errorText: dInvalid ? 'Invalid Input' : null
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: DropdownButton<String>(
                        value: selectedDistance,
                        items: [
                          DropdownMenuItem(
                            value: 'Kilometer',
                            child: Text('Kilometer'),
                          ),
                          DropdownMenuItem(value: 'Mile', child: Text('Mile')),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDistance = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextField(
                        controller: eff,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Efficiency',
                          errorText: eInvalid ? 'Invalid Input' : null
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: DropdownButton<String>(
                        value: selectedEfficency,
                        items: [
                          DropdownMenuItem(value: 'KmL', child: Text('Km/L')),
                          DropdownMenuItem(
                            value: 'MileL',
                            child: Text('Mile/L'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedEfficency = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextField(
                        controller: pc,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Price',
                          errorText: pInvalid ? 'Invalid Input' : null
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: Text('RM/L', style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      double distance = double.tryParse(dist.text) ?? 0;
                      double efficiency = double.tryParse(eff.text) ?? 0;
                      double price = double.tryParse(pc.text) ?? 0;
                      if(distance ==0 || efficiency ==0 || price ==0){
                        if(distance ==0){
                        dInvalid = true;
                        }else{
                          dInvalid = false;
                        }
                        if(efficiency==0){
                          eInvalid = true;
                        }else{
                          eInvalid = false;
                        }
                        if(price ==0){
                          pInvalid = true;
                        }else{
                          pInvalid = false;
                        }
                      }else{
                        dInvalid = false;
                        eInvalid = false;
                        pInvalid = false;
                        result = calculate(distance, efficiency, price);
                      }
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 235, 228, 228),
                      foregroundColor: Colors.deepOrangeAccent,
                    ),
                    child: Text('Calculate'),
                  ),
                ),
                SizedBox(height: 10),
                if (result.isNotEmpty)
                  Text(result, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String calculate(double distance, double efficiency, double price) {
    if (selectedDistance == 'Mile') {
      distance = distance * 1.60934;
    }
    if (selectedEfficency == 'MileL') {
      efficiency = efficiency * 1.60934;
    }
    double cost = distance / efficiency * price;

    return "The estimated cost of your trip is RM" + cost.toStringAsFixed(2);
  }
}
