import 'package:blossom_clinic/usecase/create_appointment_without_payment_use_case.dart';
import 'package:blossom_clinic/usecase/create_shipnity_customer_use_case.dart';
import 'package:blossom_clinic/usecase/create_shipnity_order_use_case.dart';
import 'package:blossom_clinic/usecase/generate_scb_qr_prompt_pay_use_case.dart';
import 'package:blossom_clinic/usecase/get_appointment_by_doctor_id_use_case.dart';
import 'package:blossom_clinic/usecase/get_appointment_by_user_id_use_case.dart';
import 'package:blossom_clinic/usecase/get_appointments_id_by_order_id_use_case.dart';
import 'package:blossom_clinic/usecase/get_blossom_review_use_case.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_by_id_use_case.dart';
import 'package:blossom_clinic/usecase/get_product_list_use_case.dart';
import 'package:blossom_clinic/usecase/get_shipnity_customer_use_case.dart';
import 'package:blossom_clinic/usecase/get_shipnity_order_by_invoice_id_use_case.dart';
import 'package:blossom_clinic/usecase/get_shipnity_order_list_by_phone_number_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_by_id_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_with_connecty_cube_id_use_case.dart';
import 'package:blossom_clinic/usecase/omise_internet_banking_charge_use_case.dart';
import 'package:blossom_clinic/usecase/save_doctor_diagnose_form_use_case.dart';
import 'package:blossom_clinic/usecase/save_patient_form_use_case.dart';
import 'package:blossom_clinic/usecase/set_user_reference_to_local_storage_use_case.dart';
import 'package:blossom_clinic/usecase/login_facebook_use_case.dart';
import 'package:blossom_clinic/usecase/omise_charge_use_case.dart';
import 'package:blossom_clinic/usecase/check_login_use_case.dart';
import 'package:blossom_clinic/usecase/create_appointment_order_use_case.dart';
import 'package:blossom_clinic/usecase/download_fire_from_cloud_storage_use_case.dart';
import 'package:blossom_clinic/usecase/get_customer_order_use_case.dart';
import 'package:blossom_clinic/usecase/get_doctor_available_slots_use_case.dart';
import 'package:blossom_clinic/usecase/get_doctor_list_use_case.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_use_case.dart';
import 'package:blossom_clinic/usecase/login_use_case.dart';
import 'package:blossom_clinic/usecase/register_use_case.dart';
import 'package:blossom_clinic/usecase/update_profile_facebook_login_use_case.dart';
import 'package:blossom_clinic/usecase/update_shipnity_reference_use_case.dart';
import 'package:blossom_clinic/usecase/validate_email_use_case.dart';
import 'package:blossom_clinic/usecase/validate_phone_number_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injector/injector.dart';
import 'package:omise_flutter/omise_flutter.dart';

class UseCaseModule {
  Injector injector;

  UseCaseModule(this.injector);

  final omise = OmiseFlutter("pkey_test_5mmq1gnwqw4n78r3sil");

