abstract class EncryptionService {
  final String _privateKey;

  EncryptionService(this._privateKey);

  String encrypt(String data);
  String decrypt(String encryptedData);
}