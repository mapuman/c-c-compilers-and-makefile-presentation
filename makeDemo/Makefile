# =============================================
# MAKEFILE PRZYKŁAD - PROJEKT C++
# =============================================

# --- Zmienne konfiguracyjne ---
# Kompilator
CXX = g++
# Flagi kompilatora
CXXFLAGS = -Wall -Wextra -pedantic -std=c++17 -O2
# Flagi debug
DEBUG_FLAGS = -g -DDEBUG
# Flagi linkera
LDFLAGS = 
# Biblioteki
LIBS = -lpthread

# --- Ścieżki ---
# Katalog źródłowy
SRC_DIR = src
# Katalog nagłówkowy
INC_DIR = include
# Katalog build
BUILD_DIR = build
# Katalog binarny
BIN_DIR = bin

# --- Pliki ---
# Znajdź wszystkie pliki .cpp
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
# Przekształć .cpp w .o w katalogu build
OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
# Nazwa pliku wykonywalnego
TARGET = $(BIN_DIR)/myprogram

# --- Główne cele ---

# Cel domyślny - kompiluje program
all: $(TARGET)

# Kompilacja finalnego programu
$(TARGET): $(OBJECTS) | $(BIN_DIR)
	@echo "Linkowanie programu..."
	$(CXX) $(OBJECTS) $(LDFLAGS) $(LIBS) -o $(TARGET)
	@echo "Kompilacja zakończona: $(TARGET)"

# Kompilacja poszczególnych plików obiektowych
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	@echo "Kompilacja: $<"
	$(CXX) $(CXXFLAGS) -I$(INC_DIR) -c $< -o $@

# Tworzenie katalogów jeśli nie istnieją
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

# --- Cele serwisowe ---

# Czyszczenie - usuwa pliki obiektowe i wykonywalny
clean:
	@echo "Czyszczenie projektu..."
	rm -rf $(BUILD_DIR) $(BIN_DIR)

# Czyszczenie tylko plików obiektowych
clean-obj:
	@echo "Usuwanie plików obiektowych..."
	rm -rf $(BUILD_DIR)

# Kompilacja w trybie debug
debug: CXXFLAGS += $(DEBUG_FLAGS)
debug: all

# Instalacja (przykład)
install: $(TARGET)
	@echo "Instalacja programu..."
	cp $(TARGET) /usr/local/bin/

# Wyświetlenie pomocy
help:
	@echo "Dostępne cele:"
	@echo "  all      - Kompilacja programu (domyślny)"
	@echo "  debug    - Kompilacja z flagami debug"
	@echo "  clean    - Usuwa wszystkie pliki kompilacji"
	@echo "  clean-obj - Usuwa tylko pliki obiektowe"
	@echo "  install  - Instalacja programu"
	@echo "  help     - Wyświetla tę pomoc"

# --- Zależności między plikami ---
# Przykład specyficznych zależności (jeśli są potrzebne)
$(BUILD_DIR)/main.o: $(INC_DIR)/utils.h
$(BUILD_DIR)/utils.o: $(INC_DIR)/utils.h $(INC_DIR)/config.h

# --- Zmienne specjalne ---
# $@ - nazwa celu
# $< - pierwsza zależność
# $^ - wszystkie zależności
# $? - wszystkie zależności nowsze niż cel

# Informacja że te cele nie tworzą plików
.PHONY: all clean clean-obj debug install help

# =============================================
# KONIEC MAKEFILE
# =============================================
