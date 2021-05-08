import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/available_slot_model.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/model/shipnity_customer_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/page/add_customer_information/add_customer_information_page.dart';
import 'package:blossom_clinic/page/add_customer_information/add_customer_information_provider.dart';
import 'package:blossom_clinic/page/call_customer/call_customer_page.dart';
import 'package:blossom_clinic/page/call_customer/call_customer_provider.dart';
import 'package:blossom_clinic/page/call_doctor/call_doctor_page.dart';
import 'package:blossom_clinic/page/call_doctor/call_doctor_provider.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_page.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_provider.dart';
import 'package:blossom_clinic/page/customer_history_detail/customer_history_detail_page.dart';
import 'package:blossom_clinic/page/customer_history_detail/doctor_appointment_detail_provider.dart';
import 'package:blossom_clinic/page/customer_incoming_call_page/customer_incoming_call_page.dart';
import 'package:blossom_clinic/page/customer_incoming_call_page/customer_incoming_call_provider.dart';
import 'package:blossom_clinic/page/customer_review_doctor/customer_review_doctor_page.dart';
import 'package:blossom_clinic/page/customer_review_doctor/customer_review_doctor_provider.dart';
import 'package:blossom_clinic/page/customer_treat_history/customer_treat_history_page.dart';
import 'package:blossom_clinic/page/customer_treat_history/customer_treat_history_provider.dart';
import 'package:blossom_clinic/page/dispense/dispense_page.dart';
import 'package:blossom_clinic/page/dispense/dispense_provider.dart';
import 'package:blossom_clinic/page/doctor_call_customer/doctor_call_customer_page.dart';
import 'package:blossom_clinic/page/doctor_call_customer/doctor_call_customer_provider.dart';
import 'package:blossom_clinic/page/doctor_diagnose/doctor_diagnose_page.dart';
import 'package:blossom_clinic/page/doctor_diagnose/doctor_diagnose_provider.dart';
import 'package:blossom_clinic/page/doctor_history/doctor_history_provider.dart';
import 'package:blossom_clinic/page/doctor_home/doctor_home_provider.dart';
import 'package:blossom_clinic/page/doctor_main/doctor_main_page.dart';
import 'package:blossom_clinic/page/doctor_main/doctor_main_provider.dart';
import 'package:blossom_clinic/page/doctor_order_detail/doctor_appointment_detail_page.dart';
import 'package:blossom_clinic/page/doctor_order_detail/doctor_appointment_detail_provider.dart';
import 'package:blossom_clinic/page/doctor_profile/doctor_profile_provider.dart';
import 'package:blossom_clinic/page/facebook_update_profile/facebook_update_profile_page.dart';
import 'package:blossom_clinic/page/facebook_update_profile/facebook_update_profile_provider.dart';
import 'package:blossom_clinic/page/facebook_update_profile_second/facebook_update_profile_second_page.dart';
import 'package:blossom_clinic/page/facebook_update_profile_second/facebook_update_profile_second_provider.dart';
import 'package:blossom_clinic/page/history/history_provider.dart';
import 'package:blossom_clinic/page/incoming_call_page/incoming_call_page.dart';
import 'package:blossom_clinic/page/incoming_call_page/incoming_call_provider.dart';
import 'package:blossom_clinic/page/login/login_page.dart';
import 'package:blossom_clinic/page/login/login_provider.dart';
import 'package:blossom_clinic/page/main/main_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/page/omise/omise_page.dart';
import 'package:blossom_clinic/page/omise/omise_provider.dart';
import 'package:blossom_clinic/page/payment/payment_page.dart';
import 'package:blossom_clinic/page/payment/payment_provider.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/page/qr_scan/qr_scan_page.dart';
import 'package:blossom_clinic/page/qr_scan/qr_scan_provider.dart';
import 'package:blossom_clinic/page/register/register_page.dart';
import 'package:blossom_clinic/page/register/register_provider.dart';
import 'package:blossom_clinic/page/register_second/register_second_page.dart';
import 'package:blossom_clinic/page/register_second/register_second_provider.dart';
import 'package:blossom_clinic/page/service/service_provider.dart';
import 'package:blossom_clinic/page/splash_screen_page.dart';
import 'package:blossom_clinic/page/splash_screen_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

import 'no_animation_page_route.dart';

