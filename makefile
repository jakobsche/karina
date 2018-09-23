BIN:	bin/arm-linux/karina bin/i386-linux/karina bin/i386-win32/karina.exe bin/x86_64-linux/karina bin/i386-linux/locale bin/i386-win32/locale bin/x86_64-linux/locale bin/arm-linux/locale 

bin/arm-linux/karina:	lib/arm-linux/karina
	strip -o bin/arm-linux/karina lib/arm-linux/karina

bin/i386-linux/karina: lib/i386-linux/karina
	strip -o bin/i386-linux/karina lib/i386-linux/karina

bin/i386-win32/karina.exe: lib/i386-win32/karina.exe
	strip -o bin/i386-win32/karina.exe lib/i386-win32/karina.exe

bin/x86_64-linux/karina: lib/x86_64-linux/karina
	strip -o bin/x86_64-linux/karina lib/x86_64-linux/karina

bin/arm-linux/locale: locale
	cp -uv locale bin/arm-linux/

bin/i386-linux/locale: locale
	cp -uv locale bin/i386-linux/

bin/i386-win32/locale: locale
	cp -uv locale bin/i386-win32/

x86_64-linux/locale: locale
	cp -uv locale bin/c86_64-linux/

locale:

lib/x86_64-linux/karina:

lib/i386-win32/karina.exe:

lib/i386-linux/karina:

lib/arm-linux/karina:
