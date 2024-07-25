class PlantModel {
  String name;
  String? details;
  String? snowingSeason;
  String? snowingInstruction;
  String? careInstruction;
  String? prerequisits;

  PlantModel(
      {required this.name,
      this.details,
      this.snowingSeason,
      this.snowingInstruction,
      this.careInstruction,
      this.prerequisits});

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
        name: json['name'],
        details: json['details'],
        snowingSeason: json['sowing_season'],
        snowingInstruction: json['sowing_instructions'],
        careInstruction: json['care_instructions'],
        prerequisits: json['prerequisites']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, String?> data = <String, String?>{};
    data['name'] = name;
    data['details'] = details;
    data['snowing_season'] = snowingSeason;
    data['snowing_instruction'] = snowingInstruction;
    data['care_instruction'] = careInstruction;
    data['prereqisits'] = prerequisits;
    return data;
  }
}
