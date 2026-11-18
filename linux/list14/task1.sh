#!/usr/bin/env bash

: '
> Co to są pakiety `essential`?
Some packages are marked as `Essential` since they are absolutely necessary for the proper funcioning of the
system. The package management tools will refuse to remove these.
'

: '
> Jakie jest znaczenie prioritetów `required`, `important`, `standard`, `optional`, `extra`?
Required: packages that are necessary for the proper functioning of the system
Important: packages should be found on any Unix-like system
Standard: packages are standard on any Linux system, including a reasonably small but not too limited
  characted-mode system. Tools are included to be able to send e-mail (with mutt) and download files
  from archive servers.
Optional: packages include all those that you might reasonably want to install if you do not know
  what they are, or that do not have specialized requirements.
Extra: packages that either conflict with others with higher priorities, are only likely to be useful
  if you already know what they are, or have specialized requirements that make them unsuitable for "Optional"
'

: '
> Do jakich sekcji może należeć pakiet?
main - podstawowa sekcja. Wyłącznie wolne oprogramowanie, które nie narzuca ogreniczeń redystrybucji.
contrib - oprogramowanie darmowe, którego działanie zależy od programów niewolnych.
non-free - oprogramowanie niespełniające kryteriów wolnego oprogramowania Debiana (zamknięty kod źródłowy, itp).
non-free-firmware - zawiera niewolne oprogramowanie firmware niezbędne do działania niektórych urządzeń
  sprzętowych, które wydzielone z non-free.
'

: '
> Jakie jest znaczenie list pakietów: `depends`, `pre-depends`, `recommends`, `suggests`, `breaks`, 
  `conflicts`, `replaces`, `provides`?
Package A `depends` on Package B if B absolutely must be installed in order to run A. In some cases, A depends
not only on B, but on a version of B. In this case, the version dependency is usually a lower limit, in the
sense the A depends on any version of B more recent than some specified version.

`Pre-Depends` is a special dependency. In the case of most packages, `dpkg` will unpack the archive file of 
a package (i.e., its `.deb` file) independently of whether or not the files on which it depends exist on the system.
If those packages `depend` on the existenc eof some other packages on your system, `dpkg` will refuse to complete
the installation. However, for some packages, `dpkg` will refuse even to unpack them until certain dependencies are
resolved. Such packages are said to `Pre-depend` on the presence of some other packages. 

Package A `recommends` Package B, if the package maintener judges that most users would not want A without also
having the functionality provided by B.

Package A `suggests` Package B if B constains files that are related to (and usually enhance) the functionality of A.

Package A `conflicts` with Package B when A will not operate if B is installed on the system. Most often, conflicts
are cases where A contains files which are an improvement over those in B. `Conflicts` are often combined with `replaces`.

Package A `replaces` Package B when files installed by B are removed and (in some cases) over-written by files in A.

Package A `breaks` Package B when both packages cannot be simultaneously configured in a system. The package
management system will refure to install one if the other one is already installed and configured in the system.

Package A `provides` Package B when all of the files and functionalities of B are incorporated into A. This mechanism
provides a way for users with constrained disk space to get only that part of package A which they really need.
'

: '
> Co to jest `debtag`?
Debtags is a set of categories to describe Debian packages.
Examples:
role::program
interface::commandline
use::editing
works-with::text
implemented-in::python
'

: '
> Co to jest status dpkg/dselect pakietu?
Jedyne co znalazłem:
- są to statusy pakiety w systemie, takie jak install ok installed, deinstall ok deinstall, purge ok not-installed,
  half-configured, unpacked
- w `dpkg` status pakietu składa się z trzech części `want / error / status`
'

: '
> Jakie dodatkowe stany pakietu przechowuje `apt`?
automatycznie zainstalowany / ręcznie zainstalowany
$ apt-mark auto package
$ apt-mark manual package
Pakiety oznaczone jako automatyczne mogą zostać usunięte przez:
$ apt autoremove

Pakiet może być zatrzymany:
$ apt-mark hold package
$ apt-mark unhold package

Dodatkowo `apt` przechowuje wierzę o dostęþnych wersjach pakietów, repozytoriach

$ apt policy code
'

: '
> Jakie dodatkowe stany pakietu przechowuje `aptitude`?
To samo co `apt` oraz

1) hold / keep (zatrzymany lub oznaczone, żeby zachować obecną wersję)
2) forbid-version (zabranianie instalacji konkretnej wersji pakietu)
3) planowane operacje
  - install
  - remove
  - purge
  - upgrade
  - downgrade
  - keep
  Przydatne gdy nie mamy internetu
'

: '
> Na potrzeby instalatorów wprowadzono `tasks`. Co to jest?
  Jak uruchomić `tasksel` tak, żeby oferował dokładnie te same opcje, co podczas instalacji systemu?
`tasks` to zestaw pakietów przeznaczony do zainstalowania konkretnej roli systemu.
Przykłady tasków:
  - SSH server
  - GNOME
  - XFCE
  - standard system utilities
Do zarządania służy `tasksel`.


'

: '
> Co to są pakiety wirtualne?
A virtual packages is a generic name that applies to any one of a group of packages, all of which
provide similar basic funcitionality. For example, both the `konqueror` and `firefox-esr` programs
are web browsers, and should therefore satisfy any dependency of a program that requires a web
browser on a systme, in order to work or to be useful. They are therefore both said to provide the
`virtual packagee` called www-browser.

Similarly, `exim4` and `sendmail` both provide the funcionality of a mail transport agent. They are
therefore said to provide the virtual packages `mail-transport-agent`. If either one is installed,
then any program depending on the installation of a `mail-transport-agent` will be satisfied by the 
presence of this virtual package.

Debian provides a mechanism so that, if more than one package which provide the same virtual package
is installed on the system, then system administrators can set one as the preferred package. The
relevant command is `update-alternatives`, and is described further in ...
'

: '
> Co to są metapakiety? Co to są `dummy packages`, `transitional packages`?
Jest to pakiet, który zwykle nie zawiera istotnych plików programów, tylko zależności do innych.
Instalują cały zestaw zależności.

Różnica pomiędzy pakietami wirtualnymi, a metapakietami jest taka, że pakiety wirtualne opisują
jedną funkcjonalności, która może być spełniona przez wiele pakietów, a metapakiety opisują
zestaw względnie niezależnych pakietów dostarczających różne funkcjonalności.
'
