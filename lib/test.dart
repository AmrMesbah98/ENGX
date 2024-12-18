import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Text Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Search Text'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Call the function to perform text search
              searchItems(_searchController.text);
            },
            child: Text('Search'),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('all courses').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Display search results or all items
                // Adjust the logic based on your requirements
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var document = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(document['nameCourse']),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> searchItems(String searchText) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('all courses')
        .where('nameCourse', isGreaterThanOrEqualTo: searchText)
        .where('nameCourse', isLessThan: searchText + 'z')
        .get();

    querySnapshot.docs.forEach((doc) {
      print(doc.data());


    });
  }
}