import 'package:gsheets/gsheets.dart';


class SheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "fluttersheet2006",
  "private_key_id": "ecb9e24f7ac7845e6fddfc4b82e054f964135d9d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDIPJNsEHixBAcg\n9lFTee+UhN6B1eCjaUwSNIIeJ0fBhkoME/H+cJLT6vFDdKyfyQ28EW8zDNouVz7v\noax8W1Kawszj5gxdwvL3rsvQhwchQV9XNtWOL0P9SewAaCRMva1Yohqd0/+CLh5f\naYUltPDhjwWdG1FAUwfzrtCxJBPtvoUfvqif8+CWbLZjSmKOh765m+oseH7sY+00\nvt9nRfrHpV6c9mQY21cDjTGBeF0PWz4U5qzfsNykajNzJMmmv8lnWzJtwd4Scx4A\n/eL6m64Yr4LGok3ClV4WSDQa3elf6YWkDxs64SoUFqDQ3DmEpp9DI5KaYXmIcJZM\neGttZRkfAgMBAAECggEAGJD6A0mYDRux5jTiMGwm3SFaDTLYzyOljhw8FIf8MT2R\nCx9NUsqr8O0DsaN4ZFgt47N94ZUDlajlk0/SEiXAIjWhHprETKKU3Zdn8QsH8GgN\nUu1q0PlyjXpKxpgAUBv7TwMAYfm3ANk4p7sR91jWLs41wZsu4kXtlVOOzhTfjwzX\ntPQT/XPCDip8Bcd49dQPA/lHBb/5yF5DsC/dRrbHcpk3Zg/zPNUHwIEQkVIH7G2l\nAeNqhAk/kSD3GG9bENNd4/nauzeT6sDxbJ4IY3/iQ631MPJQ4/WTi145ii5vtrb6\n3ABfyW3lMfuoE8+I6oYvCGIBUpwHMelPeQh+aCzutQKBgQDu0VjVVFtXBcf1iDqM\nmq6PqlNEAY4GFiU2s1DnoFamq2/ANVkw9OZYybUyl63AeX3cfSDkyP+5yRqMwgSR\n1+JmDxxtQleG2qOwtaACUt1jDe1NF13f7LIruXNvAuffFf/zVCN/nBbnreTTDkJg\nQ0obgLh/bVnm53SssB7swTEiQwKBgQDWpJ/GGN5kOHLjQ9wGwHnQzMNfNsai6rdA\nvEAGkFBJ3Kt8dKgon+m0GqXEiln5XXG4Zn0Qlk82bPDcHuA0vuprTzYKLY3+80QH\n6u2lQke/sorITjDGFXyQbqLpynND/eQb20FngaLGeHFiSg4+gDlUuzzGVEqlv/6v\nq0h2hDwF9QKBgD5qKDVY3qZXtHLPL74fjw+tDCXx4hRlJUSuiK6AkSTuGT66spzA\n5JK/5MNcMOTk26gMa9RfU7ZSgMXYzyjuqxTRTjSf6hAshCtizHbPAV0p/qLvQHGN\nguM6jJiuwbrkHQiTLNPlD3dtUyh1yZMvAuc9NPrYsW5Pf4bCYNKviw/RAoGARJQG\nhFlvvJ+YfWoyA2o9wWuaxHIQ1v6dHC7JWg+Dx4WcuL/g9lHZbnTRH9GAW77yVZNR\nRBpyJpZ6AipPQir5ZN3DC09wvdNlmg4CbbmWiPX3h3YL+U3mJZNjs8S+PSwCVLAh\n3ns50aWrvFai5G89YggMq+VEkF6edewI0+z97H0CgYEAk6nJd6oJTKZ4vhkk2897\nuodCs84C/j7jpUaFi48KKfICENdbFL3Z+vb5lfRh/mfF6sYK0g76takUzu1tXpms\nv6Nkx/K411gdqjGIIJOpvTvaBtluXYaRa7P7ex+iK+4fRSyK3N0A20tklUrZFN6/\nF4reBddEPtL1PcmW7Gn7evM=\n-----END PRIVATE KEY-----\n",
  "client_email": "fluttersheet2006@fluttersheet2006.iam.gserviceaccount.com",
  "client_id": "106488179786315573696",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttersheet2006%40fluttersheet2006.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
  ''';  // Replace with your downloaded json file

  static final _spreadsheetId = '1z1on34VCWdAZeapYLORWK9A0Ptk_VSkuBz4fTDYsvcM'; // Replace with your-spreadsheet-id

  static final _gsheets = GSheets(_credentials);

  static Future<void> writeToSheet(String data) async {
    try {
      final sheet = await _gsheets.spreadsheet(_spreadsheetId);
      final worksheet =
          sheet.worksheetByTitle('Sheet1'); // Replace with your sheet name

      await worksheet!.values.appendRow([data]);
    } catch (e) {
      print('Error writing to Google Sheets: $e');
    }
  }

  static Future<List<List<String>>> readFromSheet() async {
    try {
      final sheet = await _gsheets.spreadsheet(_spreadsheetId);
      final worksheet =
          sheet.worksheetByTitle('Sheet1'); // Replace with your sheet name

      final values = await worksheet!.values.allRows();
  
      return values;
    } catch (e) {
      print('Error reading from Google Sheets: $e');
      return [];
    }
  }


  static Future<void> deleteRow(int id) async {
    final sheet = await _gsheets.spreadsheet(_spreadsheetId);
    final worksheet = sheet.worksheetByTitle('Sheet1');
    await worksheet!.deleteRow(id);
  }

  static Future<void> editItem(
    int id,String value
  ) async {
    final sheet = await _gsheets.spreadsheet(_spreadsheetId);
    final worksheet = sheet.worksheetByTitle('Sheet1');
    await worksheet!.values.insertValue(value, column: 1, row: id);
  }
}
