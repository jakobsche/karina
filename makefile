# Derived variables

Target = $(Target_CPU)-$(Target_OS)
BinTargetDir = bin/$(Target)/karina
BinTargetLocaleDir = $(BinTargetDir)/locale


# Default (final) targets

default: $(BinTargetDir)/karina $(BinTargetDir)/Karina.desktop $(BinTargetDir)/karina.ico defaultlocale

defaultwin: $(BinTargetDir)/karina.exe defaultlocale


# Required targets

# all language files
defaultlocale: $(BinTargetLocaleDir)/karina.po $(BinTargetLocaleDir)/karina.en.po $(BinTargetLocaleDir)/karina.de.po $(BinTargetLocaleDir)/karina.es.po $(BinTargetLocaleDir)/karina.fr.po $(BinTargetLocaleDir)/karina.ru.po

# executable app file except for Windows
$(BinTargetDir)/karina: $(BinTargetDir) lib/$(Target)/karina
	strip -o $(BinTargetDir)/karina lib/$(Target)/karina

# executable app file for Windows
$(BinTargetDir)/karina.exe: $(BinTargetDir) lib/$(Target)/karina.exe
	strip -o $(BinTargetDir)/karina.exe lib/$(Target)/karina.exe

# Linux desktop file
$(BinTargetDir)/Karina.desktop: Karina.desktop
	cp Karina.desktop $(BinTargetDir)/

$(BinTargetDir)/karina.ico: karina.ico
	cp karina.ico $(BinTargetDir)/

# target directory for binaries
$(BinTargetDir): bin/$(Target) 
	if !(test -e $(BinTargetDir)) then mkdir $(BinTargetDir) ; fi
	
bin/$(Target): bin
	if !(test -e bin/$(Target)) then mkdir bin/$(Target) ; fi
	

# language files

$(BinTargetLocaleDir)/karina.po: $(BinTargetLocaleDir) locale/karina.po
	cp locale/karina.po $(BinTargetLocaleDir)/

$(BinTargetLocaleDir)/karina.de.po: $(BinTargetLocaleDir) locale/karina.de.po
	cp locale/karina.de.po $(BinTargetLocaleDir)/

$(BinTargetLocaleDir)/karina.es.po: $(BinTargetLocaleDir) locale/karina.es.po
	cp locale/karina.es.po $(BinTargetLocaleDir)/

$(BinTargetLocaleDir)/karina.en.po: $(BinTargetLocaleDir) locale/karina.en.po	
	cp locale/karina.en.po $(BinTargetLocaleDir)/

$(BinTargetLocaleDir)/karina.fr.po: $(BinTargetLocaleDir) locale/karina.fr.po	
	cp locale/karina.fr.po $(BinTargetLocaleDir)/

$(BinTargetLocaleDir)/karina.ru.po: $(BinTargetLocaleDir) locale/karina.ru.po
	cp locale/karina.ru.po $(BinTargetLocaleDir)/
	
$(BinTargetLocaleDir): $(BinTargetDir)
	if !(test -e $(BinTargetLocaleDir)) then mkdir $(BinTargetLocaleDir) ; fi
	
bin:
	if !(test -e bin) mkdir bin ; fi
	
lib/$(Target)/karina lib/$(Target)/karina.exe: karina.lpi
	lazbuild -r --os=$(Target_OS) --cpu=$(Target_CPU) karina.lpi
