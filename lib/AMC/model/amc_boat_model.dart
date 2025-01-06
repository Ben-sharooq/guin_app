class Boat {
  final String name;
  final String company;
  final String projectNo;
  final String operatingArea;
  final String boatOwner;
  final String yardNo;
  final int noOfPax;
  final String deliveryDate;
  final String yob;
  final String dryDockDate;
  final String warrantyExpireDate;
  final String warrantyStatus;
  final String amcStartDate;
  final String amcEndDate;
  final String url;
 
  Boat({
    required this.name,
    required this.company,
    required this.projectNo,
    required this.operatingArea,
    required this.boatOwner,
    required this.yardNo,
    required this.noOfPax,
    required this.deliveryDate,
    required this.yob,
    required this.dryDockDate,
    required this.warrantyExpireDate,
    required this.warrantyStatus,
    required this.amcStartDate,
    required this.amcEndDate,
    required this.url,
  });
 
  factory Boat.fromJson(Map<String, dynamic> json) {
    return Boat(
      name: json['name'] ?? '', // Provide default values to avoid null errors
      company: json['company'] ?? '',
      projectNo: json['project_no'] ?? '',
      operatingArea: json['operating_area'] ?? '',
      boatOwner: json['boat_owner'] ?? '',
      yardNo: json['yard_no'] ?? '',
      noOfPax: json['no_of_pax'] ?? 0,
      deliveryDate: json['delivery_date'] ?? '',
      yob: json['yob'] ?? '',
      dryDockDate: json['drydock_date'] ?? '',
      warrantyExpireDate: json['warranty_expire_date'] ?? '',
      warrantyStatus: json['warranty_status'] ?? '',
      amcStartDate: json['amc_start_date'] ?? '',
      amcEndDate: json['amc_end_date'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
