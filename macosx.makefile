# XDD Makefile for MAC OSX
SHELL =		/bin/sh
CFLAGS =	-O2 -DOSX -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -g 
PROJECT =	xdd
OBJECTS =	xdd.o access_pattern.o barrier.o global_time.o initialization.o parse.o pclk.o read_after_write.o results.o ticker.o time_stamp.o verify.o
HEADERS = 	xdd.h pclk.h ticker.h misc.h 
TSOBJECTS =	timeserver.o pclk.o ticker.o
GTOBJECTS = gettime.o global_time.o pclk.o ticker.o

all:	xdd timeserver gettime

xdd:	$(OBJECTS) 
	gcc  -o xdd $(CFLAGS) $(OBJECTS) -lpthread -v
	mv -f xdd bin/xdd.osx

timeserver:	$(TSOBJECTS) 
	gcc  -o timeserver $(CFLAGS) $(TSOBJECTS) -lpthread -v
	mv -f timeserver bin/timeserver.osx

gettime:	$(GTOBJECTS) 
	gcc  -o gettime $(CFLAGS) $(GTOBJECTS) -lpthread -v
	mv -f gettime bin/gettime.osx

access_pattern.o:	access_pattern.c
	gcc  $(CFLAGS) -c access_pattern.c

barrier.o:	barrier.c
	gcc  $(CFLAGS) -c barrier.c

gettime.o: gettime.c
	gcc $(CFLAGS) -c gettime.c

global_time.o:	global_time.c
	gcc  $(CFLAGS) -c global_time.c

initialization.o:	initialization.c
	gcc  $(CFLAGS) -c initialization.c

parse.o:	parse.c
	gcc  $(CFLAGS) -c parse.c

pclk.o:	pclk.c 
	gcc  $(CFLAGS) -c pclk.c

read_after_write.o:	read_after_write.c
	gcc  $(CFLAGS) -c read_after_write.c

results.o:	results.c
	gcc  $(CFLAGS) -c results.c

ticker.o:	ticker.c
	gcc  $(CFLAGS) -c ticker.c

time_stamp.o:	time_stamp.c
	gcc  $(CFLAGS) -c time_stamp.c

timeserver.o: timeserver.c
	gcc $(CFLAGS) -c timeserver.c

verify.o: verify.c
	gcc $(CFLAGS) -c verify.c

xdd.o:  xdd.c 
	gcc  $(CFLAGS) -c xdd.c

dist:	clean
	tar cf ../dist.tar .
clean:
	-rm -f xdd timeserver gettime a.out $(OBJECTS) $(TSOBJECTS) $(GTOBJECTS)


