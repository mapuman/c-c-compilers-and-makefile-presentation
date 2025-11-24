GCC ?= g++

%.o: %.cpp
	$(GCC) "$<" -c -o "$@"

.PHONY: rule pwdExample pwdSilent

rule:
	@echo $$(cat a.txt)

pwdExample:
	cd foo
	pwd
	cd foo && pwd

.SILENT: pwdSilent
pwdSilent:
	cd foo
	pwd
	cd foo && pwd

FOO := $(BAR)
BAR = HelloThere

Asignment:
	echo $(FOO)

FOO = $(BAR)
BAR = HelloThere

LazyAsignment:
	echo $(FOO)
