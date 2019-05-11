#include <depthos/console.h>

int main(){
	int i;

	console_setcolor(BLACK, WHITE);
	cls();
	printf("Formated output test.\n");
	printf("\t%d\t%d\n\t%d\t%d\nNumber: '123456789'='%d'\nNumber: '-987654321'='%d'\nPercent symbol: '%%'='%%'\nText: \"example\"=\"%s\"\n", 1, -1, 3224, -3224, 123456789, -987654321, "example");
	printf("Color test.\n");
	printf("\tbackground color\ttext color\n");
	console_setcolor(BLACK, WHITE);
	printf("\t\tblack\t\twhite\t\n");
	console_setcolor(DARK_BLUE, YELLOW);
	printf("\t\tdark blue\tyellow\t\n");
	console_setcolor(DARK_GREEN, MAGNETA);
	printf("\t\tdark green\tmagneta\t\n");
	console_setcolor(DARK_CYAN, RED);
	printf("\t\tdark cyan\tred\t\n");
	console_setcolor(DARK_RED, CYAN);
	printf("\t\tdark red\tcyan\t\n");
	console_setcolor(DARK_MAGNETA, GREEN);
	printf("\t\tdark magneta\tgreen\t\n");
	console_setcolor(DARK_YELLOW, BLUE);
	printf("\t\tdark yellow\tblue\t\n");
	console_setcolor(GRAY, DARK_GRAY);
	printf("\t\tgray\t\tdark gray\n");
	printf("\n");
	i = 16;
	console_setcolor(BLACK, WHITE);
	printf("All color in row: [");
	do{
		i--;		
		console_setcolor(i, BLACK);
		printf(" ");
	}while(i);
	console_setcolor(BLACK, WHITE);
	printf("]");
	return 0;
}
