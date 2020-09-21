import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<ArtifactsModel>> getArtifactory() async {
  var uri = Uri.https('api.github.com',
      '/repos/TakenokoTech/FlutterArchitecture/actions/artifacts', {
    'per_page': "100",
  });

  final response = await http.get(uri);
  // print(response.body);

  if (response.statusCode != 200) {
    throw Exception('Fail to search repository');
  }

  List<ArtifactsModel> list = [];
  Map<String, dynamic> decoded = json.decode(response.body);
  for (var item in decoded['artifacts'])
    list.add(ArtifactsModel.fromJson(item));
  return list;
}

class ArtifactsModel {
  final int id;
  final String nodeId;
  final String name;
  final int sizeInBytes;
  final String url;
  final String archiveDownloadUrl;
  final bool expired;
  final String createdAt;
  final String updatedAt;
  final String expiresAt;

  ArtifactsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nodeId = json['node_id'],
        name = json['name'],
        sizeInBytes = json['size_in_bytes'],
        url = json['url'],
        archiveDownloadUrl = json['archive_download_url'],
        expired = json['expired'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        expiresAt = json['expires_at'];
}
