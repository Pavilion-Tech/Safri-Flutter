class UserParticipateRewardsResponse {
  String? message;
  bool? status;
  List<UserParticipateRewardsData>? data;

  UserParticipateRewardsResponse({this.message, this.status, this.data});

  UserParticipateRewardsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <UserParticipateRewardsData>[];
      json['data'].forEach((v) {
        data!.add(UserParticipateRewardsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserParticipateRewardsData {
  String? id;
  int? noOfPoints;
  int? winningPrice;
  String? startingDate;
  String? liveLink;
  int? participatesNumber;

  UserParticipateRewardsData(
      {this.id,
        this.noOfPoints,
        this.winningPrice,
        this.startingDate,
        this.liveLink,
        this.participatesNumber});

  UserParticipateRewardsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noOfPoints = json['no_of_points'];
    winningPrice = json['winning_price'];
    startingDate = json['starting_date'];
    liveLink = json['live_link'];
    participatesNumber = json['participates_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['no_of_points'] = noOfPoints;
    data['winning_price'] = winningPrice;
    data['starting_date'] = startingDate;
    data['live_link'] = liveLink;
    data['participates_number'] = participatesNumber;
    return data;
  }
}