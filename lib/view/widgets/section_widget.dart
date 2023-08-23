import 'package:flutter/material.dart';
import 'package:question_app/model/question_model.dart';
import 'package:question_app/view/widgets/dropdown_widget.dart';

class SectionWidget extends StatelessWidget {
  final QuestionField questionField;

  const SectionWidget({
    super.key,
    required this.questionField,
  });

  @override
  Widget build(BuildContext context) {
    // Extract data from the sectionData map
    String sectionName = questionField.schema.name;
    String sectionLabel = questionField.schema.label;
    List<SubField> fields = questionField.schema.fields ?? [];

    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sectionLabel,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.0),
          for (var field in fields) FieldWidget(fieldData: field),
        ],
      ),
    );
  }
}

class FieldWidget extends StatelessWidget {
  final SubField fieldData;

  const FieldWidget({super.key, required this.fieldData});

  @override
  Widget build(BuildContext context) {
    // Extract data from the fieldData map
    String fieldName = fieldData.schema.name;
    String fieldLabel = fieldData.schema.label;

    return Column(
      children: [
       

        if (fieldData.type == 'Numeric')
          TextFormField(
            decoration: InputDecoration(labelText: fieldLabel),
            keyboardType: TextInputType.number,
            // You can add logic here to handle numeric input.
          )
        else if (fieldData.type == 'Label')
          Text(
            fieldLabel,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          )
        else if(fieldData.type=='SingleSelect')
        DropDownWidget(questionSchema: fieldData.schema)
       // Handle other field types as needed
      ],
    );

    // Check the field type and display accordingly
  }
}
