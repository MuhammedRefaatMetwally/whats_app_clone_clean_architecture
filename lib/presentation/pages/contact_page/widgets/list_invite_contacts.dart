import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../../common/utils/palette.dart';

class ListInviteContacts extends StatelessWidget {
  const ListInviteContacts({Key? key, required this.contacts}) : super(key: key);
  final List<Contact> contacts;
  @override
  Widget build(BuildContext context) {
     return Expanded(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(AppConst.profileDefaultImage),
                    radius: 28,
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  Text(
                    contacts[index].displayName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Spacer(),
                  TextButton(onPressed: ()=>shareSmsLink(contacts[index].phones[0].normalizedNumber),
                      child:  const Text(AppConst.invite,style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:  Palette.greenColor,
                  ),))

                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void shareSmsLink(phoneNumber) async {
    Uri sms = Uri.parse("${AppConst.sms}$phoneNumber${AppConst.smsDescription}",);
    if (await launchUrl(sms)) {
    }
  }

}
