
# podstawienie warunkowe - jesli zmienna nie ma zadnej wartosci to przypisz ja
GCC ?= g++
FLAGS ?= -g -Wall -Weffc++ -O3

# zwykle podstawienie
SOURCE_DIR := source
HEADER_DIR := include

# leniwe podstawienie (za kazdym razem podstawia przy korzystaniu z wartosci zmiennej)
OBJ_DIR = build/obj
ASM_DIR = build/asm
PREPROC_DIR = build/pre
LIB_DIR = build/lib
BIN_DIR = build/bin

# Make ma kilka przydatnych funckji. Wildcard wyszukuje wzorców,
# a patsubst szuka wzorcow i w ich miejsce wkleja inny wzorzec
SRC = $(wildcard $(SOURCE_DIR)/*.cpp)
OBJ = $(patsubst $(SOURCE_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC))
HEADERS = $(wildcard $(HEADER_DIR)/*.h)

# Oznaczamy tak reguły bez plików - potrzebne by unikać konfliktów nazw reguły z
# istniejącymi plikami/katalogami
.PHONY: T all clean

all: $(BIN_DIR)/main asmExample preprocExample

# Ladne wypisanie stuktury projektu
T:
	tree -C -L 2
	
clean:
	rm -rf build


# Nazwy po znaku | oznaczają że te pliki/foldery muszą istnieć przed wykonaniem reguły
# Make wykona ich regułę jeśli nie zostały stworzone
$(BIN_DIR)/main: $(OBJ) | $(BIN_DIR)
	$(GCC) $(FLAGS) $+ -o $@

# Makefile Możemy dopasować wzorzec symbolem %

$(OBJ_DIR)/%.o: $(SOURCE_DIR)/%.cpp $(HEADERS) | $(OBJ_DIR)
	$(GCC) $(FLAGS) -c $< -o $@

# Przykład kompilacji do assemblera i preprocesora

.PHONY: asmExample preprocExample
.SILENT: asmExample preprocExample

asmExample: $(SOURCE_DIR)/main.cpp $(HEADERS) | $(ASM_DIR)
	$(GCC) $(FLAGS) -S $< -o $(ASM_DIR)/main.s

preprocExample: $(SOURCE_DIR)/main.cpp $(HEADERS) | $(PREPROC_DIR)
	$(GCC) $(FLAGS) -E $< -o $(PREPROC_DIR)/main.ii


# Mozemy automatycznie tworzyc katalogi
$(OBJ_DIR):
	mkdir -p $@

$(BIN_DIR):
	mkdir -p $@

$(PREPROC_DIR):
	mkdir -p $@

$(ASM_DIR):
	mkdir -p $@

$(LIB_DIR):
	mkdir -p $@
