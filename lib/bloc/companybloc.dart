import 'dart:async';

import 'package:atamnirbharapp/bloc/bloc.dart';
import 'package:atamnirbharapp/bloc/company.dart';

class CompanyBloc extends Bloc {
  Company _company;

  Company get selectedCompany => _company;

  // 1
  final _companyController = StreamController<Company>();

  // 2
  Stream<Company> get companyStream => _companyController.stream;

  // 3
  void selectCompany(Company company) {
    _company = company;
    _companyController.sink.add(company);
  }

//4
  @override
  void dispose() {
    // TODO: implement dispose
  }
}
