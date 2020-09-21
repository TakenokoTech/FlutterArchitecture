import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<GithubModel>> searchRepositories(String searchWord) async {
  var uri = Uri.https('api.github.com', '/search/repositories', {
    'q': searchWord,
    'sort': 'stars',
    'order': 'desc',
  });

  final response = await http.get(uri);
  // print(response.body);

  if (response.statusCode != 200) {
    throw Exception('Fail to search repository');
  }

  List<GithubModel> list = [];
  Map<String, dynamic> decoded = json.decode(response.body);
  for (var item in decoded['items']) list.add(GithubModel.fromJson(item));
  return list;
}

class GithubModel {
  final String fullName;
  final String description;
  final String language;
  final String htmlUrl;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;

  GithubModel.fromJson(Map<String, dynamic> json)
      : fullName = json['full_name'],
        description = json['description'],
        language = json['language'],
        htmlUrl = json['html_url'],
        stargazersCount = json['stargazers_count'],
        watchersCount = json['watchers_count'],
        forksCount = json['forks_count'];
}
