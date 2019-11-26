bin2hex.o: bin2hex.cc
	g++ -g $< -c
bin2hex: bin2hex.o
	g++ -g $< -o $@
clean:
	rm bin2hex.o

all: bin2hex