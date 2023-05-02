import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';

class CountryDialogModel{
   BuildContext context;
   Country selectedFilteredDialogCountry;
   String countryCode;

   CountryDialogModel(
       {required this.context,required  this.selectedFilteredDialogCountry,required this.countryCode});
}