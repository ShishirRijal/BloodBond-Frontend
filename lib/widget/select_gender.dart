import 'package:flutter/material.dart';
import 'package:bloodbond/utils/utils.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  TextEditingController genderController = TextEditingController();

  List<String> genderitems = ["", "Male", "Female"];

  bool showHint = true;
  @override
  void initState() {
    super.initState();
    genderController = TextEditingController(text: genderitems.first);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xffF7F7FB),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: DropdownButton(
          items: genderitems.map((valueItem) {
            // to map each item in the genderitems list into a DropdownMenuItem widget
            return DropdownMenuItem(
              value: valueItem,
              child: Text(valueItem),
            );
          }).toList(),

          // value: valuechoose, // Represents the currently selected value
          // onChanged: (newvalue) {
          //   setState(() {
          //     valuechoose = newvalue;
          //   });
          // },
          value: genderController.text.isEmpty ? null : genderController.text,

          onChanged: (newvalue) {
            setState(() {
              genderController.text = newvalue as String;
            });
          },

          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Constants.kGrey),
          underline: const SizedBox(), //to remove underline
          isExpanded: true,
          hint: Text(
            "Select Gender",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Constants.kGrey,
                ),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 20,
          ),
          dropdownColor: Colors.white,

          //to transform mapped string into list
        ),
      ),
    );
  }

  @override
  void dispose() {
    genderController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }
}