  void provide() {
    injector.registerDependency<RegisterUseCase>(() => RegisterUseCase(FirebaseFunctions.instance));
    injector.registerDependency<LoginUseCase>(() => LoginUseCase(FirebaseAuth.instance, injector.get()));
    injector.registerDependency<CheckLoginUseCase>(() => CheckLoginUseCase(FirebaseAuth.instance));
    injector.registerDependency<GetUserProfileUseCase>(() => GetUserProfileUseCase(FirebaseFirestore.instance, injector.get()));
    injector.registerDependency<GetUserProfileByIdUseCase>(() => GetUserProfileByIdUseCase(FirebaseFirestore.instance));
    injector.registerSingleton<GetDoctorListUseCase>(() => GetDoctorListUseCase(FirebaseFirestore.instance));
    injector.registerDependency<ValidateEmailUseCase>(() => ValidateEmailUseCase());
    injector.registerDependency<ValidatePhoneNumberUseCase>(() => ValidatePhoneNumberUseCase());
    injector.registerDependency<GetDoctorAvailableSlotsUseCase>(() => GetDoctorAvailableSlotsUseCase(FirebaseFirestore.instance));
    injector.registerDependency<DownloadFileFromCloudStorageUseCase>(() => DownloadFileFromCloudStorageUseCase(FirebaseStorage.instance, injector.get()));
    injector.registerDependency<CreateAppointmentOrderUseCase>(() => CreateAppointmentOrderUseCase(FirebaseFunctions.instance));
    injector.registerDependency<CreateAppointmentWithoutPaymentUseCase>(() => CreateAppointmentWithoutPaymentUseCase(FirebaseFunctions.instance));
    injector.registerDependency<GetCustomerOrderUseCase>(() => GetCustomerOrderUseCase(FirebaseFirestore.instance));
    injector.registerDependency<GetDoctorProfileUseCase>(() => GetDoctorProfileUseCase(FirebaseFirestore.instance, injector.get()));
    injector.registerDependency<GetDoctorProfileByIdUseCase>(() => GetDoctorProfileByIdUseCase(FirebaseFirestore.instance, injector.get()));
    injector.registerDependency<OmiseChargeUseCase>(() => OmiseChargeUseCase(omise, injector.get()));
    injector.registerDependency<OmiseInternetBankingChargeUseCase>(() => OmiseInternetBankingChargeUseCase(omise, injector.get()));
    injector.registerDependency<GetProductListUseCase>(() => GetProductListUseCase(injector.get()));
    injector.registerDependency<LoginFacebookUseCase>(() => LoginFacebookUseCase(FacebookAuth.instance, FirebaseAuth.instance));
    injector.registerDependency<UpdateProfileFacebookLoginUseCase>(() => UpdateProfileFacebookLoginUseCase(FirebaseFunctions.instance));
    injector.registerDependency<GetUserProfileWithConnectyCubeIdUseCase>(() => GetUserProfileWithConnectyCubeIdUseCase(FirebaseFirestore.instance));
    injector.registerDependency<GetShipnityCustomerUseCase>(() => GetShipnityCustomerUseCase(injector.get()));
    injector.registerDependency<CreateShipnityCustomerUseCase>(() => CreateShipnityCustomerUseCase(injector.get()));
    injector.registerDependency<CreateShipnityOrderUseCase>(() => CreateShipnityOrderUseCase(injector.get(), injector.get()));
    injector.registerDependency<GetAppointmentByDoctorIdUseCase>(() => GetAppointmentByDoctorIdUseCase(FirebaseFirestore.instance));
    injector.registerDependency<GetAppointmentByUserIdUseCase>(() => GetAppointmentByUserIdUseCase(FirebaseFirestore.instance));
    injector.registerDependency<SetUserReferenceToLocalStorageUseCase>(() => SetUserReferenceToLocalStorageUseCase(injector.get()));
    injector.registerDependency<SavePatientFormUseCase>(() => SavePatientFormUseCase(FirebaseFunctions.instance));
    injector.registerDependency<GetAppointmentsIdByOrderIdUseCase>(() => GetAppointmentsIdByOrderIdUseCase(FirebaseFirestore.instance));
    injector.registerDependency<SaveDoctorDiagnoseFormUseCase>(() => SaveDoctorDiagnoseFormUseCase(FirebaseFunctions.instance));
    injector.registerDependency<UpdateShipnityReferenceUseCase>(() => UpdateShipnityReferenceUseCase(FirebaseFunctions.instance));
    injector.registerDependency<GetShipnityOrderByInvoiceIdUseCase>(() => GetShipnityOrderByInvoiceIdUseCase(injector.get()));
    injector.registerDependency<GetShipnityOrderListByPhoneNumberUseCase>(() => GetShipnityOrderListByPhoneNumberUseCase(injector.get()));
    injector.registerDependency<GetBlossomReviewUseCase>(() => GetBlossomReviewUseCase(FirebaseFirestore.instance));
    injector.registerDependency<GenerateScbQrPromptPayUseCase>(() => GenerateScbQrPromptPayUseCase(FirebaseFunctions.instance));

  }
}