class UnionModel {
  late Data data = new Data();
  UnionModel();
  UnionModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }
}

// class Data {
//   int? id;
//   String? name;
//   String? phone;
//   late List<Services> services = [];
//
//   Data();
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     phone = json['phone'];
//     if (json['services'] != null) {
//       services = <Services>[];
//       json['services'].forEach((v) {
//         services.add(new Services.fromJson(v));
//       });
//     }
//   }
// }
//

class Data {
  int? id;
  String? name;
  String? phone;
  String? bank;
  late List<Services> services = [];
  late List<ServiceCost> serviceCost = [];
  late List<Information> information = [];

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    bank = json['bank'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services.add(Services.fromJson(v));
      });
    }
    if (json['service_cost'] != null) {
      serviceCost = <ServiceCost>[];
      json['service_cost'].forEach((v) {
        serviceCost.add(ServiceCost.fromJson(v));
      });
    }
    if (json['information'] != null) {
      information = <Information>[];
      json['information'].forEach((v) {
        information.add(Information.fromJson(v));
      });
    }
  }
}

class Services {
  int? id;
  String? namear;
  String? title;
  String? image;

  Services({this.id, this.namear, this.title});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namear = json['namear'];
    title = json['title'];
    image = json['img'];
  }
}

class ServiceCost {
  int? serviceId;
  int? serviceCost;

  ServiceCost({this.serviceId, this.serviceCost});

  ServiceCost.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceCost = json['service_cost'];
  }
}

class Information {
  int? id;
  int? unionId;
  String? header;
  String? titel;
  String? img;
  String? createdAt;

  Information(
      {this.id,
      this.unionId,
      this.header,
      this.titel,
      this.img,
      this.createdAt});

  Information.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unionId = json['union_id'];
    header = json['header'];
    titel = json['titel'];
    img = json['img'];
    createdAt = json['created_at'];
  }
}
