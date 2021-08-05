import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'code.dart';
import 'dio_log_interceptor.dart';
import 'response_interceptor.dart';

import 'address.dart';
import 'result_data.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio? _dio;

  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String? baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(
          new BaseOptions(baseUrl: Address.BASE_URL, connectTimeout: 15000));
      _dio?.interceptors.add(new DioLogInterceptor());
//      _dio.interceptors.add(new PrettyDioLogger());
      _dio?.interceptors.add(new ResponseInterceptors());

    }
  }

  static HttpManager getInstance({String? baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio!.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio!.options.baseUrl != Address.BASE_URL) {
        _dio!.options.baseUrl = Address.BASE_URL;
      }
    }
    return this;
  }

  ///通用的GET请求
  get(api, {params, withLoading = true}) async {
    if (withLoading) {
      EasyLoading.show();
    }
    //var token = StorageManager.sharedPreferences!.getString("TOKEN");

    // _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
    //   options.headers.addAll({"Authorization":"Bearer $token"});//此处在请求前配置了存储在SharedPreferences里面的token，没需要可以不加
    //   print("开始请求");
    //   // Do something before request is sent
    //   return options; //continue
    // }));
    Map<String, dynamic> httpHeaders = {
      'Accept': 'application/json,*/*',
      'Content-Type': 'application/json',
      //'Authorization':'Bearer $token',
    };
    Options options= new Options(headers: httpHeaders,responseType: ResponseType.plain,);
    Response response;
    try {
      response = await _dio!.get(api, queryParameters: params,options: options);
      if (withLoading) {
        EasyLoading.dismiss();
      }
      print("sss"+response.data.toString());
    } on DioError catch (e) {
      if (withLoading) {
        EasyLoading.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ///通用的POST请求
  post(api, {params, withLoading = true}) async {
    if (withLoading) {
      EasyLoading.show();
    }
    //var token = StorageManager.sharedPreferences!.getString("TOKEN");
    Response response;
    Map<String, dynamic> httpHeaders = {
      'Accept': 'application/json,*/*',
      'Content-Type': 'application/json',
      //'Authorization':'Bearer $token',
    };

    Options options= new Options(headers: httpHeaders,responseType: ResponseType.plain,);
    try {
      response = await _dio!.post(api, data: params,options: options);
      if (withLoading) {
        EasyLoading.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        EasyLoading.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }
}

ResultData resultError(DioError e) {
  Response errorResponse;
  if (e.response != null) {
    errorResponse = e.response!;
  } else {
    errorResponse = new Response(statusCode: 666,requestOptions: RequestOptions(path: ''));
  }
  if (e.type == DioErrorType.connectTimeout ||
      e.type == DioErrorType.receiveTimeout) {
    errorResponse.statusCode = Code.NETWORK_TIMEOUT;
  }
  return new ResultData(
      errorResponse.statusMessage, false, errorResponse.statusCode!);
}
