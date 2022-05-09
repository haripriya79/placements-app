import 'package:flutter/material.dart';
import 'package:placement_cell_app/constants/colors.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/services/user_profile.dart';
import 'package:placement_cell_app/utils/errorCallback.dart';
import 'package:provider/provider.dart';

class BuildSkillSet extends StatefulWidget {
  BuildSkillSet({Key? key, required this.nextInfo}) : super(key: key);
  final Function nextInfo;

  @override
  State<BuildSkillSet> createState() => _BuildSkillSetState();
}

class _BuildSkillSetState extends State<BuildSkillSet> {
  
  bool _loading = false;
  List<String> selectedTags = [];

  List<String> _skillTags = [
    "Python",
    "Java",
    "C",
    "C++",
    "Mobile Development",
    "Web Development",
    "html",
    "CSS",
    "JS",
    "Mongo DB"
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "Skill Set",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          )),
        ),
        Wrap(
          direction: Axis.horizontal,
          spacing: 4,
          children: _skillTags.map((category) {
            return Container(
              child: FilterChip(
                label: Text(
                  category,
                ),
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: selectedTags.contains(category)
                        ? Colors.white
                        : Colors.black38),
                selected: selectedTags.contains(category),
                onSelected: (val) {
                  setState(
                    () {
                      if (!val && selectedTags.contains(category)) {
                        selectedTags.remove(category);
                      } else {
                        selectedTags.add(category);
                      }
                    },
                  );
                },
                selectedColor: primaryColor,
                checkmarkColor: Colors.white,
              ),
            );
          }).toList(),
        ),
        Container(
            width: double.infinity,
            padding: EdgeInsets.all(30),
            height: 100,
            child: ElevatedButton(
                onPressed: () {
                  if (selectedTags.length == 0) {
                    toastMesssage("Select Atleast 3 Skills");
                  } else {
                    
                    setState(() {
                      _loading = true;
                    });
                      
                      UserProfileService()
                          .updatSkillSet(
                              selectedTags,
                              (e) => toastMesssage(e.message),
                              Provider.of<AuthProvider>(context,listen: false).userId)
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
                          child: CircularProgressIndicator(color: Colors.black,),
                        ),
                      )))
      ],
    );
    ;
  }
}
