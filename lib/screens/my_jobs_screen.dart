import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:placement_cell_app/constants/colors.dart';
import 'package:placement_cell_app/models/jobs.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/routes/arguments.dart';
import 'package:provider/provider.dart';


class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({Key? key}) : super(key: key);
    Stream<QuerySnapshot> jobStream(userId) {
    return FirebaseFirestore.instance
        .collection('jobs')
        .where('applied',  arrayContains:userId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
     MediaQueryData queryData = MediaQuery.of(context);
  
    return Scaffold(
      appBar: AppBar(
       
        centerTitle: true,
        title: Text(
          "My Jobs",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: 
       Consumer<AuthProvider>(
          builder: (context, userdata, child) => StreamBuilder<QuerySnapshot>(
            stream: jobStream(userdata.userId),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                 List<Jobs> _jobs =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  data['id'] = document.id;

                  return Jobs.fromJson(data);
                    }).toList();

                   
          return _jobs.length ==0 ?  Container(
               padding: EdgeInsets.all(30),
               child: Column(
                 children: [
                   SvgPicture.asset("assets/icons/empty.svg",height: queryData.size.height * 0.5),
                   
                 ],
               ),)  : Container(
          color: secondaryColor,
          height: queryData.size.height,
          width: queryData.size.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView.builder(
            itemBuilder: (context, index) {
             
              return SizedBox(
               
                width: double.infinity,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _jobs[index].role,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                       
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        _jobs[index].companyName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                     
                     
                     if(_jobs[index].location!=null) Text(
                        _jobs[index].location!,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                       Text(
                       "Package: "+ _jobs[index].package,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(onPressed: (){Navigator.of(context).pushNamed("/jobDetails",arguments: JobDetails(_jobs[index]));}, child: Text("View Detials",style: TextStyle(fontWeight: FontWeight.w700),)))
                      
                    ],
                  ),
                )),
              );
            },
            itemCount: _jobs.length,
          ));
          }
            },
          ),
        )
    );
  }
}