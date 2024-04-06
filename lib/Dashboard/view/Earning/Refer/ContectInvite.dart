import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Widget/SimpleAppbar.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      await Permission.contacts.request();
    }
  }

  void fetchContacts() async {
    contacts = (await ContactsService.getContacts()) ?? [];
    setState(() {
      filteredContacts = contacts;
      isLoading = false;
    });
  }
  void openWhatsAppChat(String phoneNumber) async {
    // Format the phone number (remove spaces and special characters)
    final formattedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Add your country code if necessary
    final whatsappUrl = 'https://wa.me/$formattedPhoneNumber';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      // Handle the case where WhatsApp is not installed
      print("WhatsApp is not installed on this device.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      PreferredSize(
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
          child: CustomAppBar3(
            title:"Invite Friends",
            onPress: (){
              Get.back();
            },
          )
      ),
      body: Column(
        children: [
          isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                final givenName = contact.givenName ?? "No Name";
                final phoneNumber = contact.phones?.isNotEmpty == true
                    ? contact.phones!.first.value ?? "No Phone Number"
                    : "No Phone Number";
                return ListTile(
                  trailing: Text("Invite"),
                  leading: Container(
                    height: 40.h,
                    width: 40.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                          color: Colors.white.withOpacity(0.1),
                          offset: const Offset(-3, -3),
                        ),
                        BoxShadow(
                          blurRadius: 7,
                          color: Colors.black.withOpacity(0.7),
                          offset: const Offset(3, 3),
                        ),
                      ],
                      shape: BoxShape.circle,
                      color: Color(0xff262626),
                    ),
                    child: Text(
                      givenName.isNotEmpty ? givenName[0] : "?",
                      style: TextStyle(
                        fontSize: 23.sp,
                        color: Colors.primaries[
                        Random().nextInt(Colors.primaries.length)],
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  title: Text(
                    givenName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xffC4c4c4),
                    ),
                  ),
                  onTap: () {
                    openWhatsAppChat(phoneNumber);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContactListScreen(),
  ));
}
