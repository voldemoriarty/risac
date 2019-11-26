#include <iostream>
#include <iomanip>
#include <fstream>

int main(int argc, char **argv) {
	if (argc < 3) {
		std::cerr << "Too few arguments" << std::endl;
		return 1;
	}

	std::ifstream fin 	(argv[1]);
	std::ofstream fout 	(argv[2]);

	if (!fin.is_open()) {
		std::cerr << "Unable to open " << argv[1] << std::endl;
	}

	if (!fout.is_open()) {
		std::cerr << "Unable to open " << argv[2] << std::endl;
	}

	union {
		char 	bytes[4];
		int		word;
	} buffer;

	fout << "-- This file was generated using bin2hex utility\n"
					"-- bin file: "
			 << argv[1] << 
			 		"\nWIDTH=32;\n"
					"DEPTH=1024;\n"
					"ADDRESS_RADIX=HEX;\n"
					"DATA_RADIX=HEX;\n"
					"CONTENT BEGIN\n";

	const int total_size = 1024 - 1;

	int num_values = 0;
	while (fin.read(buffer.bytes, 4)) {
		fout << std::hex << num_values++ << " : " << buffer.word << ";\n";
	}

	if (num_values < total_size) {
		fout << '[' << std::hex << num_values << ".." << total_size << "] : 0;\n"; 
	}

	fout << "END;\n";

	fout.close();

	std::cout << std::dec << num_values << " words read, total " << num_values * 4 << " bytes" << std::endl;
}