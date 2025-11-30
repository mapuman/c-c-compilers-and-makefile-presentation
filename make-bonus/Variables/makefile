
sourceDirs := source/a.cpp source/b.cpp source/aha.cpp

buildDirsNotLazy := $(basename $(subst source/,build/bin/,${sourceDirs}) )
buildDirsLazy = $(basename $(subst source/,build/bin/,${sourceDirs}) )

sourceDirs += source/another.cpp

testWordDiff:
	@echo
	@echo --- Difference between variables := and = ---

#	Preparing temporary files:
	@mkdir temp -p
	@touch temp/__first.txt
	@touch temp/__second.txt

	@printf "%s\n" $(buildDirsLazy) > temp/__first.txt
	@printf "%s\n" $(buildDirsNotLazy) > temp/__second.txt
# '-' at the start of line ignores exit status in make. Make informs user if error was ignored.
	-@wdiff -s temp/__first.txt temp/__second.txt
	@echo -e "\n--- The second file doesnt't have build/bin/another! ---"
	@echo

# Alternative with no error message: pipe to true
# 	-wdiff -s temp/__first.txt temp/__second.txt || true
#	All error information is ignored!!!

# 	rm temp -rf
