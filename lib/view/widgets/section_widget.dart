import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/model/question_model.dart';
import 'package:question_app/view/constants/color_constants.dart';
import 'package:question_app/view/widgets/dropdown_widget.dart';
import 'package:question_app/viewmodel/app_viewmodel.dart';

import 'custom_text.dart';

class SectionWidget extends StatelessWidget {
  final QuestionField questionField;

  const SectionWidget({
    super.key,
    required this.questionField,
  });

  @override
  Widget build(BuildContext context) {
    List<SubField> fields = questionField.schema.fields ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var field in fields) FieldWidget(fieldData: field),
      ],
    );
  }
}

class FieldWidget extends StatelessWidget {
  final SubField fieldData;

  const FieldWidget({super.key, required this.fieldData});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppViewModel>(context);
    if (fieldData.type == 'Numeric') {
      model.qKey = fieldData.schema.label;

      if (!model.userAnswers.containsKey(fieldData.schema.label)) {
        model.qValue = '0';
      } else {
        model.qValue = model.userAnswers[fieldData.schema.label];
        
      }
        model.incomeController.text = model.qValue.toString();

    }

    String fieldLabel = fieldData.schema.label;

    return Column(
      children: [
        if (fieldData.type == 'Numeric')
          TextFormField(
            controller: model.incomeController,
            focusNode: FocusNode(),
            decoration: InputDecoration(
                labelText: fieldLabel, border: const OutlineInputBorder()),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              model.qValue = value;
            },

            // onFieldSubmitted:(val)=> Provider.of<AppViewModel>(context,listen: false)
            //     .setUserAnswer(val, fieldData.schema.name),
          )
        else if (fieldData.type == 'Label')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomText(
              text: "**$fieldLabel",
              color: kWarning,
            ),
          )
        else if (fieldData.type == 'SingleSelect')
          DropDownWidget(questionSchema: fieldData.schema)
        // Handle other field types as needed
      ],
    );

    // Check the field type and display accordingly
  }
}
