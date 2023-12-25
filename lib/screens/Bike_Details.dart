
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Models/Details_model.dart';

class BikeDetails extends StatefulWidget {
  const BikeDetails({super.key});

  @override
  State<BikeDetails> createState() => _BikeDetailsState();
}

class _BikeDetailsState extends State<BikeDetails> {
   late Future<List<DetailsModel>> carModelsFuture;

  @override
  void initState() {
    super.initState();
    carModelsFuture = fetchBikeModels();
  }
  Future<List<DetailsModel>> fetchBikeModels() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionRef = firestore.collection('BikeDetails');

  QuerySnapshot querySnapshot = await collectionRef.get();

  // return querySnapshot.docs.map((doc) {
  //   return DetailsModel.fromMap(doc.data() as Map<String, dynamic>);
  // }).toList();

  return querySnapshot.docs.map((doc) {
      return DetailsModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
}

Future<void> deletebikeModel(String documentId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection('BikeDetails');

    await collectionRef.doc(documentId).delete();
    setState(() {
      print('==========hello===============');
      carModelsFuture = fetchBikeModels();
    });
  }

   @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DetailsModel>>(
      future: fetchBikeModels(),
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
          List<DetailsModel> bikeModels = snapshot.data!;
          return ListView.builder(
            itemCount: bikeModels.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('Vehicle Number: ${bikeModels[index].vehicalNumber}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Brand: ${bikeModels[index].brandName}'),
                      Text('Engine Type: ${bikeModels[index].engineType}'),
                      Text('Fuel Type: ${bikeModels[index].fuelType}'),
                    ],
                  ),
                  trailing: IconButton(onPressed: (){
                    deletebikeModel(bikeModels[index].documentId);
                  }, icon: const Icon(Icons.clear_rounded)),
                ),
              );
            },
          );
        }
      },
    );
  }
}
