# Derived variables

Target = $(Target_CPU)-$(Target_OS)
BinTargetDir = bin/$(Target)/karina
BinTargetLocaleDir = $(BinTargetDir)/locale


# Default (final) targets

default: $(BinTargetDir)/karina $(BinTargetDir)/Karina.desktop $(BinTargetDir)/karina.ico defaultlocale

defaultwin: $(BinTargetDir)/karina.exe defaultlocale


# Required targets

# all language files
defaultlocale: $(BinTargetLocaleDir)/karina.po $(BinTargetLocaleDir)/karina.en.po $(BinTargetLocaleDir)/karina.de.po $(BinTargetLocaleDir)/karina.es.po $(BinTargetLocaleDir)/karina.fr.po

# executable app file except for Windows
$(BinTargetDir)/karina: $(BinTargetDir) lib/$(Target)/karina
	strip -o $(BinTargetDir)/karina lib/$(Target)/karina

# executable app file for Windows
$(BinTargetDir)/karina.exe: $(BinTargetDir) lib/$(Target)/karina
	strip -o $(BinTargetDir)/karina.exe lib/$(Target)/karina.exe

# Linux desktop file
$(BinTargetDir)/Karina.desktop: Karina.desktop
	cp Karina.desktop $(BinTargetDir)/

$(BinTargetDir)/karina.ico: karina.ico
	cp karina.ico $(BinTargetDir)/

# target directory for binaries
$(BinTargetDir): bin/$(Target) 
	mkdir $(BinTargetDir)
	
bin/$(Target): bin
	mkdir bin/$(Target)
	
# Sprachdateien

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

$(BinTargetLocaleDir): $(BinTargetDir)
	mkdir $(BinTargetLocaleDir)
	
bin:
	mkdir bin
