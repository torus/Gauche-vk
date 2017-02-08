# General info
SHELL       = /bin/sh
prefix      = /home/toru/local
exec_prefix = ${prefix}
bindir      = ${exec_prefix}/bin
libdir      = ${exec_prefix}/lib
datadir     = ${datarootdir}
datarootdir = ${prefix}/share
srcdir      = .
VPATH       = $(srcdir)

# These may be overridden by make invocators
DESTDIR        =
GOSH           = "/home/toru/local/bin/gosh"
GAUCHE_CONFIG  = "/home/toru/local/bin/gauche-config"
GAUCHE_PACKAGE = "/home/toru/local/bin/gauche-package"
INSTALL        = "/home/toru/local/bin/gauche-install" -C

# Other parameters
SOEXT  = so
OBJEXT = o
EXEEXT = 
LOCAL_PATHS = ""

# Module-specific stuff
PACKAGE   = Gauche-vk

ARCHFILES = vk.$(SOEXT)
SCMFILES  = $(srcdir)/vk.scm
HEADERS   =

TARGET    = $(ARCHFILES)
GENERATED =
CONFIG_GENERATED = Makefile config.cache config.log config.status \
		   configure.lineno autom4te*.cache $(PACKAGE).gpd

GAUCHE_PKGINCDIR  = "$(DESTDIR)${libdir}/gauche-0.9/site/include"
GAUCHE_PKGLIBDIR  = "$(DESTDIR)${datadir}/gauche-0.9/site/lib"
GAUCHE_PKGARCHDIR = "$(DESTDIR)${libdir}/gauche-0.9/site/x86_64-pc-linux-gnu"

vk_SRCS = $(srcdir)/vk.c $(srcdir)/vklib.stub

all : $(TARGET)

vk.$(SOEXT): $(vk_SRCS)
	$(GAUCHE_PACKAGE) compile \
	  --local=$(LOCAL_PATHS) --verbose vk $(vk_SRCS)

check : all
	@rm -f test.log
	$(GOSH) -I. -I$(srcdir) $(srcdir)/test.scm > test.log

install : all
	$(INSTALL) -m 444 -T $(GAUCHE_PKGINCDIR) $(HEADERS)
	$(INSTALL) -m 444 -T $(GAUCHE_PKGLIBDIR) $(SCMFILES)
	$(INSTALL) -m 555 -T $(GAUCHE_PKGARCHDIR) $(ARCHFILES)
	$(INSTALL) -m 444 -T $(GAUCHE_PKGLIBDIR)/.packages $(PACKAGE).gpd

uninstall :
	$(INSTALL) -U $(GAUCHE_PKGINCDIR) $(HEADERS)
	$(INSTALL) -U $(GAUCHE_PKGLIBDIR) $(SCMFILES)
	$(INSTALL) -U $(GAUCHE_PKGARCHDIR) $(ARCHFILES)
	$(INSTALL) -U $(GAUCHE_PKGLIBDIR)/.packages $(PACKAGE).gpd

clean :
	$(GAUCHE_PACKAGE) compile --clean vk $(vk_SRCS)
	rm -rf core $(TARGET) $(GENERATED) *~ test.log so_locations

distclean : clean
	rm -rf $(CONFIG_GENERATED)

maintainer-clean : clean
	rm -rf $(CONFIG_GENERATED)  VERSION

