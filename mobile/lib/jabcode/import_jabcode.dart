/*
 * @file import_jabcode.dart
 * @author Sciroccogti (scirocco_gti@yeah.net)
 * @brief 
 * @date 2022-07-12 16:33:45
 * @modified: 2022-07-12 16:34:20
 */
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
import 'generated_jabcode.dart';

final DynamicLibrary jabCodeLib = Platform.isAndroid
    ? DynamicLibrary.open('libjabcode.so')
    : DynamicLibrary.process();

final JABCode jabCode = () {
  JABCode genJABCode = JABCode(jabCodeLib);
  return genJABCode;
}.call();