import 'package:dio/dio.dart';

import 'result_data.dart';
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response,ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);

    RequestOptions option = response.requestOptions;
    try {
      if (option.contentType != null && option.contentType!.contains("text")) {
        // return new ResultData(response.data, true, 200);
        response.data = ResultData(response.data, true, 200);
        handler.next(response);
      }

      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201) {
        ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
        int code = response.data["code"];
        if (code == 0) {
          // return new ResultData(response.data, true, 200,
          //     headers: response.headers);
          response.data = ResultData(response.data, true, 200,
              headers: response.headers);
          handler.next(response);
        } else {
          // return new ResultData(response.data, false, 200,
          //     headers: response.headers);
          response.data = ResultData(response.data, false, 200,
              headers: response.headers);
          handler.next(response);
        }
      }
    } catch (e) {
      // print(e.toString() + option.path);
      //
      // return new ResultData(response.data, false, response.statusCode,
      //     headers: response.headers);
      print("ResponseError====" + e.toString() + "****" + option.path);

      response.data = ResultData(response.data, false, response.statusCode!,
          headers: response.headers);
      handler.next(response);
    }
    response.data = ResultData(response.data, false, response.statusCode!, headers: response.headers);
    handler.next(response);
    // return new ResultData(response.data, false, response.statusCode,
    //     headers: response.headers);
  }
}
