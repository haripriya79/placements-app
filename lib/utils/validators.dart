String? validateEmail(String? value, [bool error = false]) {
 
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (error) {
    return value;
  } else if (value != null && value.isEmpty) {
    return "Your Email is required";
  } else if (value != null && !regex.hasMatch(value)) {
    return "Please provide a valid emal address";
  } else {
    return null;
  }
}

String? validatePassword(String? value, [bool error = false]) {
   if (error) {
    return value;
  } else if (value != null && value.isEmpty) {
    return "Password is Required";
  } else if (value != null && value.length < 8) {
    return "Password should be alteast 8 characters";
  }
  return null;
}
String? validateText(String? value, [bool error = false]) {
   if (value != null && value.isEmpty) {
    return "This Field is Required";
  } 
  return null;
}
String? validateMobile(String? value, [bool error = false]) {
   if (value != null && value.isEmpty) {
    return "This Field is Required";
  } else if(value!=null && value.length!=10){
    return "Invalid Mobile Number";
  }
  return null;
}
String? validateName(String? value) {
  if (value != null && value.isEmpty) {
    return "This field is Required";
  }
  return null;
}
