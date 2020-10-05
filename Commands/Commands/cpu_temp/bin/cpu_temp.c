
/********************************************************************************************************************************
*
*	created by: MPZinke
*	on 2020.10.04
*
*	DESCRIPTION:	Find the temperatures of the CPU by looking into /sys/class files.  
*	BUGS:		-Has the posibility to not do the job if process is stopped in the middle of the assembly part.
*				 This is very unlikely though.	
*	FUTURE:
*
********************************************************************************************************************************/


#include<stdbool.h>
#include<stdio.h>
#include<stdlib.h>


// ENVIRONMENT
#define CONTENTS_SIZE 8  // 100(.)000\0
#define TEMPERATURE_PATH /sys/class/hwmon/hwmon1/

// UTILITY
typedef char* string;

#define DEF(x) #x
#define DEF_STR(x,y) DEF(x) #y


// Create a string of format [1]DD.D
// Takes string point to address space to be worked on.
// Shift a number over one spot, add a decimal, terminate the string.
void format_contents(string output)
{
	// yay branchless programming (1 more operation, but never have to clear look ahead)
	// char* index = output + 3 + (output[5] != 0);
	// *index = *(index-1);  // shift decimal over one
	// *(index-1) = '.';
	// *(index+1) = 0;

	// assembly version of above (skipping moving values out of registers)
	__asm__
	(
		"MOVZBL 6(%RDI), %EAX;  # move 7th character to EAX\n"
		"\tMOVL $1, %EBX;  # hold value 1 for if NE CMP\n"
		"\tCMP $0, %EAX;  # check if EAX is 0\n"
		"\tCMOVNE %EBX, %EAX;  # if not 0, move 1 into EAX\n"
		"\tADD $3, %EAX;  # add offset of 3 with additonal offset (0 or 1)\n"
		"\tADDQ %RAX, %RDI;  # add offset to address pointer\n"
		"\tMOVZBL -1(%RDI), %EAX;  # retrieve decimal number\n"
		"\tMOVL %EAX, (%RDI)  # store decimal number over one spot\n"
		"\tMOVB $46, -1(%RDI);  # add period character\n"
		"\tMOVB $0, 1(%RDI);  # null terminate string\n"
	);
}


// Open a file and read its contents (up to CONTENTS_SIZE) if successfully opened.
// Take address for file content string, address for file path.
// Read up to CONTENTS_SIZE from file into file_contents address.
// Returns whether file successfully opened.
bool open_file_and_read_contents(string file_contents, string file_path)
{
	FILE* file = fopen(file_path, "r");
	if(!file) return false;  // failed to open file: do not proceed

	fgets(file_contents, CONTENTS_SIZE, file);
	fclose(file);
	return true;
}


// Calculate index of text array for colors based on temperature string.
// Take address for temperature string.
// Get offset using boolean alegbra.
// Return offset.
int index_for_temperature_color(string temperature)
{
	// get numeric offset, keep index with in bounds, adjust index for if 3 digit number (100 <= )
	// return (((*temperature) - 53) * ((*temperature) > 53)) + (5 * (temperature[3] == '.'));  // branchless

	// assembly version of above (skipping moving values out of registers)
	__asm__
	(
		"MOVZBL (%RDI), %EAX;  #  get 1st character for evaluation\n"
		"\tMOV %RAX, %RBX;  # play leapfrog with values"
		"\tSUB $53, %RBX;  # \n"
		"\tMOV $0, %RCX;  # hold value 5 for if LE CMP\n"
		"\tCMP $53, %RAX;  # \n"
		"\tCMOVLE %RCX, %RBX;  # index = 0 if character is <= '5'\n"
		"\tMOVZB 3(%RDI), %RAX;  # get 4th character for evaluation\n"
		"\tMOV $5, %RCX;  # hold value 5 for if E CMP\n"
		"\tCMP $46, %RAX;  # check if value is decimal point\n"
		"\tCMOVE %RCX, %RBX;  # 3 digit number: add offset of 5\n"
		"\tMOV %RBX, %RAX;  # return value\n"
	);
}


// Read characters of temperature string & determine color to set in console.
// Takes address for temperature string.
// Evaluates first character and location of decimal point.
// Prints color prefix to screen.
void set_color_for_temperature(string temperature)
{
	string colors[] =	{
							"\e[0;35m",
							"\e[0;34m",
							"\e[0;32m",
							"\e[0;33m",
							"\e[0;31m",
							"\e[0;31m"
						};
	printf(colors[index_for_temperature_color(temperature)]);
}



int main()
{
	string file_paths[] =	{
								DEF_STR(TEMPERATURE_PATH, temp1_input),
								DEF_STR(TEMPERATURE_PATH, temp2_input),
								DEF_STR(TEMPERATURE_PATH, temp3_input),
								DEF_STR(TEMPERATURE_PATH, temp4_input)
							};

	string names[] =	{
							"Tctl",
							"Tdie",
							"Tccd1",
							"Tccd2"
						};

	// iterate files, get contents & print formatted contents
	for(int x = 0; x < sizeof(file_paths) / sizeof(string); x++)
	{
		char file_contents[CONTENTS_SIZE] = {0};
		if(!open_file_and_read_contents(file_contents, file_paths[x])) printf("Failed to open: %s\n", file_paths[x]);
		else 
		{
			format_contents(file_contents);
			printf("\e[0m%s: ", names[x]);
			set_color_for_temperature(file_contents);
			printf("%s\n", file_contents);
		}
	}


	return 0;
}
