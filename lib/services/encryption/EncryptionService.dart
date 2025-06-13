abstract class EncryptionService {

  EncryptionService();
  String encrypt(String data, {String? publicKey});
  String decrypt(String encryptedData);
}