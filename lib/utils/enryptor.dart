import 'dart:developer';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptData{
//for AES Algorithms

  static Encrypted? encrypted;
  static var decrypted;
  static var ENCRYPT_KEY = dotenv.get('ENCRYPT_KEY');


 static encryptAES(plainText){
   final key = Key.fromUtf8(ENCRYPT_KEY);
   final iv = IV.fromLength(16);
   final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
   return(encrypted!.base64);
 }

  static decryptAES(String? plainText){
    final key = Key.fromUtf8(ENCRYPT_KEY);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt64(plainText!, iv: iv);
    return decrypted;
  }
}