#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int generate_data(uint8_t list [], char *op);
void dump_data(char *fname, uint8_t list [], int);

int main(int argc, char *argv[])
{ 
    uint8_t list [1000];
    char str[3];
    int i;

    int value = generate_data(list, "OR");
    
    dump_data("logical_OR_data.txt", list, value);

    

    return 0;
}

void dump_data(char *fname, uint8_t list [], int list_length)
{
    int i;
    char hex[3];
    FILE *fp = fopen(fname, "w+");
    for (i = 0; i < list_length; ++i)
    {
        sprintf(hex, "%x", list[i]);
        fputs(hex, fp);
        fputs(" ", fp);
    }
    fclose(fp);
}


int generate_data(uint8_t list [], char *op)
{
    uint8_t A, B;
    int i, j;
    int array_index = 0;
    for (i = 0; i <= 255; i += 85)
    {
        for(j = 0; j <= 255; j += 85) 
        {
            A = i;
            B = j;
            list[array_index] = A;
            list[array_index + 1] = B;
            if (!strcmp(op, "OR"))
                list[array_index + 2] = A | B;
            else if (!strcmp(op, "AND"))
                list[array_index + 2] = A & B;
            else if (strcmp(op, "NAND"))
                list[array_index + 2] = ~(A & B);
            else if (strcmp(op, "NOR"))
                list[array_index + 2] = ~(A | B);
            else if (strcmp(op, "NOT"))
                list[array_index + 2] = ~A;
            else if (!strcmp(op, "XOR"))
                list[array_index + 2] = A ^ B;
            else if (!strcmp(op, "XNOR"))
                list[array_index + 2] = ~(A ^ B);

            ++array_index;
        }
    }
    return array_index;
}
