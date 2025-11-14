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

3. konsolidator

...

**Jak uzywac GNU najpopularniejszego kompilatora dla c/c++ ?**
 
 kompilacja i uruchomienie pierwszego programu 
```bash
gcc main.c | ./a.out

```


...



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


