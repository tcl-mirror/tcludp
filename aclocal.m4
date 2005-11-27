#
# Include the TEA standard macro set
#

builtin(include,tclconfig/tcl.m4)

#
# Add here whatever m4 macros you want to define for your package
#

#--------------------------------------------------------------------
# TEA_ENABLE_INET6
#
#	Check for Internet Protocol v6 support.
#
#	Adds a --enable-ipv6 option to the configure program and 
#	may define a new macro USE_INET6
#
#--------------------------------------------------------------------

AC_DEFUN(TEA_ENABLE_INET6, [
    AC_MSG_CHECKING([for INET6 support])
    AC_ARG_ENABLE(inet6, [  --enable-ipv6          build with ipv6],
        [inet6_ok=$enableval], [inet6_ok=no])
    AC_DEFINE(USE_INET6)
    if test "$inet6_ok" = "yes"
    then
        AC_MSG_RESULT([yes])
        USE_INET6=1

        AC_CHECK_LIB(c,getaddrinfo,[inet6_ok=yes],[inet6_ok=no])
        if test "$inet6_ok" = "yes"
        then
            #CFLAGS="$CFLAGS -DUSE_INET6"
            TEA_ADD_CFLAGS([-DUSE_INET6])
        else
            USE_INET6=no
            AC_MSG_ERROR([Cannot find getaddrinfo() - inet6 support disabled])            
        fi

    else
        USE_INET6=0
        AC_MSG_RESULT([no (default)])
    fi

    AC_SUBST(USE_INET6)
])

#-------------------------------------------------------------------------
# TEA_PROG_DTPLITE
#
#	Do we have a usable dtplite program to use in document generation?
#
# Results
#	Sets up DTPLITE
#
#-------------------------------------------------------------------------

AC_DEFUN(TEA_PROG_DTPLITE, [
    AC_PATH_TOOL([DTPLITE], [dtplite], [:])
])

