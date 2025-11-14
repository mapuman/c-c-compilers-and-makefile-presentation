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
1. Pereprocesor

...

2. kompilator

...

3. linkowanie

...

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

### Co zrobić gdy nasz projekt ma dużo plików i korzysta z wielu bibliotek?

Kompilowanie takiego projektu ręcznie jest żmudne i nanoszenie nawet małych zmian zmusza nas do wpisawania wielu linijek komend.

Istnieją jednak narzędzia do automatycznej kompilacji, które usprawniają ten proces. W tej prezentacji omówimy na przykładzie jedno z nich - ***make***.

Należy jednak pamiętać że istnieją inne alternatywy. Niektóre tworzone z myślą o konkretnm języku programowania. Dla przykładu:
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
### Podstawy make
Najprostszy sposób na uruchomienie make to wpisanie:

```bash
make
```
... i to wszystko. Make wykona wtedy pierwszą regułę w pliku tekstowego o nazwie ***Makefile***.

Możemy poprosić make o wykonanie reguł z innego pliku lub z innego katalogu, 
```bash
make -C new/directory -f weirdfilename.txt
```
Możemy również zrobić próbne wykonanie *na sucho* z flagami **-n** lub **--dry-run**.
Wtedy make tylko wypisze wszystkie komendy do konsoli bez ich wykonywania.

### Budowa reguły
Make wykonuje reguły, które mają taką budowę:
```makefile
CEL: ZALEŻNOŚCI
	POLECENIA (wykonywane w powłoce systemowej)
```
#### CEL (TARGET) to pliki które chcemy utworzyć lub zadanie ktore chcemy utworzyć.
#### ZALEŻNOŚĆI (DEPENDENCIES)- pliki lub inne zadania.
#### POLECENIA - komendy, które mają utworzyć target.


