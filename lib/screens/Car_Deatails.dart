import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Models/Details_model.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  late Future<List<DetailsModel>> carModelsFuture;

  @override
  void initState() {
    super.initState();
    carModelsFuture = fetchCarModels();
  }
  Future<List<DetailsModel>> fetchCarModels() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionRef = firestore.collection('CarDetails');

  QuerySnapshot querySnapshot = await collectionRef.get();

  return querySnapshot.docs.map((doc) {
    return DetailsModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }).toList();
}

Future<void> deleteCarModel(String documentId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection('CarDetails');

    await collectionRef.doc(documentId).delete();
    setState(() {
      print('==========hello===============');
      carModelsFuture = fetchCarModels();
    });
  }
  

   @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DetailsModel>>(
      future: fetchCarModels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        } else {
          List<DetailsModel> carModels = snapshot.data!;
          return ListView.builder(
            itemCount: carModels.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('Vehicle Number: ${carModels[index].vehicalNumber}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Brand: ${carModels[index].brandName}'),
                      Text('Engine Type: ${carModels[index].engineType}'),
                      Text('Fuel Type: ${carModels[index].fuelType}'),
                    ],
                  ),
                  trailing: IconButton(onPressed: (){
                         deleteCarModel(carModels[index].documentId);
                  },icon: const Icon(Icons.clear_rounded),),
                ),
              );
            },
          );
        }
      },
    );
  }
}
