VERSION := 0.2

all: module

module: build/yaml/yaml.luvit

#
# N.B. native Makefile was way tricky to tune, so we mimick it here
#

ROOT    := $(shell pwd)
CFLAGS  += -I$(LUA_DIR) -I$(ROOT)/build/yaml
OBJS    := $(addprefix build/yaml/,lyaml.o api.o dumper.o emitter.o loader.o parser.o reader.o scanner.o writer.o b64.o)

build/yaml/yaml.luvit: build/yaml $(OBJS)
	$(CC) -shared -o $@ $(OBJS)

build/yaml:
	mkdir -p build
	wget http://files.luaforge.net/releases/yaml/yaml/$(VERSION)/yaml-$(VERSION).tar.gz -O - | tar -xzpf - -C build
	mv build/yaml-$(VERSION) $@

clean:
	rm -fr build

.PHONY: all module clean
.SILENT: