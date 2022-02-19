#define SCREENSIZE 2 * 80 * 25
void kmain(void) {
	unsigned int current_loc = 0;
	char *vidptr = (char*)0xb8000;
	void clearScreen(void) {
		unsigned int i = 0;
		while (i < SCREENSIZE) {
			vidptr[i++] = ' ';
			vidptr[i++] = 0x07;
		}
	}
	void print(const char *str) {
		unsigned int i = 0;
		while (str[i] != '\0') {
			vidptr[current_loc++] = str[i++];
			vidptr[current_loc++] = 0x07;
		}
	}
	void newline(void)
	{
		unsigned int line_size = 2 * 80;
		current_loc = current_loc + (line_size - current_loc % (line_size));
	}
	clearScreen();
	while(1){
		print("Small owlet wrote this os!");
		newline();
	}
}