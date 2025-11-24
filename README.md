# kompilatory i makefile w c/c++


### kompilatory 
**Co to jest kompilator?**

*Kompilator to program komputerowy, który automatycznie tłumaczy kod źródłowy napisany w języku wysokiego poziomu (np. C++) na kod wynikowy, najczęściej język maszynowy zrozumiały dla procesora*

**Najpopularniejsze kompilatory**
* C/C++
    *  [GNU ( makro : g++, gcc)](https://gcc.gnu.org/onlinedocs/gcc.pdf)
    * CLANG
    * etc
* Dla innych jezykow np Rust: rustc, Java: javac etc

**Proces kompilacji**

***1. Preprocessing (Krok przedkompilacyjny)***
Co się dzieje: Przetworzenie dyrektyw preprocesora

Działania:

Włączenie plików nagłówkowych (#include)

Rozwinięcie makr (#define)

Kompilacja warunkowa (#ifdef, #ifndef)

Rezultat: Czysty kod C++ bez dyrektyw preprocesora

***2. Kompilacja właściwa (Translation)***
Co się dzieje: Tłumaczenie kodu C++ na kod asemblera

Działania:

Analiza składniowa i semantyczna

Kontrola typów

Generacja kodu asemblera dla danego procesora

Rezultat: Plik w assemblerze (.s lub .asm)

***3. Asemblacja (Assembly)***
Co się dzieje: Tłumaczenie kodu asemblera na kod maszynowy

Działania:

Konwersja instrukcji asemblera na binarne kody operacji

Tworzenie plików obiektowych

Rezultat: Plik obiektowy (.o lub .obj)

***4. Linkowanie (Linking)***
Co się dzieje: Łączenie wszystkich plików obiektowych w jeden program

Działania:

Rozwiązywanie referencji między plikami

Łączenie z bibliotekami standardowymi

Tworzenie finalnego pliku wykonywalnego

Rezultat: Gotowy program (.exe na Windows, bez rozszerzenia na Linux)


**Jak uzywac GNU najpopularniejszego kompilatora dla c/c++ ?**
 
 kompilacja i uruchomienie pierwszego programu 
```bash
gcc main.c | ./a.out

```
mozemy rowniez okreslic nazwe jaka pliku w ze skompilowanym kodem domyslnie plik nazywa sie **a.out**
```bash
gcc main.c -o result
```
po za flaga -o warto rowniez znac inne flagi takie jak: 

* **-c** : przeprowasza tylko wstepna kompilacje (pomija ostatni etap nie linkuje pliku) rozszerzenie .o
* **-S** generuje kod assembly nie kompiluje ani nie linkuje rozszerzenie .s
* **-E** tylko preprocesuje kod roszerzenie .c

dodatkowo istnieja tez flagi ktore przy kompilacji generuja nam ostrzezenie i ogolnie sa pomocne pryz debugowaniu np: **zadeklarowane zmienne ktore nie zostaly uzyte, funkcje typu innego niz void ktore niczego nie zwracaja, pominiete nawiasy...**

```bash
gcc -Wall main.c
 ```
 bedzie generowala wszystkie najczestsze ostrzeznia np:

Istnieja rowniez inne poziomy flagi -Wall np Wextra albo Werror ale dla wiekoszosci zastosowan Wall jest wystarczajaca 

Dodatkowo mamy flagi ktore okreslaja poziom otymalizacji kompilacji: **O/O1/O2/O3**  
```bash
 gcc -O1 main.c 
 ```
 Im wyzsza wyzszy numer znajdzie sie przy fladze tym teorytycznie szybciej bedzie wykonywal sie nasz program jednak obedzie sie to kosztem dluzszego czasu kompilacji samego programu moze to byc szczegonie uciazliwe w przypadku duzych projektow

warto tez wiedziec o flagach ktore okreslaja standard jezyka w ktorym ma byc kompilowany nasz program

```bash
gcc -std=c++20 main.cpp  
```
w przykladzie u gory skompilujemy zgodnie ze standarderm c++20

Dodawanie bibliotek wyglada w ten sposob **-l + [nazwa biblioteki/skrot]**:
```bash 
gcc main.c -o calc -lm
```
np tak dodajemy biblioteke math

Mozemy tez okreslic lokalna sciezke do biblioteki uwzwajac **-L** np: 
```bash
g++ main.cpp -o app -L/usr/local/lib -lmyframework
```

## Co zrobić gdy nasz projekt ma dużo plików i korzysta z wielu bibliotek?

Kompilowanie takiego projektu ręcznie jest żmudne i nanoszenie nawet małych zmian zmusza nas do wpisawania wielu linijek komend.

Istnieją jednak narzędzia do automatycznej kompilacji, które usprawniają ten proces. W tej prezentacji omówimy na przykładzie jedno z nich - ***make***.

Należy pamiętać że istnieją inne alternatywy. Niektóre tworzone z myślą o konkretnym języku programowania. Dla przykładu:
* Cmake ( C/C++ )
* Apache Maven, Gradle, Ant (Java)

### Instalowanie

Aby móc korzystać z tego programu musimy sprawdzić czy mamy go zainstalowanego.

```bash
apt list --installed | grep make/
```
... i go ewentualnie zainstalować:

```bash
sudo apt install make
```
## Podstawy make
Make uruchamiamy wpisując:

```make
make
```
... i to wszystko. Make wykona wtedy pierwszą regułę w pliku o nazwie ***Makefile*** albo ***makefile***.

Make może wykonać reguły z innego pliku lub z innego katalogu:
```bash
make -f make-weirdname/DoNotNameFiles.likeThis
```
Możemy również zrobić próbne wykonanie *na sucho* z flagami **-n** lub **--dry-run**.
Wtedy wszystkie komendy zostaną wypisane do konsoli bez ich wykonywania.

#### ***W Make polecenia w regułach muszą zaczynać się od tabulatora. Użycie spacji zamiast tabulatora spowoduje błąd!***

### Budowa reguły
Make wykonuje reguły, które mają taką budowę:
```Makefile
CEL: ZALEŻNOŚCI
	POLECENIA 
```
#### CEL (TARGET) to pliki które chcemy utworzyć lub zadanie, ktore chcemy utworzyć.
#### ZALEŻNOŚCI (DEPENDENCIES)- pliki lub inne zadania.
#### POLECENIA - wykonywane są w powłoce systemowej

 Make wykona regułe tylko wtedy, gdy któryś element drzewa zależności został zmieniony później niż data modyfikacji CELU.

Konkretną regułę możemy włączyć dając ją jako argument Make.

### Uwaga! Poleceń Make nie można traktować tak jak Basha!
**\$\( \)** - jest symbolem odczytu zmiennej / uruchomienia funkcji wbudowanej w Make.
Aby uruchomić podprogram w shellu należy użyć "$$( )".
```Makefile
rule:
    @echo $$(cat a.txt)
```
Każda linia reguły wykonywana jest w osobnym shellu.
W poniższnym przykładzie pwd nie zadziała w sposób oczekiwany:
```Makefile
rule:
    cd source
    pwd
```
### .PHONY i .SILENT
W Make możemy określić dyrektywami cel naszej reguły:
* .PHONY - informujemy że reguła nie jest powiązana z żadnym plikiem/folderem.
* .SILENT - wyłączamy domyślne wypisywanie każdej wykonanej linii skryptu przez Make.
```Makefile
.PHONY: rule0 rule1 rule2
.SILENT: rule1 rule2
```

## Zmienne i wzorce w Make
#### Mamy kilka typów zmiennych w Make:
* **:=** przypisanie od razu, natychmiast
* **=** leniwe przypisanie - przy każdym użyciu wartość zmiennej jest ponownie obliczana
* **?=** warunkowe przypisanie - następuje wtw gdy zmienna nie ma wartości
* **+=** Zwykłe dopisanie do istniejącej zmiennej

#### Nie można nie wspomnieć tutaj o zmiennych automatycznych:
* **$@** - target
* **$<** - pierwsza zależność ( liczy się do spacji !)
* **$+** - wszystkie zależności (z duplikatami)
* **$^** - wszystkie zależności (bez duplikatów)
* **$\*** - część nazwy dopasowana przez % w regule wzorcowej.

Wywołując make możemy ustawić początkową wartość zmiennej:
```Makefile
GCC ?= g++
main: main.cpp
    $(GCC) main.cpp -o main
```
```bash
make GCC="clang"
```

#### Dopasowanie wzorów
Możemy za pomocą symbolu **%** dopasować prerekwizyt do targetu i vice versa.
```Makefile
%.o: %.cpp
    g++ -c $< -o $@
```
W przykładzie: dla każdego pliku .o, od którego będzie zależał inny plik w regule, zastosowanie ma ta reguła.

## Podsumowanie

### Kompilację w C/CPP możemy podzielić na:
#### 1. Preprocessing
#### 2. Kompilację ( do kodu assemblerowego )
#### 3. Asemblację ( do plików obiektowych )
#### 4. Linkowanie ( plików obiektowych z bibliotekami )

### Make automatyzuje proces kompilacji, linkowania i uruchamiania programów w C/C++. Ułatwia i usprawnia tworzenie bibliotek, zarządzanie zależnościami oraz wykonywanie własnych skryptów. 


