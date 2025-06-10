abstract class EncryptionService {
  // ignore: unused_field
  final String _privateKey;

  EncryptionService(this._privateKey);

  String encrypt(String data);
  String decrypt(String encryptedData);
}