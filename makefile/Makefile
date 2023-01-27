
OS_NAME=$(OS)
UNAME_S:= $(shell uname -s)

ifeq ( $(OS), WIndows_NT )
	OS_NAME="windows"
else
ifeq (${UNAME_S},Linux)
	OS_NAME="linux"
	# FORM=.so
	# LIB_NAME=${LIB_BASIC}${FORM}
	# CXXFLAGS= -shared
endif
ifeq ($(UNAME_S),Darwin)
	OS_NAME="mac"
	# FORM=.dylib
	# LIB_NAME=${LIB_BASIC}${FORM}
	# CXXFLAGS= -shared
endif
endif

all:
ifneq ($(OS_NAME), "linux")
	echo "${OS_NAME} not provide..."
	exit 1
endif

	echo "provide..."