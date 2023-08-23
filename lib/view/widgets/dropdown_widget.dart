import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/model/question_model.dart';
import 'package:question_app/viewmodel/app_viewmodel.dart';

class DropDownWidget extends StatelessWidget {
  final dynamic questionSchema;
  const DropDownWidget({super.key, required this.questionSchema});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppViewModel>(context);
    final List<Option> options = questionSchema.options!;
    model.selectedState=options.first.key;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //  Text(
        //   questionSchema.label,
        //   style: TextStyle(fontSize: 18),
        // ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: model.selectedState,
          onChanged: (newValue) {
            model.setSelection(newValue!);
          },
          items: options.map((state) {
            return DropdownMenuItem<String>(
              value: state.key,
              child: Text(state.value),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
