class ContactEntity {
  final String phoneNumber;
  final String label;
  final String? uid;
  final String? status;

  ContactEntity(
   { required this.phoneNumber,
     required this.label,
      this.uid,
      this.status,}
  );
}
