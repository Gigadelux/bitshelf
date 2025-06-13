import 'package:bitshelf/services/auth/AuthService.dart';
import 'package:bitshelf/services/encryption/EncryptionService.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';

class E2EEncryptionService extends EncryptionService {
  late final String _privateKeyPar;
  late final RSAKeyParser _keyParser;

  E2EEncryptionService() : super() {
    _privateKeyPar = AuthService.user.passwordHash;
    _keyParser = RSAKeyParser();
  }

  @override
  String encrypt(String data, {String? publicKey}) {
    String publicKeyStr = publicKey ?? "";
    final parsedPublicKey = _keyParser.parse(publicKeyStr) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: parsedPublicKey));
    final encrypted = encrypter.encrypt(data);
    return encrypted.base64;
  }

  @override
  String decrypt(String encryptedData) {
    final privateKey = _keyParser.parse(_privateKeyPar) as RSAPrivateKey;
    final encrypter = Encrypter(RSA(privateKey: privateKey));
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(encryptedData));
    return decrypted;
  }
}