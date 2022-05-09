import 'package:flutter/material.dart';
import 'package:placement_cell_app/models/education_profile.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/services/user_profile.dart';
import 'package:placement_cell_app/utils/errorCallback.dart';
import 'package:placement_cell_app/utils/validators.dart';
import 'package:provider/provider.dart';

class BuildEducationInfo extends StatefulWidget {
  BuildEducationInfo({Key? key, required this.nextInfo}) : super(key: key);
  
  final Function nextInfo;
 

  @override
  State<BuildEducationInfo> createState() => _BuildEducationInfoState();
}

class _BuildEducationInfoState extends State<BuildEducationInfo> {
  bool _loading = false;

  late String _branch;

  late int _year;

  late String _course;

  late double _cgpa;
var _formKey= GlobalKey<FormState>(debugLabel: "_personalProf");
  late int _passingYear;
    @override


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            width: queryData.size.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Educational Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                )),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Branch",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                validator: validateText,
                onSaved: (val) => _branch = val!,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Branch',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Current Year",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                validator: validateText,
                onSaved: (val) => _year = int.parse(val!),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Current Year',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Course",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                validator: validateText,
                onSaved: (val) => _course = val!,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Course',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Current CGPA(10)",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                validator: validateText,
                onSaved: (val) => _cgpa = double.parse(val!),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your CGPA',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Passing Year",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                validator: validateText,
                onSaved: (val) => _passingYear = int.parse(val!),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                  hintText: 'Passing Year',
                ),
              ),
            ]),
          ),
        ),
        Container(
            width: double.infinity,
            padding: EdgeInsets.all(30),
            height: 100,
            child: ElevatedButton(
                onPressed: () {
                  //widget.nextInfo();
                  
                  final _form = _formKey.currentState;
                  
                  if (_form != null && _form.validate()) {
                    _form.save();
                    EducationProfile edu = EducationProfile(
                        branch: _branch,
                        year: _year,
                        cgpa: _cgpa,
                        course: _course,
                        passingYear: _passingYear);
                        setState(() {
                          _loading = true;
                        });
                    
                    UserProfileService()
                        .updateEducationProfile(
                            edu,
                            (e) => toastMesssage(e.message),
                            Provider.of<AuthProvider>(context,listen: false).userId)
                        .then((value) {
                          print(value);
                      if (value) {
                        widget.nextInfo();
                      }
                      setState(() {
                        _loading = false;
                      });
                      
                    });
                  }
                },
                child: !_loading
                    ? const Text(
                        "Save & Continue",
                        style: TextStyle(fontSize: 20),
                      )
                    : Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white,),
                        ),
                      )))
      ],
    );
  }
}
