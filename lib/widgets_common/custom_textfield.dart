// ignore_for_file: prefer_const_constructors

import 'package:food/consts/consts.dart';
class customTextField extends StatelessWidget {
  late final Function(String) onChanged;
  final Function(String) onSubmitted;
  String title;
  String? hint;
  final TextInputAction textInputAction;
   final bool isPasswordField;
  customTextField({
    required this.onChanged,
    required this.onSubmitted,
    required this.textInputAction,
    required this.title,
    required this.hint, 
    required this.isPasswordField,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        // controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        textInputAction: textInputAction,
        obscureText: isPasswordField,
      ),
      5.heightBox,
    ],
  );
  }
}
