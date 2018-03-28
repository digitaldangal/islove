import 'package:islove/api/apiv1.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test("TestApiV1", () async {
    var data = await ApiV1.get().getData();
    expect("是爱", data.title);
  });
}
