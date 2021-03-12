import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommanWidgets {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING = "loggedIn";
  static const PREFERENCES_IS_FIRST_LAUNCH_SEARCH_PAGE =
      "searchPage";
  static const PREFERENCES_IS_FIRST_LAUNCH_COMPANY_PAGE =
      "companyPage";
  static const PREFERENCES_IS_FIRST_LAUNCH_OUTSIDE_COMPANY_PAGE =
      "outsideCompanyPage";
  Widget getCircularProgressIndicator(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          backgroundColor: Colors.orangeAccent,
          strokeWidth: 5,
        ),
      ),
    );
  }
}
