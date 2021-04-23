import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/customer_order_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCustomerOrderUseCase extends BaseAsyncUseCase<String, List<CustomerOrderModel>> {
  FirebaseFirestore _firestore;

  GetCustomerOrderUseCase(this._firestore);

  @override
  Future<Result<List<CustomerOrderModel>>> execute(String parameter) async {
    try {
      final snapshot = await _firestore
          .collection("orders")
          .where("userReference", isEqualTo: _firestore.collection("patients").doc(parameter))
          .get();
      final list = snapshot.docs
          .map((order) => CustomerOrderModel(
                createdAt: order.data()["createdAt"].toDate(),
                discount: order.data()["discount"],
                doctorReference: order.data()["doctorReference"],
                paymentGateway: order.data()["paymentGateway"],
                paymentMethod: order.data()["paymentMethod"],
                paymentReference: order.data()["paymentReference"],
                status: order.data()["status"],
                systemNoted: order.data()["systemNoted"],
                total: order.data()["total"],
                totalItemsDiscount: order.data()["totalItemsDiscount"],
                totalItemsPrice: order.data()["totalItemsPrice"],
                type: order.data()["type"],
                updatedAt: order.data()["updatedAt"].toDate(),
                userNoted: order.data()["userNoted"],
              ))
          .toList();
      return Success(list);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
