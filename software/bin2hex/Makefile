bin2hex.o: bin2hex.cc
	g++ -O3 $< -c
bin2hex: bin2hex.o
	g++ -O3 $< -o $@
clean:
	rm bin2hex.o

all: bin2hex