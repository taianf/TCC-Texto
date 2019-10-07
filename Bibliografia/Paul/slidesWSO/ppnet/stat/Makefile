CC          := gcc
TAR         := tar

PROGRAM     := prog
SRCFILES    := stat.c
HEADERFILES := #my_lib.h
OTHERFILES  := Makefile
DISTFILES   := $(OTHERFILES) $(SRCFILES) $(HEADERFILES)
TARFILE     := $(PROGRAM).tgz

CFLAGS      := -g 
LFLAGS      := -lm
DEB_CFLAGS  := -DDEBUG
DEB_PROG    := deb_prog

HOME        := $(shell pwd)

all: clean $(PROGRAM)

debug: clean newFlag all

newFlag: 
	$(eval CFLAGS := $(CFLAGS) $(DEB_CFLAGS))
	@echo $(CFLAGS)

clean:
	rm -f $(SRCFILES:.c=.o) $(DEB_PROG) $(PROGRAM) *.o

archive: $(TARFILE)

recompile: clean all

$(PROGRAM): $(SRCFILES:%.c=%.o)
	$(CC) $(CFLAGS) $(LFLAGS) -o $@ $^
#	$(HOME)/$(PROGRAM)

%.o: %.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c $<

$(TARFILE): $(DISTFILES)
	rm -f $@
	$(TAR) czf $@ $^

.PHONY: all clean archive
