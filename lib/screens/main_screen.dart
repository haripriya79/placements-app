import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:placement_cell_app/constants/colors.dart';
import 'package:placement_cell_app/models/jobs.dart';
import 'package:placement_cell_app/models/user_profile.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/routes/arguments.dart';
import 'package:placement_cell_app/services/user_profile.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  Stream<QuerySnapshot> jobStream() {
    
    return FirebaseFirestore.instance
        .collection('jobs')
        .where('type', isEqualTo: "Ongoing")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          //Icon
          IconButton(onPressed: (){
            Provider.of<AuthProvider>(context,listen: false).signout();
          }, icon: Icon(Icons.logout,color: Colors.black,))
          
        ],
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Image.asset(
                'assets/jntua_logo.png',
                height: 40,
                width: 40,
              ),
              Text(
                "Placemant Cell ",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
      body: Container(
        height: queryData.size.height,
        width: queryData.size.width,
        color: secondaryColor,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            buildDetailsContainer(queryData, context),
            SizedBox(
              height: 20,
            ),
            buildJobsContainer(queryData, context),
            buildJobsOffCampusContainer(queryData)
          ]),
        ),
      ),
    );
  }

  Container buildJobsContainer(MediaQueryData queryData, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
        child: StreamBuilder<QuerySnapshot>(
            stream: jobStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Row(
                  children: [
                    const Text(
                      "Ongoing Jobs in Campus",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
                  ],
                );
              } else {
                List<Jobs> _jobs =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  data['id'] = document.id;

                  return Jobs.fromJson(data);
                }).toList();

              print(_jobs.length);
              return Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Ongoing Jobs in Campus",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed('/viewAll',
                          arguments: ViewAllJobsArguments(_jobs)),
                      child: const Center(
                        child: Text(
                          "View All",
                          style: TextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: queryData.size.width * 0.9,
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _jobs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("/jobDetails",
                                arguments: JobDetails(_jobs[index]));
                          },
                          child: Card(
                            color: Colors.white,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _jobs[index].companyName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _jobs[index].role,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _jobs[index].package,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]);
            }
          }),
    );
  }

  Container buildJobsOffCampusContainer(MediaQueryData queryData) {
    return Container(
      //height: 260,

      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "OffCampus Jobs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InkWell(
              child: Center(
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
            stream: jobStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else {
                List<Jobs> _jobs =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  data['id'] = document.id;

                  return Jobs.fromJson(data);
                }).toList();
                print(_jobs.length);
                return SizedBox(
                  width: queryData.size.width * 0.9,
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _jobs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Card(
                          color: Colors.white,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _jobs[index].companyName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                _jobs[index].role,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                _jobs[index].package,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ]),
    );
  }

  buildDetailsContainer(MediaQueryData queryData, context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: primaryColor),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SizedBox(
          width: queryData.size.width * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Consumer<AuthProvider>(
              builder: (context, userdata, child) {
                print(userdata.userId);
                return StreamBuilder<QuerySnapshot>(
                stream: UserProfileService().userProfileStream(
                   userdata.userId),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                      print(snapshot.hasError);
                  if (snapshot.hasError) {
                    return Text(
                     "0",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    );
                  } else if(snapshot.connectionState == ConnectionState.waiting){
                    return Text(
                     "0",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    );
                  } 
                  else {
                    print(snapshot.data);
                    String _docId = "";
                    List<UserProfile> _profiles =
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      _docId = document.id;
                      return UserProfile.fromJson(data);
                    }).toList();
                    
                    return _profiles.length==0 ?Text(
                      "0",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ) : Text(
                      _profiles[0].appliedJobs == null
                          ? "0"
                          : _profiles[0].appliedJobs!.length.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    );
                  }
                },
              );
  }),
              Text(
                "Applied Jobs",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Container(
          height: 80,
          color: Colors.white30,
          width: 2,
        ),
        SizedBox(
          width: queryData.size.width * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: jobStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        "0",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      );
                    } 
                    else if(snapshot.connectionState == ConnectionState.waiting){
                    return Text(
                     "0",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    );
                  }  else {
                      List<Jobs> _jobs =
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        data['id'] = document.id;

                        return Jobs.fromJson(data);
                      }).toList();

                      return Text(
                       _jobs==null ? "0": _jobs.length.toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      );
                    }
                  }),
              const Text(
                "Ongoing Jobs",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Container(
          height: 80,
          color: Colors.white30,
          width: 2,
        ),
        SizedBox(
          width: queryData.size.width * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "0",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    "%",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Text(
                "Profile Completion",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
