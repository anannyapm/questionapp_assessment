import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  final String title;
  final String name;
  final String slug;
  final String description;
  final QuestionSchema schema;

  Question({
    required this.title,
    required this.name,
    required this.slug,
    required this.description,
    required this.schema,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        title: json["title"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        schema: QuestionSchema.fromJson(json["schema"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "name": name,
        "slug": slug,
        "description": description,
        "schema": schema.toJson(),
      };
}

class QuestionSchema {
  final List<QuestionField> fields;

  QuestionSchema({
    required this.fields,
  });

  factory QuestionSchema.fromJson(Map<String, dynamic> json) => QuestionSchema(
        fields: List<QuestionField>.from(
            json["fields"].map((x) => QuestionField.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
      };
}

class QuestionField {
  final String type;
  final int version;
  final IndividualQuestionSchema schema;

  QuestionField({
    required this.type,
    required this.version,
    required this.schema,
  });

  factory QuestionField.fromJson(Map<String, dynamic> json) => QuestionField(
        type: json["type"],
        version: json["version"],
        schema: IndividualQuestionSchema.fromJson(json["schema"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "version": version,
        "schema": schema.toJson(),
      };
}

class IndividualQuestionSchema {
  final String name;
  final String label;
  dynamic hidden;
  final bool? readonly;
  final List<Option>? options;
  final List<SubField>? fields;

  IndividualQuestionSchema({
    required this.name,
    required this.label,
    this.hidden,
    this.readonly,
    this.options,
    this.fields,
  });

  factory IndividualQuestionSchema.fromJson(Map<String, dynamic> json) =>
      IndividualQuestionSchema(
        name: json["name"],
        label: json["label"],
        hidden: json["hidden"],
        readonly: json["readonly"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        fields: json["fields"] == null
            ? []
            : List<SubField>.from(
                json["fields"]!.map((x) => SubField.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "label": label,
        "hidden": hidden,
        "readonly": readonly,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "fields": fields == null
            ? []
            : List<dynamic>.from(fields!.map((x) => x.toJson())),
      };
}

class SubField {
  final String type;
  final int version;
  final SubSchema schema;

  SubField({
    required this.type,
    required this.version,
    required this.schema,
  });

  factory SubField.fromJson(Map<String, dynamic> json) => SubField(
        type: json["type"],
        version: json["version"],
        schema: SubSchema.fromJson(json["schema"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "version": version,
        "schema": schema.toJson(),
      };
}

class SubSchema {
  final String name;
  final String label;
  bool? hidden;
  final bool? readonly;
  final List<Option>? options;

  SubSchema({
    required this.name,
    required this.label,
    this.hidden,
    this.readonly,
    this.options,
  });

  factory SubSchema.fromJson(Map<String, dynamic> json) => SubSchema(
        name: json["name"],
        label: json["label"],
        hidden: json["hidden"],
        readonly: json["readonly"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "label": label,
        "hidden": hidden,
        "readonly": readonly,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  final String key;
  final String value;

  Option({
    required this.key,
    required this.value,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
