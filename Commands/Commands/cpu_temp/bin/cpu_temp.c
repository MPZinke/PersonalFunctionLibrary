
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
	// yay branchless programming (5 more operations, but never have to clear look ahead)
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



int main()
{
	string file_paths[] =	{
								DEF_STR(TEMPERATURE_PATH, temp1_input),
								DEF_STR(TEMPERATURE_PATH, temp2_input),
								DEF_STR(TEMPERATURE_PATH, temp3_input),
								DEF_STR(TEMPERATURE_PATH, temp4_input)
							};

	// iterate files, get contents & print formatted contents
	for(int x = 0; x < sizeof(file_paths) / sizeof(string); x++)
	{
		char file_contents[CONTENTS_SIZE] = {0};
		if(!open_file_and_read_contents(file_contents, file_paths[x])) printf("Failed to open: %s\n", file_paths[x]);
		else 
		{
			format_contents(file_contents);
			printf("%s\n", file_contents);
		}
	}


	return 0;
}
