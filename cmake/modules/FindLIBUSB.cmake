# This CMake script wants to use libusb functionality, therefore it looks 
# for libusb include files and libraries. 
#
# Operating Systems Supported:
# - Unix (requires pkg-config)
#   Tested with Ubuntu 9.04 and Fedora 11
# - Windows (requires MinGW)
#   Tested with Windows XP/Windows 7
#
# This should work for both 32 bit and 64 bit systems.
#
# Author: F. Kooman <fkooman@tuxed.net>
#

FIND_PACKAGE(PkgConfig)
IF(PKG_CONFIG_FOUND)
  PKG_CHECK_MODULES(LIBUSB REQUIRED libusb-1.0)
ENDIF(PKG_CONFIG_FOUND)

IF(NOT LIBUSB_FOUND)
  FIND_PATH(LIBUSB_INCLUDE_DIRS NAMES libusb.h PATH_SUFFIXES libusb-1.0)
  FIND_LIBRARY(LIBUSB_LIBRARIES NAMES libusb-1.0)
ENDIF(NOT LIBUSB_FOUND)

INCLUDE(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LIBUSB REQUIRED_VARS LIBUSB_INCLUDE_DIRS LIBUSB_LIBRARIES)
