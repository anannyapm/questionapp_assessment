import 'package:flutter/material.dart';
import 'package:question_app/view/widgets/custom_text.dart';

class OutputScreen extends StatelessWidget {
  final Map loanDetails;
  const OutputScreen({super.key, required this.loanDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Loan Details",
          weight: FontWeight.bold,
          size: 28,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: loanDetails.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        CustomText(
                          text: '${entry.key}:',
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: '${entry.value}',
                            size: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
