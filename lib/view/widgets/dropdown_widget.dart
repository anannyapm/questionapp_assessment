import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/model/question_model.dart';
import 'package:question_app/view/widgets/custom_text.dart';
import 'package:question_app/viewmodel/app_viewmodel.dart';

class DropDownWidget extends StatelessWidget {
  final dynamic questionSchema;

  const DropDownWidget({super.key, required this.questionSchema});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppViewModel>(context);

    final List<Option> options = questionSchema.options ?? [];
    log(options.map((e) => e.value).toList().toString());
    model.qKey = questionSchema.name;
    if (!model.userAnswers.containsKey(model.qKey)) {
      model.userAnswers[model.qKey] = options[0].value;
      model.qValue = options[0].value;
    } else {
      model.qValue = model.userAnswers[model.qKey];
    }

    if (questionSchema.name == "Property located city") {
      if (model.selectedCity == "") {
        model.selectedCity = options[0].value;
      }
    } else if (questionSchema.name == "Property located state") {
      if (model.selectedState == "") {
        model.selectedState = options[0].value;
      }
    } else {
      if (model.selectedBank == "") {
        model.selectedBank = options[0].value;
      }
    }
    log(model.selectedBank + model.selectedCity + model.selectedState);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: questionSchema.label ?? "", size: 18),
        const SizedBox(height: 5),
        DropdownButton<String>(
          value: questionSchema.name == "Property located state"
              ? model.selectedState
              : questionSchema.name == "Property located city"
                  ? model.selectedCity
                  : model.selectedBank,
          onChanged: (newValue) {
            log(questionSchema.name);
            model.qKey = questionSchema.name;

            if (questionSchema.name == "Property located state") {
              model.setSelectedState(newValue!);
              model.qValue = newValue;
            } else if (questionSchema.name == "Property located city") {
              model.qValue = newValue;
              model.setSelectedCity(newValue!);
            } else {
              model.qValue = newValue;
              model.setSelectedBank(newValue!);
            }
            model.setUserAnswer();
          },
          underline: Container(),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: options.map((state) {
            return DropdownMenuItem<String>(
              value: state.value,
              child: Text(state.value),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
