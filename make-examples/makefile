GCC ?= g++

%.o: %.cpp
	$(GCC) "$<" -c -o "$@"

.PHONY: rule pwdExample pwdSilent

rule:
	echo $$(cat a.txt)

pwdExample:
	cd foo
	pwd
	cd foo && pwd

.SILENT: pwdSilent
pwdSilent:
	cd foo
	pwd
	cd foo && pwd

base := a b c

FOO := $(base)
BAR = $(base)

base += HelloThere

CompAssignment:
	@echo FOO := $(FOO)
	@echo BAR "(lazy)" = $(BAR)

