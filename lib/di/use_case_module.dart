import 'package:blossom_clinic/usecase/check_login_use_case.dart';
import 'package:blossom_clinic/usecase/get_doctor_available_slots_use_case.dart';
import 'package:blossom_clinic/usecase/get_doctor_list_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_use_case.dart';
import 'package:blossom_clinic/usecase/login_use_case.dart';
import 'package:blossom_clinic/usecase/register_use_case.dart';
import 'package:blossom_clinic/usecase/validate_email_use_case.dart';
import 'package:blossom_clinic/usecase/validate_phone_number_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injector/injector.dart';

class UseCaseModule {
  Injector injector;

  UseCaseModule(this.injector);

  void provide() {
    injector.registerDependency<RegisterUseCase>(() => RegisterUseCase(injector.get()));
    injector.registerDependency<LoginUseCase>(() => LoginUseCase(FirebaseAuth.instance, injector.get()));
    injector.registerDependency<CheckLoginUseCase>(() => CheckLoginUseCase(FirebaseAuth.instance));
    injector.registerDependency<GetUserProfileUseCase>(() => GetUserProfileUseCase(FirebaseFirestore.instance, injector.get()));
    injector.registerSingleton<GetDoctorListUseCase>(() => GetDoctorListUseCase(FirebaseFirestore.instance));
    injector.registerDependency<ValidateEmailUseCase>(() => ValidateEmailUseCase());
    injector.registerDependency<ValidatePhoneNumberUseCase>(() => ValidatePhoneNumberUseCase());
    injector.registerDependency<GetDoctorAvailableSlotsUseCase>(() => GetDoctorAvailableSlotsUseCase(FirebaseFirestore.instance));
  }
}
