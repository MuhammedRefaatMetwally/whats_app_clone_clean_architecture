
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../domain/entities/contact_entity.dart';

abstract class LocalDataSource{
  Future<List<Contact>> getDeviceContacts();

}

class LocalDataSourceImpl implements LocalDataSource{
  @override
  Future<List<Contact>> getDeviceContacts()async {
    List<Contact> contacts=[];
       try{
           if(await FlutterContacts.requestPermission()){
             contacts=await FlutterContacts.getContacts(withProperties: true);
           }
       }catch(e){
          if (kDebugMode) {
            print(e.toString());
          }
       }
       return contacts;
  }



}