import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:get/get.dart';

class RegistrationMenuDeliveryController extends GetxController {
  final menuImageController = Get.put(RegistrationDocumentFieldController(), tag: "menuImage");

  void onSave() {
    print('Saving menu delivery details...');
  }

  void onContinue() {
    print('Proceeding to the next step...');
  }
}
