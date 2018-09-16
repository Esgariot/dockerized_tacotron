# Sprawozdanie Robert Marciniak 149500
"Synteza mowy w oparciu o Tensorflow. Uruchomienie rezultatow w ~~srodowisku C++ lub C~~ kontenerze dockera"


## Research
- sprawdzenie forków projektu tacotron na GitHub:
    1. https://github.com/keithito/tacotron
    2. https://github.com/begeekmyfriend/tacotron
    3. https://github.com/Kyubyong/tacotron (używa głosu Nicka Offermana ale niestety problematyczne)
- wybór implementacji - wybrałem pozycję 1.


## Testowanie
1. checkout projektu 
2. instalacja wymaganych modułów pythona
3. instalacja tensorflow z bindingami pythona
4. uruchomienie przykładowego demo - `$ python demo_server.py --checkpoint <ścieżka checkpointu>`
5. otworzenie `localhost:9000` w przeglądarce, wpisanie zadanego tekstu i odsłuchanie stworzonego klipu

## Trening
Powolny proces trenowania - około 20 sekund na 1 krok daje estymatę około 10 godzin do otrzymania rezultatów przypominających mowę

# Kontener docker
Ze względu na niską wydajność i małą przenośność (sktypty użyte dosyć źle reagują na używanie ich gdziekolwiek poza `~/tacotron` i wymagają podawania flag katalogu za każdym razem kiedy ścieżka jest inna niż domyślna) skłoniła mnie do utworzenia z projektu obrazu dockera. Przygotowywane jest środowisko, ściągane dane treningowe i uruchamiany trening. Możliwe jest podpięcie katalogu z kontenera (`tacotron/logs-tacotron`) do systemu hosta dla zapamiętania postępu treningów. Po wytrenowaniu i zapamiętaniu punktu kontrolnego kontener można uruchomić z innym poleceniem - `pyhon demo_server.py --checkpoint logs-tacotron/<checkpoint>`, który uruchomi przykładowy serwer syntezujący zadany tekst. Kontener zadba o to, żeby adres `localhost:9000` odnosił się do adresu serwera w kontenerze.
Takim sposobem wydajność na moim laptopie pozostaje ta sama, ale przenośność drastycznie wzrasta.


## Polecenia
- budowanie obrazu -  `docker build -t tacotron --build-arg SPEECH_URI=<lokacja archiwum danych treningowych> <ścieżka do Dockerfile>`
- uruchamianie obrazu - `docker run [-v <punkt_montowania_host>:logs-tacotron] [-p 9000:9000] tacotron [<inne polecenie, np. python demo_server.py --checkpoint ...>]`
- monitorowanie postępu - `tensorboard --logdir <punkt_montowania_host>`



