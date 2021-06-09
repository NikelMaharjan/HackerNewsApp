import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/repo/new_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test("Sum of 2 integers", (){
    final sum = 2+2;
    expect(sum, 4);

  });


  test("fetch top ids indeed returns a list of ids", () async{
    final data = "[ 9129911, 9129199, 9127761, 9128141, 9128264, 9127792 ]";

    final apiProvider = NewsApiProvider();
    
    apiProvider.client = MockClient((request) async{   //it will mock news provider client
      return Response(data, 200);    //override news api provider response with this
    });
    
    final ids = await apiProvider.fetchTopIds(); //data will arrive instead of actual list from server in this case
    expect(ids, [ 9129911, 9129199, 9127761, 9128141, 9128264, 9127792 ]);
  });

}
