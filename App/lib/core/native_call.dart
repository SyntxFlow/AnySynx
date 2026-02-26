import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'dart:convert';

typedef FetchNativePost = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
typedef FetchPost = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);

typedef TestingNative = Pointer<Utf8> Function();
typedef Testing = Pointer<Utf8> Function();

typedef FreeNativePost = Void Function(Pointer<Utf8>);
typedef Free = void Function(Pointer<Utf8>);

class RustApi {
  late DynamicLibrary _lib;
  late FetchPost _fetchPost;
  late Free _free;

  late Testing _testing;

  RustApi() {
    if (Platform.isAndroid) {
      _lib = DynamicLibrary.open("libnative_rust.so");
      print("[Native] File .so berhasil dipanggil.");
    }

    _testing = _lib
        .lookup<NativeFunction<TestingNative>>("testing")
        .asFunction();

    _fetchPost = _lib
        .lookup<NativeFunction<FetchNativePost>>("fetch_api_post_json")
        .asFunction();

    _free = _lib
        .lookup<NativeFunction<FreeNativePost>>("free_string")
        .asFunction();
  }

  String fetchPost(String url, Map<String, dynamic> json) {
    final urlPtr = url.toNativeUtf8();

    final jsonString = jsonEncode(json);
    final jsonPtr = jsonString.toNativeUtf8();

    final resultPtr = _fetchPost(urlPtr, jsonPtr);
    malloc.free(urlPtr);
    malloc.free(jsonPtr);

    final result = resultPtr.toDartString();
    _free(resultPtr);

    return result;
  }

  String testing() {
    final resultPtr = _testing();
    final result = resultPtr.toDartString();
    _free(resultPtr);

    return result;
  }
}
