# Makefile

## check directory exists

```makefile
dir=some_dir
mkfile_path:=$(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir:=$(dir $(mkfile_path))

var=$(wildcard $(dir))

all:
	@echo ${dir}
	@echo ${mkfile_path}
	@echo ${mkfile_dir}
	@echo ${var}
	
	if [ -d ${dir} ]; then \
		echo "dir ex."; \
	else \
		echo "DIR not ex."; \
	fi;
```

```makefile
all:
# ifeq 앞 tab 간격 주의!
ifeq (, $(wildcard $(dir)))
	echo "not exists..."
else
	echo "Exists..."
endif
```

## using PKG

```makefile
LDFLAGS:=$(shell pkg-config --libs [lib_name])
```
