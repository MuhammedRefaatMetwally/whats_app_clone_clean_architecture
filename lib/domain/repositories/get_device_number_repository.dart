import 'package:flutter_contacts/contact.dart';

abstract class GetDeviceNumberRepository{
  Future<List<Contact>> getDeviceContacts();

}