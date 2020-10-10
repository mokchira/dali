CC = gcc
GLC = glslc

CFLAGS = -Wall -Wno-missing-braces -Wno-attributes -fPIC
LDFLAGS = -L/opt/hfs18.0/dsolib -L/home/michaelb/lib
INFLAGS = -I/opt/hfs18.0/toolkit/include/HAPI -I/home/michaelb/dev
LIBS = -lm -ltanto -lvulkan -lxcb -lxcb-keysyms -lHAPIL
GLFLAGS = --target-env=vulkan1.2
BIN = bin
LIB = /home/michaelb/lib
LIBNAME = painter

O = build
GLSL = shaders
SPV  = shaders/spv

NAME = painter


DEPS =  \
		game.h \
		render.h \
		painter.h

OBJS =  \
		$(O)/game.o \
		$(O)/render.o \
		$(O)/painter.o \

SHADERS =  \

debug: CFLAGS += -g -DVERBOSE=1
debug: all

release: CFLAGS += -DNDEBUG -O2
release: all

all: bin lib tags

shaders: $(SHADERS)

clean: 
	rm -f $(O)/* $(LIB)/* $(BIN)/*

tags:
	ctags -R .

bin: main.c $(OBJS) $(DEPS) shaders
	$(CC) $(CFLAGS) $(INFLAGS) $(LDFLAGS) $(OBJS) $< -o $(BIN)/$(NAME) $(LIBS)

lib: $(OBJS) $(DEPS) shaders
	$(CC) -shared -o $(LIB)/lib$(LIBNAME).so $(OBJS)

staticlib: $(OBJS) $(DEPS) shaders
	ar rcs $(LIB)/lib$(NAME).a $(OBJS)

$(O)/%.o:  %.c $(DEPS)
	$(CC) $(CFLAGS) $(INFLAGS) -c $< -o $@

$(SPV)/%-vert.spv: $(GLSL)/%.vert
	$(GLC) $(GLFLAGS) $< -o $@

$(SPV)/%-frag.spv: $(GLSL)/%.frag
	$(GLC) $(GLFLAGS) $< -o $@

$(SPV)/%-rchit.spv: $(GLSL)/%.rchit
	$(GLC) $(GLFLAGS) $< -o $@

$(SPV)/%-rgen.spv: $(GLSL)/%.rgen
	$(GLC) $(GLFLAGS) $< -o $@

$(SPV)/%-rmiss.spv: $(GLSL)/%.rmiss
	$(GLC) $(GLFLAGS) $< -o $@
