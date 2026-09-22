#include <stdio.h>
#include <stdlib.h>

#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main()
{
    printf("--- Testing String Functions ---\n");

    // Test mystrlen()
    const char *text = "Hello";
    printf("Length of \"%s\" = %d\n", text, mystrlen(text));

    // Test mystrcpy()
    char copied[100];
    mystrcpy(copied, "Operating Systems");
    printf("After mystrcpy: %s\n", copied);

    // Test mystrncpy()
    char copied_n[100];
    mystrncpy(copied_n, "Hello World", 5);
    printf("After mystrncpy: %s\n", copied_n);

    // Test mystrcat()
    char combined[100] = "Hello ";
    mystrcat(combined, "Linux");
    printf("After mystrcat: %s\n", combined);


    printf("\n--- Testing File Functions ---\n");

    // Create a temporary test file
    FILE *file = fopen("sample.txt", "w+");

    if (file == NULL)
    {
        printf("Error: Could not create sample.txt\n");
        return 1;
    }

    fprintf(file, "Hello Linux\n");
    fprintf(file, "This is an OS project\n");
    fprintf(file, "Linux is powerful\n");

    // Move file pointer back to beginning
    rewind(file);

    // Test wordCount()
    int lines, words, chars;

    if (wordCount(file, &lines, &words, &chars) == 0)
    {
        printf("Lines: %d\n", lines);
        printf("Words: %d\n", words);
        printf("Characters: %d\n", chars);
    }
    else
    {
        printf("wordCount failed\n");
    }

    // Move file pointer back again
    rewind(file);

    // Test mygrep()
    char **matches = NULL;

    int count = mygrep(file, "Linux", &matches);

    if (count >= 0)
    {
        printf("Lines containing \"Linux\": %d\n", count);

        for (int i = 0; i < count; i++)
        {
            printf("%s", matches[i]);
            free(matches[i]);
        }

        free(matches);
    }
    else
    {
        printf("mygrep failed\n");
    }

    fclose(file);

    // Remove temporary test file
    remove("sample.txt");

    return 0;
}

