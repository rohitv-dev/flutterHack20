import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hack20/models/distanceAPIModel.dart';
import 'package:hack20/services/storage.dart';

class APICall {

  callDistanceAPI() async {
    List<int> distances = [];
    String destinationParam, url, userAd;
    url = 'https://matrix.route.ls.hereapi.com/routing/7.2/calculatematrix.json?'
        'apiKey=tNV2YWgdDJu3EP-b1ekyju7YXam3eQyZge6WuxBy_U4&mode=fastest;car;traffic:disabled'
        '&start0=${userAd}%2C${userAd}&'
        '${destinationParam}'
        'summaryAttributes=distance,traveltime';

    try {
      var _dio = Dio();
      var response = await _dio.get(url);
      RoutingAPI route = RoutingAPI.fromJson(response.data);
      List<MatrixEntry> routeMatrix = route.response.matrixEntry;
      for (int i = 0; i < routeMatrix.length; i++) {
        distances.add(routeMatrix[i].summary.distance);
      }
      addItem('ngoDis', json.encode(distances).toString());
    } catch(error) {
      return null;
    }

  }

}