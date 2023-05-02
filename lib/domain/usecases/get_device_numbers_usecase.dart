
import 'package:flutter_contacts/contact.dart';

import '../entities/contact_entity.dart';
import '../repositories/get_device_number_repository.dart';

class GetDeviceNumberUseCase{
  final GetDeviceNumberRepository deviceNumberRepository;

  GetDeviceNumberUseCase({required this.deviceNumberRepository});

  Future<List<Contact>> call()async{
    return deviceNumberRepository.getDeviceContacts();
  }
}