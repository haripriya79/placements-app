import 'package:flutter/material.dart';
import 'package:placement_cell_app/models/personal_profile.dart';
import 'package:placement_cell_app/models/user_profile.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/services/user_profile.dart';
import 'package:placement_cell_app/utils/errorCallback.dart';
import 'package:placement_cell_app/utils/validators.dart';
import 'package:provider/provider.dart';

class BuildPersonalInfo extends StatefulWidget {
  BuildPersonalInfo({Key? key, required this.nextInfo}) : super(key: key);

  final Function nextInfo;

  @override
  State<BuildPersonalInfo> createState() => _BuildPersonalInfoState();
}

class _BuildPersonalInfoState extends State<BuildPersonalInfo> {
  var _formKey = GlobalKey<FormState>(debugLabel: "_personalProfile");
  late String _name;

  late int _mobileNumber;

  late String _dateOfBirth;

  late String _address;

  late String _gender;

  bool _loading = false;

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
                  "Personal Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                )),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                validator: validateText,
                onSaved: (val) => _name = val!,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Name',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Mobile Number",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                validator: validateMobile,
                onSaved: (val) => _mobileNumber = int.parse(val!),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Mobile Number',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Gender",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == "") {
                    return "Select the Gender";
                  }
                },
                onSaved: (val) => _gender = val!,
                items: const [
                  DropdownMenuItem(
                    child: Text("Select the Gender"),
                    value: "",
                  ),
                  DropdownMenuItem(child: Text("Female"), value: "female"),
                  DropdownMenuItem(
                    child: Text("Male"),
                    value: "male",
                  ),
                  DropdownMenuItem(
                    child: Text("Others"),
                    value: "others",
                  ),
                ],
                onChanged: (val) {},
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                ),
                value: "",
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Date Of Birth",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                maxLength: 10,
                keyboardType: TextInputType.text,
                validator: validateText,
                onSaved: (val) => _dateOfBirth = val!,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                  hintText: '01/01/2000',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                validator: validateText,
                onSaved: (val) => _address = val!,
                minLines: 6,
                maxLines: 20,
                maxLength: 500,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Address',
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
                 // widget.nextInfo();
                  final _form = _formKey.currentState;

                  if (_form != null && _form.validate()) {
                    _form.save();
                    UserProfile user = UserProfile(
                        userId:
                            Provider.of<AuthProvider>(context, listen: false)
                                .userId,
                        personalProfile: PersonalProfile(
                            address: _address,
                            dateOfBirth: _dateOfBirth,
                            gender: _gender,
                            mobileNumber: _mobileNumber,
                            name: _name));
                            setState(() {
                               _loading = true;
                            });
                   
                    UserProfileService()
                        .createUserProfile(
                            user, (e) => toastMesssage(e.message))
                        .then((value) {
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
