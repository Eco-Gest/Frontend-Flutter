import 'package:ecogest_front/data/ecogest_api_data_source.dart';
import 'package:ecogest_front/models/account_model.dart';

class AccountService {
  static Future<Account> getUserAccount() async { 
    final String token = await EcoGestApiDataSource.getToken();

    var responseMap =
        await EcoGestApiDataSource.get('/me', token: token);

    return Account.fromJson(responseMap);
  }

}