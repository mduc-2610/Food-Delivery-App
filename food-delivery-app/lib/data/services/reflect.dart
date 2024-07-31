import 'package:reflectable/reflectable.dart';

class JsonSerializable extends Reflectable {
  const JsonSerializable()
      : super(invokingCapability, declarationsCapability, typingCapability);
}

const jsonSerializable = JsonSerializable();
