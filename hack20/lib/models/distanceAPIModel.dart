class RoutingAPI {
  Response response;

  RoutingAPI({this.response});

  RoutingAPI.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class Response {
  MetaInfo metaInfo;
  List<MatrixEntry> matrixEntry;

  Response({this.metaInfo, this.matrixEntry});

  Response.fromJson(Map<String, dynamic> json) {
    metaInfo = json['metaInfo'] != null
        ? new MetaInfo.fromJson(json['metaInfo'])
        : null;
    if (json['matrixEntry'] != null) {
      matrixEntry = [];
      json['matrixEntry'].forEach((v) {
        matrixEntry.add(new MatrixEntry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metaInfo != null) {
      data['metaInfo'] = this.metaInfo.toJson();
    }
    if (this.matrixEntry != null) {
      data['matrixEntry'] = this.matrixEntry.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetaInfo {
  String timestamp;
  String mapVersion;
  String moduleVersion;
  String interfaceVersion;
  List<String> availableMapVersion;

  MetaInfo(
      {this.timestamp,
      this.mapVersion,
      this.moduleVersion,
      this.interfaceVersion,
      this.availableMapVersion});

  MetaInfo.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    mapVersion = json['mapVersion'];
    moduleVersion = json['moduleVersion'];
    interfaceVersion = json['interfaceVersion'];
    availableMapVersion = json['availableMapVersion'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['mapVersion'] = this.mapVersion;
    data['moduleVersion'] = this.moduleVersion;
    data['interfaceVersion'] = this.interfaceVersion;
    data['availableMapVersion'] = this.availableMapVersion;
    return data;
  }
}

class MatrixEntry {
  int startIndex;
  int destinationIndex;
  Summary summary;

  MatrixEntry({this.startIndex, this.destinationIndex, this.summary});

  MatrixEntry.fromJson(Map<String, dynamic> json) {
    startIndex = json['startIndex'];
    destinationIndex = json['destinationIndex'];
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startIndex'] = this.startIndex;
    data['destinationIndex'] = this.destinationIndex;
    if (this.summary != null) {
      data['summary'] = this.summary.toJson();
    }
    return data;
  }
}

class Summary {
  int distance;
  int travelTime;
  int costFactor;

  Summary({this.distance, this.travelTime, this.costFactor});

  Summary.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    travelTime = json['travelTime'];
    costFactor = json['costFactor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['travelTime'] = this.travelTime;
    data['costFactor'] = this.costFactor;
    return data;
  }
}
