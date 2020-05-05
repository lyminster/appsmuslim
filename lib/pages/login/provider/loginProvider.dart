import 'package:appsmuslim/helpers/globalVar.dart';
import 'package:appsmuslim/pages/login/model/loginModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:oauth2/oauth2.dart' as oauth2;

class LoginProvider extends ChangeNotifier {
  bool isGettingData = true;
  List<LoginUser> dataUsers = [];
  String url = GlobalVar().PTAMIurlAPI;

  setDataUser(data) {
    dataUsers = data;
    setloading(false);
  }

  setloading(value) {
    isGettingData = value;
    notifyListeners();
  }

  getData() async {
    final response = await http.get('http://192.168.4.179:3030/user/1');

    var res = json.decode(response.body);
    List<LoginUser> data = [];

    for (var i = 0; i < res.length; i++) {
      var post = LoginUser.fromJson(res["data"]);
      data.add(post);
    }
    setDataUser(data);
  }

final authorizationEndpoint =
    Uri.parse("http://example.com/oauth2/authorization");
final tokenEndpoint =
    Uri.parse("http://example.com/oauth2/token");


final identifier = "my client identifier";
final secret = "my client secret";
final redirectUrl = Uri.parse("http://my-site.com/oauth2-redirect");
final credentialsFile = new File("~/.myapp/credentials.json");

Future<oauth2.Client> getClient() async {
  var exists = await credentialsFile.exists();

  // If the OAuth2 credentials have already been saved from a previous run, we
  // just want to reload them.
  if (exists) {
    var credentials = new oauth2.Credentials.fromJson(
        await credentialsFile.readAsString());
    return new oauth2.Client(credentials,
        identifier: identifier, secret: secret);
  }

  // If we don't have OAuth2 credentials yet, we need to get the resource owner
  // to authorize us. We're assuming here that we're a command-line application.
  var grant = new oauth2.AuthorizationCodeGrant(
      identifier, authorizationEndpoint, tokenEndpoint,
      secret: secret);

  // Redirect the resource owner to the authorization URL. This will be a URL on
  // the authorization server (authorizationEndpoint with some additional query
  // parameters). Once the resource owner has authorized, they'll be redirected
  // to `redirectUrl` with an authorization code.
  //
  // `redirect` is an imaginary function that redirects the resource
  // owner's browser.
  // await redirect(grant.getAuthorizationUrl(redirectUrl));
  
  // Another imaginary function that listens for a request to `redirectUrl`.
  // var request = await listen(redirectUrl);

  // Once the user is redirected to `redirectUrl`, pass the query parameters to
  // the AuthorizationCodeGrant. It will validate them and extract the
  // authorization code to create a new Client.
  // return await grant.handleAuthorizationResponse(request.uri.queryParameters);
}

jalan() async{
  var client = await getClient();

  // Once you have a Client, you can use it just like any other HTTP client.
  var result = client.read("http://example.com/protected-resources.txt");

  // Once we're done with the client, save the credentials file. This ensures
  // that if the credentials were automatically refreshed while using the
  // client, the new credentials are available for the next run of the
  // program.
  await credentialsFile.writeAsString(client.credentials.toJson());

  print(result);
}

}
