import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/product_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/utils/error_utils.dart';

class GetProductListUseCase extends BaseAsyncUseCase<String, List<ProductModel>> {
  RemoteRepository _remoteRepository;

  GetProductListUseCase(this._remoteRepository);

  @override
  Future<Result<List<ProductModel>>> execute(String parameter) async {
    try {
      final response = await _remoteRepository.getProducts(parameter);
      if (response.isSuccess()) {
        final list = (response.data["products"] as List).map((e) => ProductModel.fromJson(e)).toList();
        return Success(list);
      } else {
        return Error(ErrorUtils.getErrorMessage(response));
      }
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
