import 'package:bitshelf/services/auth/AuthService.dart';
import 'package:bitshelf/services/encryption/EncryptionService.dart';
import 'package:encrypt/encrypt.dart';

class SymmetricEncryptionService extends EncryptionService {
  late final Key _key;

  SymmetricEncryptionService()
      : super() {
    String privateKey = AuthService.user.passwordHash;
    _key = Key.fromUtf8(privateKey.padRight(32).substring(0, 32));
  }

  @override
  String encrypt(String data, {String? publicKey}) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(data);
    return encrypted.base64;
  }

  @override
  String decrypt(String encryptedData) {
    final encrypter = Encrypter(AES(_key));
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(encryptedData));
    return decrypted;
  }
}