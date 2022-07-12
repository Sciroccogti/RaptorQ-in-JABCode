cmake_minimum_required(VERSION 3.4.1) # for example

set(JABCODE_SRC_PATH ../../jabcode/src/jabcode/)

set(SOURCES ${JABCODE_SRC_PATH}/test.cpp)

# set(SOURCES
# ${JABCODE_SRC_PATH}/binarizer.c
# ${JABCODE_SRC_PATH}/decoder.c
# ${JABCODE_SRC_PATH}/detector.c
# ${JABCODE_SRC_PATH}/encoder.c
# ${JABCODE_SRC_PATH}/image.c
# ${JABCODE_SRC_PATH}/interleave.c
# ${JABCODE_SRC_PATH}/mask.c
# ${JABCODE_SRC_PATH}/ldpc.c
# ${JABCODE_SRC_PATH}/pseudo_random.c
# ${JABCODE_SRC_PATH}/sample.c
# ${JABCODE_SRC_PATH}/transform.c)

add_library(
  jabcode
  # Sets the library as a shared library.
  SHARED
  # Provides a relative path to your source file(s).
  ${SOURCES})
