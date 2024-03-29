# XDD Makefile for SPARC Solaris
SHELL =		/bin/sh
CC    =		cc
CFLAGS =	-DSOLARIS -g
PROJECT =	xdd
OBJECTS =	xdd.o a$(CC)ess_pattern.o barrier.o global_time.o initialization.o parse.o pclk.o read_after_write.o results.o ticker.o time_stamp.o verify.o
HEADERS = 	xdd.h pclk.h ticker.h misc.h 
TSOBJECTS =	timeserver.o pclk.o ticker.o
GTOBJECTS = gettime.o global_time.o pclk.o ticker.o

all:	xdd timeserver gettime

xdd:	$(OBJECTS) 
	$(CC)  -o xdd $(CFLAGS) $(OBJECTS) -lsocket -lnsl -lpthread  -lxnet -lposix4 -v 
	mv -f xdd bin/xdd.solaris

timeserver: $(TSOBJECTS)
	$(CC) -o timeserver $(CFLAGS) $(TSOBJECTS) -lsocket -lnsl -v
	mv -f timeserver bin/timeserver.solaris

gettime: $(GTOBJECTS)
	$(CC) -o gettime $(CFLAGS) $(GTOBJECTS) -lsocket -lnsl -v
	mv -f gettime bin/gettime.solaris

a$(CC)ess_pattern.o:	access_pattern.c
	$(CC)  $(CFLAGS) -c access_pattern.c

barrier.o:	barrier.c
	$(CC)  $(CFLAGS) -c barrier.c

gettime.o: gettime.c
	$(CC) $(CFLAGS) -c gettime.c

global_time.o:	global_time.c
	$(CC)  $(CFLAGS) -c global_time.c

initialization.o:	initialization.c
	$(CC)  $(CFLAGS) -c initialization.c

parse.o:	parse.c
	$(CC)  $(CFLAGS) -c parse.c

pclk.o:	pclk.c 
	$(CC)  $(CFLAGS) -c pclk.c

read_after_write.o:	read_after_write.c
	$(CC)  $(CFLAGS) -c read_after_write.c

results.o:	results.c
	$(CC)  $(CFLAGS) -c results.c

ticker.o:	ticker.c
	$(CC)  $(CFLAGS) -c ticker.c

time_stamp.o:	time_stamp.c
	$(CC)  $(CFLAGS) -c time_stamp.c

timeserver.o: timeserver.c
	$(CC) $(CFLAGS) -c timeserver.c

verify.o: verify.c
	$(CC) $(CFLAGS) -c verify.c

xdd.o:  xdd.c 
	$(CC)  $(CFLAGS) -c xdd.c

dist:	clean
	tar cf ../dist.tar .
clean:
	-rm -f xdd timeserver gettime a.out $(OBJECTS) $(TSOBJECTS) $(GTOBJECTS)
