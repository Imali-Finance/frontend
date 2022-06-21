import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imali/src/methods.dart';
import 'package:imali/src/portfolio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  // Image Picker
  final ImagePicker _picker = ImagePicker();
  // User information
  String? _displayName;
  String? _username;
  String? _dob;
  String? _phone;
  String? _email;
  String? _idURL;
  bool? _isFacebookLinked;
  bool? _isGmailLinked;
  bool? _isTwitterLinked;
  double? _mmfInvestmentValue;
  double? _bondsInvestmentValue;
  double? _sharesInvestmentValue;
  File? _identificationPhoto;

  // Getters
  String? get displayName => _displayName;
  String? get username => _username;
  String? get dob => _dob;
  String? get phone => _phone;
  String? get email => _email;
  String? get idURL => _idURL;
  bool? get isFacebookLinked => _isFacebookLinked;
  bool? get isGmailLinked => _isGmailLinked;
  bool? get isTwitterLinked => _isTwitterLinked;
  double? get mmfInvestmentValue => _mmfInvestmentValue;
  double? get bondsInvestmentValue => _bondsInvestmentValue;
  double? get sharesInvestmentValue => _sharesInvestmentValue;
  File? get identificationPhoto => _identificationPhoto;

  // Get user information from shared preferences
  Future<void> getUserInformation() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _displayName = _prefs.getString('displayname');
    _username = _prefs.getString('username');
    _phone = _prefs.getString('phone');
    _email = _prefs.getString('email');
    _isFacebookLinked = false;
    _isGmailLinked = false;
    _isTwitterLinked = false;
    _mmfInvestmentValue = _prefs.getDouble('mmfInvestmentValue');
    _sharesInvestmentValue = _prefs.getDouble('sharesInvestmentValue');
    _bondsInvestmentValue = _prefs.getDouble('bondsInvestmentValue');
    log('Gotten user information');
    notifyListeners();
  }

  // Delete persistent storage data
  Future<void> clearLocalStorage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    log('Data removed from local storage');
    notifyListeners();
  }

  // Store user information to shared preferences
  Future<void> storeUserInformation(String name, String username, String email, String phone, String dob) async {
    try {
      await storeData('displayname', string: name).then((value) => storeData('username', string: username).then(
          (value) => storeData('email', string: email).then((value) => storeData('phone', string: phone).then((value) =>
              storeData('dob', string: dob).then(
                  (value) => log('The information of this user has been saved successfully to persistent storage'))))));
      await storeData('mmfInvestmentValue', doub: 0);
      await storeData('sharesInvestmentValue', doub: 0);
      await storeData('bondsInvestmentValue', doub: 0);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  // Store identification image
  storeIdentificationImage(String id) async {
    try {
      await storeData('id', string: id).then((value) => log('Successfully stored the Identification Image URL'));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  // take the identification document image from the camera
  uploadIdentificationImageFromCamera() {
    _picker.pickImage(source: ImageSource.camera).then((image) => {
          if (image != null) {_identificationPhoto = File(image.path), notifyListeners()}
        });
    notifyListeners();
  }

  // Purchase Asset
  Future<void> purchaseAsset(InvestmentType type) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    switch (type) {
      case InvestmentType.shares:
        double? _amount = _prefs.getDouble('purchaseAmount');
        double? _sharesValue = _prefs.getDouble('sharesInvestmentValue');
        storeData('sharesInvestmentValue', doub: _amount! + _sharesValue!);
        log('Purchased shares');
        return;
      case InvestmentType.bonds:
        double? _amount = _prefs.getDouble('purchaseAmount');
        double? _bondsValue = _prefs.getDouble('bondsInvestmentValue');
        storeData('bondsInvestmentValue', doub: _amount! + _bondsValue!);
        log('Purchased bonds');
        return;
      case InvestmentType.mmf:
        double? _amount = _prefs.getDouble('purchaseAmount');
        double? _mmfValue = _prefs.getDouble('mmfInvestmentValue');
        storeData('mmfInvestmentValue', doub: _amount! + _mmfValue!);
        log('Purchased mmf');
        return;
    }
  }
}