class RouteManager {
  static Route routeSplashScreen() => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) =>
                  SplashScreenProvider(FirebaseAuth.instance, Injector.appInstance.get(), Injector.appInstance.get()),
            )
          ],
          child: SplashScreenPage(),
        );
      });

  static Route routeRegister() => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) =>
                  RegisterProvider(Injector.appInstance.get(), Injector.appInstance.get()),
            )
          ],
          child: RegisterPage(),
        );
      });

  static Route routeRegisterSecond(Map<String, String> map) => NoAnimationPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => RegisterSecondProvider(Injector.appInstance.get(),
                  Injector.appInstance.get(), Injector.appInstance.get(), FirebaseAuth.instance),
            )
          ],
          child: RegisterSecondPage(map),
        );
      });

  static Route routeLogin() => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (BuildContext context) => LoginProvider(
                      Injector.appInstance.get(),
                      Injector.appInstance.get(),
                      Injector.appInstance.get(),
                      Injector.appInstance.get(),
                      FirebaseAuth.instance,
                      FacebookAuth.instance)),
            ],
            child: LoginPage(),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1000),
      );

  static Route routeFacebookUpdateProfile(String email, String name, Map<String, dynamic> mapResult) =>
      MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => FacebookUpdateProfileProvider(Injector.appInstance.get()),
            )
          ],
          child: FacebookUpdateProfilePage(email, name, mapResult),
        );
      });

  static Route routeFacebookUpdateProfileSecond(Map<String, dynamic> mapResult) =>
      MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => FacebookUpdateProfileSecondProvider(
                  Injector.appInstance.get(), Injector.appInstance.get(), Injector.appInstance.get()),
            )
          ],
          child: FacebookUpdateProfileSecondPage(mapResult),
        );
      });

  static Route routeMain({int initIndex = 0}) => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => MainProvider(Injector.appInstance.get(), initIndex: initIndex),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => DoctorProvider(Injector.appInstance.get()),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) =>
                  HistoryProvider(Injector.appInstance.get(), Injector.appInstance.get(), Injector.appInstance.get()),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ServiceProvider(Injector.appInstance.get()),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ProfileProvider(FacebookAuth.instance, FirebaseAuth.instance),
            ),
          ],
          child: MainPage(
            initIndex: initIndex,
          ),
        );
      });

  static Route routeConfirmConsult(DoctorInfoModel doctorInfoModel, AvailableSlotModel availableSlotModel) =>
      CupertinoPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (BuildContext context) => ConfirmConsultProvider(
                    Injector.appInstance.get(), Injector.appInstance.get(), Injector.appInstance.get()))
          ],
          child: ConfirmConsultPage(doctorInfoModel, availableSlotModel),
        );
      });

  static Route routePayment(String orderId, int price) => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => PaymentProvider(Injector.appInstance.get(), Injector.appInstance.get()),
            )
          ],
          child: PaymentPage(orderId, price),
        );
      });

  static Route routeOmise(String orderId, int price) => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => OmiseProvider(Injector.appInstance.get()),
            )
          ],
          child: OmisePage(orderId, price),
        );
      });

  static Route routeAddCustomerInformation(String orderId) => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return AddCustomerInformationProvider(Injector.appInstance.get(), Injector.appInstance.get());
              },
            )
          ],
          child: AddCustomerInformationPage(orderId),
        );
      });

  static Route routeDispense(
          UserProfileModel userProfileModel, ShipnityCustomerModel shipnityCustomerModel, String appointmentId) =>
      MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return DispenseProvider(Injector.appInstance.get(), Injector.appInstance.get(),
                    Injector.appInstance.get(), shipnityCustomerModel, appointmentId);
              },
            )
          ],
          child: DispensePage(),
        );
      });

  static Route routeCustomerHistory() => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return CustomerTreatHistoryProvider(Injector.appInstance.get(), Injector.appInstance.get());
              },
            )
          ],
          child: CustomerTreatHistoryPage(),
        );
      });

  static Route routeCustomerHistoryDetail(AppointmentModel appointmentModel, String name, String appointmentTime) =>
      MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return CustomerHistoryDetailProvider(Injector.appInstance.get(), Injector.appInstance.get());
              },
            )
          ],
          child: CustomerHistoryDetailPage(appointmentModel, name, appointmentTime),
        );
      });

  static Route routeCallDoctor(AppointmentModel appointmentModel) => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return CallDoctorProvider(Injector.appInstance.get());
              },
            )
          ],
          child: CallDoctorPage(appointmentModel),
        );
      });

  static Route routeCustomerReviewDoctor(DoctorInfoModel doctorInfoModel) =>
      MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return CustomerReviewDoctorProvider();
              },
            )
          ],
          child: CustomerReviewDoctorPage(doctorInfoModel),
        );
      });

  static Route routeQrScan(String orderId, String base64String) => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return QrScanProvider(orderId, FirebaseFirestore.instance);
              },
            )
          ],
          child: QrScanPage(base64String),
        );
      });

  static Route routeCustomerIncomingCall(P2PSession callSession) => MaterialPageRoute(builder: (BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return CustomerIncomingCallProvider();
          },
        )
      ],
      child: CustomerIncomingCallPage(callSession),
    );
  });

  ////////// Doctor //////////

  static Route routeDoctorMain({int initIndex = 0}) => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => DoctorMainProvider(Injector.appInstance.get(), initIndex: initIndex),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => DoctorHomeProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => DoctorHistoryProvider(
                Injector.appInstance.get(),
              ),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => DoctorProfileProvider(),
            ),
          ],
          child: DoctorMainPage(
            initIndex: initIndex,
          ),
        );
      });

  static Route routeDoctorDiagnose(int userConnectyCubeId, String appointmentId) =>
      MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return DoctorDiagnoseProvider(Injector.appInstance.get(), Injector.appInstance.get(),
                    Injector.appInstance.get(), Injector.appInstance.get(), appointmentId);
              },
            )
          ],
          child: DoctorDiagnosePage(userConnectyCubeId),
        );
      });

  static Route routeDoctorAppointmentDetail(AppointmentModel appointmentModel, String name, String appointmentTime) =>
      MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return DoctorAppointmentDetailProvider(Injector.appInstance.get(), Injector.appInstance.get());
              },
            )
          ],
          child: DoctorAppointmentDetailPage(appointmentModel, name, appointmentTime),
        );
      });

  static Route routeDoctorIncomingCall(P2PSession callSession) => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return IncomingCallProvider();
              },
            )
          ],
          child: IncomingCallPage(callSession),
        );
      });

  static Route routeCallCustomer(P2PSession callSession) => MaterialPageRoute(builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return CallCustomerProvider();
              },
            )
          ],
          child: CallCustomerPage(callSession),
        );
      });

  static Route routeDoctorCallCustomer(AppointmentModel appointmentModel) => MaterialPageRoute(builder: (BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return DoctorCallCustomerProvider(Injector.appInstance.get());
          },
        )
      ],
      child: DoctorCallCustomerPage(appointmentModel),
    );
  });
}
