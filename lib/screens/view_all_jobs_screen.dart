import 'package:flutter/material.dart';
import 'package:placement_cell_app/constants/colors.dart';
import 'package:placement_cell_app/models/jobs.dart';
import 'package:placement_cell_app/routes/arguments.dart';

class ViewAllJobsScreen extends StatelessWidget {
  const ViewAllJobsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as ViewAllJobsArguments;

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
          args.jobs[0].type + "  Jobs",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
          color: secondaryColor,
          height: queryData.size.height,
          width: queryData.size.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView.builder(
            itemBuilder: (context, index) {
              var _jobs = args.jobs;
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
            itemCount: args.jobs.length,
          )),
    );
  }
}
