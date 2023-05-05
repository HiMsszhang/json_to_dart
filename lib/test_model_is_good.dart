class Person {
  ///4、工作任务
  List<WorkMissionsItem>? workMissions;

  ///9、工作许可信息
  WorkApprovedInfo? workApprovedInfo;

  ///6、工作条件(停电或不停电，或邻近及保留带电设备名称)
  WorkSafetyPrecautionOperations? workSafetyPrecautionOperations;

  Person({
    this.workMissions,
    this.workApprovedInfo,
    this.workSafetyPrecautionOperations,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      workMissions: json['workMissions']?.map<WorkMissionsItem>((e) => WorkMissionsItem.fromJson(e)).toList(),
      workApprovedInfo: json['workApprovedInfo'] != null ? WorkApprovedInfo.fromJson(json['workApprovedInfo']) : null,
      workSafetyPrecautionOperations: json['workSafetyPrecautionOperations'] != null ? WorkSafetyPrecautionOperations.fromJson(json['workSafetyPrecautionOperations']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['workMissions'] = workMissions?.map((e) => e.toJson()).toList();

    data['workApprovedInfo'] = workApprovedInfo?.toJson();

    data['workSafetyPrecautionOperations'] = workSafetyPrecautionOperations?.toJson();

    return data;
  }
}

class WorkMissionsItem {
  ///工作地点及设备双重名称
  String? workPlaceAndDeviceName;

  ///工作内容
  String? workContent;

  WorkMissionsItem({
    this.workPlaceAndDeviceName,
    this.workContent,
  });

  factory WorkMissionsItem.fromJson(Map<String, dynamic> json) {
    return WorkMissionsItem(
      workPlaceAndDeviceName: json['workPlaceAndDeviceName'],
      workContent: json['workContent'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['workPlaceAndDeviceName'] = workPlaceAndDeviceName;

    data['workContent'] = workContent;

    return data;
  }
}

class WorkApprovedInfo {
  ///9.（1）许可方式
  String? lineCableWorks_ApprovedWay;

  ///9（2）、工作许可时间
  DateTime? substationCableWorks_WorkApprovedTime;

  WorkApprovedInfo({
    this.lineCableWorks_ApprovedWay,
    this.substationCableWorks_WorkApprovedTime,
  });

  factory WorkApprovedInfo.fromJson(Map<String, dynamic> json) {
    return WorkApprovedInfo(
      lineCableWorks_ApprovedWay: json['lineCableWorks_ApprovedWay'],
      substationCableWorks_WorkApprovedTime: DateTime.tryParse(json['substationCableWorks_WorkApprovedTime'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['lineCableWorks_ApprovedWay'] = lineCableWorks_ApprovedWay;

    data['substationCableWorks_WorkApprovedTime'] = substationCableWorks_WorkApprovedTime.toString();

    return data;
  }
}

class WorkSafetyPrecautionOperations {
  ///6.（1）安全措施: 应拉开的设备名称、应装设绝缘隔板
  List<ShouldPulledEquipmentAndDisconnectorsItem>? shouldPulledEquipmentAndDisconnectors;

  ///6.（1）安全措施: 应拉开的设备名称、应装设绝缘隔板
  List<GroundWireSettingsItem>? groundWireSettings;

  ///6.（1）安全措施: 应拉开的设备名称、应装设绝缘隔板
  List<FencesAndSafetySignsItem>? fencesAndSafetySigns;

  ///6.（1）安全措施: 应拉开的设备名称、应装设绝缘隔板
  List<String>? workPlaceAttentions;

  ///6.（1）安全措施: 应拉开的设备名称、应装设绝缘隔板
  List<String>? workPlaceSafetyPrecautions;

  WorkSafetyPrecautionOperations({
    this.shouldPulledEquipmentAndDisconnectors,
    this.groundWireSettings,
    this.fencesAndSafetySigns,
    this.workPlaceAttentions,
    this.workPlaceSafetyPrecautions,
  });

  factory WorkSafetyPrecautionOperations.fromJson(Map<String, dynamic> json) {
    return WorkSafetyPrecautionOperations(
      shouldPulledEquipmentAndDisconnectors:
          json['shouldPulledEquipmentAndDisconnectors']?.map<ShouldPulledEquipmentAndDisconnectorsItem>((e) => ShouldPulledEquipmentAndDisconnectorsItem.fromJson(e)).toList(),
      groundWireSettings: json['groundWireSettings']?.map<GroundWireSettingsItem>((e) => GroundWireSettingsItem.fromJson(e)).toList(),
      fencesAndSafetySigns: json['fencesAndSafetySigns']?.map<FencesAndSafetySignsItem>((e) => FencesAndSafetySignsItem.fromJson(e)).toList(),
      workPlaceAttentions: json['workPlaceAttentions'],
      workPlaceSafetyPrecautions: json['workPlaceSafetyPrecautions'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['shouldPulledEquipmentAndDisconnectors'] = shouldPulledEquipmentAndDisconnectors?.map((e) => e.toJson()).toList();

    data['groundWireSettings'] = groundWireSettings?.map((e) => e.toJson()).toList();

    data['fencesAndSafetySigns'] = fencesAndSafetySigns?.map((e) => e.toJson()).toList();

    data['workPlaceAttentions'] = workPlaceAttentions;

    data['workPlaceSafetyPrecautions'] = workPlaceSafetyPrecautions;

    return data;
  }
}

class ShouldPulledEquipmentAndDisconnectorsItem {
  ///变、配电站或线路名称
  String? stationOrCircuitName;

  ///应拉开的断路器(开关)、隔离开关(刀闸)、熔断器以及应装设的绝缘隔板(注明设备双重名称)
  String? project;

  ///执行人
  String? excutorName;

  ///已执行
  bool? isExcute;

  ShouldPulledEquipmentAndDisconnectorsItem({
    this.stationOrCircuitName,
    this.project,
    this.excutorName,
    this.isExcute,
  });

  factory ShouldPulledEquipmentAndDisconnectorsItem.fromJson(Map<String, dynamic> json) {
    return ShouldPulledEquipmentAndDisconnectorsItem(
      stationOrCircuitName: json['stationOrCircuitName'],
      project: json['project'],
      excutorName: json['excutorName'],
      isExcute: json['isExcute'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['stationOrCircuitName'] = stationOrCircuitName;

    data['project'] = project;

    data['excutorName'] = excutorName;

    data['isExcute'] = isExcute;

    return data;
  }
}

class GroundWireSettingsItem {
  ///接地刀闸双重名称和接地线装设地点
  String? groundKnifeBrakeNameAndGroundWireSettingPlace;

  ///GroundWireNo
  String? groundWireNo;

  ///执行人
  String? excutorName;

  GroundWireSettingsItem({
    this.groundKnifeBrakeNameAndGroundWireSettingPlace,
    this.groundWireNo,
    this.excutorName,
  });

  factory GroundWireSettingsItem.fromJson(Map<String, dynamic> json) {
    return GroundWireSettingsItem(
      groundKnifeBrakeNameAndGroundWireSettingPlace: json['groundKnifeBrakeNameAndGroundWireSettingPlace'],
      groundWireNo: json['groundWireNo'],
      excutorName: json['excutorName'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['groundKnifeBrakeNameAndGroundWireSettingPlace'] = groundKnifeBrakeNameAndGroundWireSettingPlace;

    data['groundWireNo'] = groundWireNo;

    data['excutorName'] = excutorName;

    return data;
  }
}

class FencesAndSafetySignsItem {
  ///操作项
  String? operationItem;

  ///执行人
  String? excutorName;

  FencesAndSafetySignsItem({
    this.operationItem,
    this.excutorName,
  });

  factory FencesAndSafetySignsItem.fromJson(Map<String, dynamic> json) {
    return FencesAndSafetySignsItem(
      operationItem: json['operationItem'],
      excutorName: json['excutorName'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['operationItem'] = operationItem;

    data['excutorName'] = excutorName;

    return data;
  }
}
