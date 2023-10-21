import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../provider/provider_class.dart';

class AddPlants extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPlantsState();
  }
}

class AddPlantsState extends State<AddPlants> {
  // DateTime _selectedDate = DateTime.now();
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    ).then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  String? dropdownvalue;
  List<String> item = [
    "alpines",
    "aquatic",
    "bulbs",
    "succulents",
    "carnivorous",
    "climbers",
    "ferns",
    "grasses",
    "trees",
  ];

  final name = TextEditingController();
String dropValue =  "empty";
  final enabledBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide(color: Colors.black),
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListProvider>(context);
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Add Your Plants",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(""),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Add Plant Name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.black45,
                  style: const TextStyle(fontSize: 19, color: Colors.black),
                  controller: name,
                  maxLines: 1,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter Plant Name',
                    enabledBorder: enabledBorder,
                    border: enabledBorder,
                    focusedBorder: enabledBorder,
                    labelStyle:
                        const TextStyle(fontSize: 17, color: Colors.black54),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Select the plant type",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    color: const Color(0xFF9aa4b9).withOpacity(0.10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      hint: const Text("Select plant type"),
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFF19232d)),
                      value: dropdownvalue,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 25,
                        color: Color(0xFF9aa4b9),
                      ),
                      items: item.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          // vehicleId = item.indexOf(newValue)+1;
                          // print(vehicleId);
                          print(dropdownvalue);
                          dropValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Select the planting date",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: _presentDatePicker,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9aa4b9).withOpacity(0.10),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9)),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _selectedDate != null
                              ? "${_selectedDate?.toLocal()}".split(' ')[0]
                              : 'Enter date',
                          style: TextStyle(
                            fontSize: _selectedDate != null ? 16 : 14,
                            color: _selectedDate != null
                                ? const Color(0xFF19232d)
                                : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    final pickupDate = _selectedDate;
                    final word = name.text.trim();

                    if (name.text.isNotEmpty && pickupDate != null && dropValue != "Select plant type" && dropValue != "empty" ) {
                      provider.addItem(word);
                      print(provider.words);
                      Navigator.pop(context);
                    }
                    else if (name.text.isEmpty || pickupDate == null || dropValue != "Select plant type" || dropValue != "empty") {
                      Fluttertoast.showToast(
                          msg: "All Field Is Required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black38,
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
