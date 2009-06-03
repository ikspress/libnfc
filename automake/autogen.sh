#!/bin/sh

rm -rf autom4te.cache
rm -f aclocal.m4 ltmain.sh

touch README

LIBTOOLIZE=libtoolize
SKIP_PCSC="0"

case `uname -s` in
Darwin)
  LIBTOOLIZE=glibtoolize
  ACLOCAL_ARGS="-I /opt/local/share/aclocal/"
  SKIP_PCSC="1"
  ;;
FreeBSD)
  ACLOCAL_ARGS="-I /usr/local/share/aclocal/"
  ;;
esac

echo "Running aclocal..." ; aclocal $ACLOCAL_ARGS -I . || exit 1
echo "Running autoheader..." ; autoheader || exit 1
echo "Running autoconf..." ; autoconf || exit 1
echo "Running libtoolize..." ; $LIBTOOLIZE --force --automake || exit 1
echo "Running automake..." ; automake --add-missing --copy --gnu || exit 1

if [ -z "$NOCONFIGURE" ]; then
	./configure "$@"
fi