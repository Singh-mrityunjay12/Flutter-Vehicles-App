import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:vehicales_details/Models/Details_model.dart';
import 'package:vehicales_details/screens/Screen_one.dart';

class BikeFrom extends StatefulWidget {
  const BikeFrom({super.key});

  @override
  State<BikeFrom> createState() => _BikeFromState();
}

class _BikeFromState extends State<BikeFrom> {
  final TextEditingController modelNumbercontroller = TextEditingController();
  // final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  String dropdownvalue1 = 'TVS';
  String dropdownvalue2 = '100cc';
  String dropdownvalue3 = 'Petrol';

// Future<void> saveDataToFirestore(String dropdownvalue1,String dropdownvalue2,String dropdownvalue3) async {
//   // Make sure a value is selected
//   // ignore: unnecessary_null_comparison
//   if (dropdownvalue1!=null&& dropdownvalue2!=null&& dropdownvalue3!=null) {
//     try {
//        // Add your Firestore collection and document reference
//       DocumentReference docRef = _firestore.collection('BikeDetails').doc();

//       // Save data to Firestore
//       await docRef.set({
//         'createdAt': DateTime.now(),
//         'BrandName': dropdownvalue1,
//         'EngineType': dropdownvalue2,
//         'FuelType': dropdownvalue3,
//         // Add other fields as needed
//       });

//     Get.snackbar(
//       'Message', 'Details saved successfully',
//         backgroundColor: const Color.fromARGB(255, 63, 58, 58),
//         snackPosition: SnackPosition.TOP,
//         colorText: Colors.white,
//     );
//     Get.offAll(()=>const ScreenOne());
//     } catch (e) {
//       Get.snackbar(
//       'Error', '$e',
//         backgroundColor: const Color.fromARGB(255, 63, 58, 58),
//         snackPosition: SnackPosition.TOP,
//         colorText: Colors.white,
//     );
//     }
//   } else {
//     Get.snackbar(
//       'Opps!', 'Please Select all feilds',
//         backgroundColor: const Color.fromARGB(255, 63, 58, 58),
//         snackPosition: SnackPosition.TOP,
//         colorText: Colors.white,
//     );
//   }
// }

  Future<void> saveBikeModelToFirestore(DetailsModel bikeModel) async {
    try {
      EasyLoading.init();
      EasyLoading.show(status: 'Please wait...');
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add your Firestore collection reference
      CollectionReference collectionRef = firestore.collection('BikeDetails');

      // Convert BikeModel instance to Map
      Map<String, dynamic> data = bikeModel.tojson();

      // Save data to Firestore
      await collectionRef.add(data);
      EasyLoading.dismiss();
      Get.snackbar(
        'Message',
        'Details saved successfully',
        backgroundColor: const Color.fromARGB(255, 63, 58, 58),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
      );
      Get.offAll(() => const ScreenOne());
    } catch (e) {
      print('Error saving data to Firestore: $e');
    }
  }

// Example of how to use the saveBikeModelToFirestore function
// void main() async {
//   BikeModel bikeModel = BikeModel(
//     vehicalNumber: '',
//     brandName: 'BrandXYZ',
//     engineType: 'Petrol',
//     fuelType: 'Manual',
//   );

//   await saveBikeModelToFirestore(bikeModel);
// }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicles From"),
      ),
      body: Stack(
        children: [
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: TextFormField(
                            controller: modelNumbercontroller,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                label: const Text("Vehicale Number"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Bike number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Brand Name"),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 50,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownvalue1,
                          items: <String>[
                            'TVS',
                            'Puler',
                            'Hero',
                            'Honda',
                            'KTM'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 15),
                              ),
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue1 = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Engine Type"),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 50,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownvalue2,
                          items: <String>[
                            '100cc',
                            '120cc',
                            '140cc',
                            '150cc',
                            '250cc',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 15),
                              ),
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue2 = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Fuel Type"),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 50,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownvalue3,
                          items: <String>['Petrol', 'Electric']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 15),
                              ),
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue3 = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await saveBikeModelToFirestore(DetailsModel(
                          documentId: '',
                          vehicalNumber: modelNumbercontroller.text.trim(),
                          brandName: dropdownvalue1,
                          engineType: dropdownvalue2,
                          fuelType: dropdownvalue3));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
