import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placement_cell_app/constants/colors.dart';
import 'package:placement_cell_app/models/user_profile.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/routes/arguments.dart';
import 'package:placement_cell_app/services/job_services.dart';
import 'package:placement_cell_app/services/user_profile.dart';
import 'package:placement_cell_app/utils/errorCallback.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as JobDetails;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Job Details",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: queryData.size.height,
        width: queryData.size.width,
        padding: EdgeInsets.all(10),
        color: secondaryColor,
        child: Column(children: [
          Container(
            height: queryData.size.height * 0.79 - 20,
            width: queryData.size.width,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white70,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          args.job.role,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(args.job.companyName,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87)),
                        Text("${args.job.package}  |  ${args.job.location} ",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87)),
                        Text("Last Date : ${args.job.lastDate}",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87))
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                builddetails("Description", args.job.description),
                builddetails("Requirements", args.job.requiredSkills!),
                builddetails(
                    "Eligibility Criteria", args.job.eligibilityCriteria!),
              ]),
            ),
          ),
          Consumer<AuthProvider>(
              builder: (context, userdata, child) => StreamBuilder<
                      QuerySnapshot>(
                  stream:
                      UserProfileService().userProfileStream(userdata.userId),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
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
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: queryData.size.height * 0.1,
                          width: queryData.size.width,
                          padding: EdgeInsets.all(20),
                          child: _profiles.length!=0 && _profiles[0].appliedJobs!
                                  .where((element) => element == args.job.jobId)
                                  .isNotEmpty
                                  ? Center(
                                  child: Text(
                                  "You Applied for this Job",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ))
                               :ElevatedButton(
                                  child: const Text(
                                    "Apply",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    if (args.job.jobId == null) {
                                      toastMesssage(
                                          "Something Went Wrong Try Again.Try Again");
                                    } else {
                                      JobServices()
                                          .applyJobs(
                                              args.job.jobId!,
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .userId,
                                              (e) => toastMesssage(e))
                                          .then((value) => {});
                                    }
                                  },
                                )
                              
                        ),
                      );
                    }
                  }))
        ]),
      ),
    );
  }

  Container builddetails(title, String des) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white70,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ReadMoreText(
              des,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
              trimLines: 4,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: TextStyle(fontSize: 15, color: Colors.blue),
            ),
            // Text(args.job.description,style: TextStyle(fontSize: 16,color: Colors.black54))
          ],
        ));
  }
}
