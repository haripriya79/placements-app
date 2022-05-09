import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:placement_cell_app/constants/colors.dart';
import 'package:placement_cell_app/models/user_profile.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/services/user_profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(home: ProfileScreen()));
}

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('bookings').where('userId',isEqualTo: Provider.of<UserProvider>(context).user.userId).snapshots();
    MediaQueryData queryData = MediaQuery.of(context);
     
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.white,
        ),
        body: Consumer<AuthProvider>(
          builder: (context, userdata, child) => StreamBuilder<QuerySnapshot>(
            stream: UserProfileService().userProfileStream(userdata.userId),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                String _docId = "";
                List<UserProfile> _profiles =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  _docId = document.id;
                  return UserProfile.fromJson(data);
                }).toList();
               // UserProfile _profile = _profiles.first;
                return _profiles.isEmpty
                    ? buildCreateProfileButton(queryData, context)
                    : Container(
                        color: secondaryColor,
                        width: queryData.size.width,
                        height: queryData.size.height,
                        padding: EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _profiles[0].image == null
                                  ? Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  _profiles[0].image!))))
                                  : Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                          "assets/profile_pic.svg",
                                          height: 200),
                                    ),
                              buildPersonalInfo(_profiles[0]),
                              buildEducationalInfo(_profiles[0]),
                              buildSkillset(_profiles[0]),
                              (_profiles[0].image == null &&
                                      _profiles[0].resume == null)
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Documents",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            InkWell(
                                                child: Center(
                                                    child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor: primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 100,
                                          child: Center(
                                              child: Text(
                                            "Add Your Doucuments",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18),
                                          )),
                                        )
                                      ]),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                "Documents",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              InkWell(
                                                  child: Center(
                                                      child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),),),
                                            ],
                                          ),
                                        
                                          SizedBox(
                                              height: 60,
                                              width: double.infinity,
                                              child: InkWell(
                                                onTap: (){

                                                  UserProfileService().downloadFileExample(_profiles[0].resume);
                                                },
                                                child: Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                                                    child: Row(children:const [
                                                      Icon(Icons.download),
                                                      SizedBox(width: 10,),
                                                      Text("Resume" , style: TextStyle(fontSize: 18),)
                                                      
                                                    ]),
                                                  ),
                                                ),
                                              ),),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
              }
            },
          ),
        ));
  }

  ListTile builditems1(key, value) {
    return ListTile(
      title: Text(
        key,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }

  Widget buildSkillset(_profile) {
    return _profile.skillSet == null
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Skills",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      child: Center(
                          child: Text(
                    "Edit",
                    style: TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        fontWeight: FontWeight.bold),
                  ))),
                ],
              ),
              const SizedBox(
                height: 100,
                child: Center(
                    child: Text(
                  "Add Your Skills",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                )),
              )
            ]),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Skills",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        child: Center(
                            child: Text(
                      "Edit",
                      style: TextStyle(
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                          fontWeight: FontWeight.bold),
                    ))),
                  ],
                ),
                Text(
                  _profile.skillSet!.join(","),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
  }

  Widget buildEducationalInfo(_profile) {
    return _profile.educationProfile == null
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Education Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      child: Center(
                          child: Text(
                    "Edit",
                    style: TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        fontWeight: FontWeight.bold),
                  ))),
                ],
              ),
              const SizedBox(
                height: 100,
                child: Text("Add Your Education Information",
                    style: TextStyle(color: Colors.grey, fontSize: 18)),
              )
            ]),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Education Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        child: Center(
                            child: Text(
                      "Edit",
                      style: TextStyle(
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                          fontWeight: FontWeight.bold),
                    ))),
                  ],
                ),
                builditems1("Course", _profile.educationProfile!.course),
                builditems1("Branch", _profile.educationProfile!.branch),
                builditems1("Year Of Study",
                    _profile.educationProfile!.year.toString()),
                builditems1(
                    "CGPA (10)", _profile.educationProfile!.cgpa.toString()),
                builditems1("Passing Year",
                    _profile.educationProfile!.passingYear.toString()),
              ],
            ),
          );
  }

  Padding buildPersonalInfo(UserProfile _profile) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Personal Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                  child: Center(
                      child: Text(
                "Edit",
                style: TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: primaryColor,
                    fontWeight: FontWeight.bold),
              ))),
            ],
          ),
          buildItems(Icons.people, "Name", _profile.personalProfile.name),
          buildItems(Icons.phone, "Mobile Number",
              _profile.personalProfile.mobileNumber.toString()),
          buildItems(Icons.person, "Gender", _profile.personalProfile.gender),
          buildItems(Icons.calendar_month, "Date Of Birth",
              _profile.personalProfile.dateOfBirth),
          buildItems(
              Icons.location_on, "Address", _profile.personalProfile.address),
        ],
      ),
    );
  }

  ListTile buildItems(IconData icon, key, value) {
    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(
        key,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }

  Container buildCreateProfileButton(
      MediaQueryData queryData, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: SvgPicture.asset("assets/icons/nothing.svg",
                  height: queryData.size.height * 0.4),
            ),
            SizedBox(
                width: queryData.size.width * 0.5,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/creatProfile");
                    },
                    child: const Text(
                      "Create Profile",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
      ),
    );
  }
}
