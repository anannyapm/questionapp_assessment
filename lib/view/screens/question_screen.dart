import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/view/constants/color_constants.dart';
import 'package:question_app/view/screens/output_screen.dart';
import 'package:question_app/view/widgets/custom_text.dart';
import 'package:question_app/view/widgets/dropdown_widget.dart';
import 'package:question_app/view/widgets/section_widget.dart';
import 'package:question_app/view/widgets/slide_navigator.dart';
import 'package:question_app/viewmodel/app_viewmodel.dart';
import 'package:question_app/viewmodel/navigator_viewmodel.dart';

import '../../model/question_model.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppViewModel>(context);
    final navModel = Provider.of<NavigatorViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 10, left: 10),
          child: CustomText(
            text: "About loan",
            weight: FontWeight.bold,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: model.isLoading
            ? const CircularProgressIndicator()
            : model.questionsField.isEmpty
                ? const CustomText(text: "Data Could not be Loaded!")
                : Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ...List.generate(
                                model.questionLength,
                                (index) => SlideNavigator(
                                      isActive: index == navModel.barNavigator,
                                    )),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: model.questionsField[navModel.currentPage]
                                  .schema.label,
                              size: 20,
                              weight: FontWeight.w600,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            if (model.questionsField[navModel.currentPage]
                                    .type ==
                                'SingleChoiceSelector')

                              //handle logic to check on selcting balance transfer
                              SingleChoiceSelector(
                                  questionData: model
                                      .questionsField[navModel.currentPage],
                                  model: model,
                                  questionKey: model
                                      .questionsField[navModel.currentPage]
                                      .schema
                                      .label)
                            else if (model.questionsField[navModel.currentPage]
                                    .type ==
                                'Section')
                              SectionWidget(
                                questionField:
                                    model.questionsField[navModel.currentPage],
                              )
                            else if (model.questionsField[navModel.currentPage]
                                        .type ==
                                    'SingleSelect' &&
                                model.userAnswers['Type of loan'] ==
                                    'Balance transfer & Top-up')
                              DropDownWidget(
                                  questionSchema: model
                                      .questionsField[navModel.currentPage]
                                      .schema)
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (navModel.currentPage > 0) {
                                  if (model
                                              .questionsField[
                                                  navModel.currentPage - 1]
                                              .type ==
                                          'SingleSelect' &&
                                      model.showQuestion == false) {
                                    navModel.currentPage--;
                                    navModel.moveBackwards();
                                  } else {
                                    navModel.moveBackwards();
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_left,
                                    color: kBlack,
                                    size: 30,
                                  ),
                                  CustomText(
                                    text: 'Back',
                                    color: kBlack,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(kOrange),
                                  foregroundColor:
                                      MaterialStatePropertyAll(kWhite),
                                  iconSize: const MaterialStatePropertyAll(35)),
                              onPressed: () {
                                if (navModel.currentPage <
                                    model.questionsField.length - 1) {
                                  model.setUserAnswer();
                                  if (model
                                              .questionsField[
                                                  navModel.currentPage + 1]
                                              .type ==
                                          'SingleSelect' &&
                                      model.showQuestion == false) {
                                    navModel.currentPage++;
                                    navModel.moveForward();
                                  } else {
                                    navModel.moveForward();
                                  }
                                } else {
                                  model.setUserAnswer();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => OutputScreen(
                                          loanDetails: model.userAnswers)));
                                }
                              },
                              icon: const Icon(Icons.keyboard_arrow_right),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class SingleChoiceSelector extends StatelessWidget {
  const SingleChoiceSelector({
    super.key,
    required this.questionData,
    required this.model,
    required this.questionKey,
  });
  final QuestionField questionData;
  final AppViewModel model;
  final String questionKey;

  @override
  Widget build(BuildContext context) {
    final data = questionData.schema.options;
    if (!model.userAnswers.containsKey(questionKey)) {
      model.qKey = questionKey;
      model.qValue = data?[0].value;
    } else {
      model.qKey = questionKey;
      model.qValue = model.userAnswers[questionKey];
    }
    log(model.userAnswers.toString());

    return data == null
        ? Container()
        : ListView.separated(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final option = data[index];
              final optionKey = option.value;
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: model.userAnswers[questionKey] == optionKey
                          ? kOrange
                          : kBlack),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      autofocus: true,
                      activeColor: kOrange,
                      value: optionKey,
                      groupValue: model.userAnswers.containsKey(questionKey)
                          ? model.userAnswers[questionKey]
                          : data[0].value,
                      onChanged: (value) {
                        model.qKey = questionKey;
                        model.qValue = value;
                        model.setUserAnswer();
                      },
                    ),
                    CustomText(
                        text: option.value,
                        color: model.userAnswers[questionKey] == optionKey
                            ? kOrange
                            : kBlack),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
          );
  }
}
