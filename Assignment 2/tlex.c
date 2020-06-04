#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

#define id 1
#define head 2
#define kw 3
#define ro 4
#define ao 5
#define do 6
#define ic 7
#define par 8
#define cb 9
#define sc 10
#define com 11


int isKeyword(char buffer[])
{
        char ks[32][20] = {"auto","break","case","char","const","continue","default",
                                                        "do","double","else","enum","extern","float","for","goto",
                                                        "if","int","long","register","return","short","signed",
                                                        "sizeof","static","struct","switch","typedef","union",
                                                        "unsigned","void","volatile","while"};
        int i, f = 0;

        for(i = 0; i < 32; i++)
        {
                if(strcmp(ks[i], buffer) == 0)
                {
                        f = 1;
                        break;
                }
        }

        return f;
}

int isHeader(char buffer[])
{
        char ks[4][30] = {"#include<stdio.h>","#include<stdlib.h>","#include<string.h>","#include<unistd.h>"};
        int i, f = 0;

        for(i = 0; i < 32; i++)
        {
                if(strcmp(ks[i], buffer) == 0)
                {
                        f = 1;
                        break;
                }
        }

        return f;
}

int yylex(FILE *fp)
{
    int state = 0;
    int j = 0;
    char ch;
    char buff[20];
    while(1)
    {
        switch(state)
        {
            case 0:
                ch = fgetc(fp);
                
                if(ch == EOF) 
                    return 1;
                if(isdigit(ch))
                {
                    printf("%c",ch );
                    state = 12;   
                }
                else if(isalnum(ch) || ch == '#')
                {
                    printf("%c",ch );
                    buff[j++] = ch;
                    state = 1;
                }
                else if(ch == '>')
                {
                    printf("%c",ch );
                    state = 3;
                }
                else if(ch == '=') 
                {
                    printf("%c ",ch );
                    state = 4;
                }
                else if(ch == '<')
                {
                    printf("%c",ch );
                    state = 5;
                }
                else if(ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '%')
                {
                    printf("%c",ch );
                    state = 11;
                }
                else if(ch == '(' || ch == ')')
                {
                    printf("%c",ch );
                    state = 17;
                }
                else if(ch == '{' || ch == '}')
                {
                    printf("%c",ch );
                    state = 18;
                }
                else if(ch == ';')
                {
                    printf("%c",ch );
                    state = 19;
                }
                else if(ch == ',')
                {
                    printf("%c",ch );
                    state = 20;
                }
                else
                {
                    state = 0;
                }
                break;

            case 1:
                ch = fgetc(fp);
                
                if(isalnum(ch) || ch == '.' || ch == '<' || ch == '>')
                {
                    printf("%c",ch );
                    buff[j++] = ch;
                    state = 1;
                }
                else 
                {
                    if(ch != '\n')
                        printf("%c",ch );
                    else
                        printf(" ");
                    state = 2;
                }
                break;

            case 2: 
                buff[j] = '\0';
                if(isKeyword(buff) == 1)
                    printf("%d\n",kw);
                else if(isHeader(buff) == 1)
                    printf("%d\n",head);
                else
                    printf("%d\n",id);
                j = 0;
                
                // printf("%s\n",buff );
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 3:
                ch = fgetc(fp);
                if(ch != '\n')
                    printf("%c",ch );
                else 
                    printf(" ");
                if(ch == '=')
                    state = 6;
                else
                    state = 7;
                break;

            case 4:
                printf("%d\n",ro);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 5:
                ch = fgetc(fp);
                if(ch != '\n')
                    printf("%c",ch );
                else 
                    printf(" ");
                if(ch == '=')
                    state = 8;
                else if(ch == '>')
                    state = 9;
                else
                    state = 10;
                break;

            case 6:
                printf("%d\n",ro);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 7:
                printf("%d\n",ro);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 8:
                printf("%d\n",ro);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 9:
                printf("%d\n",ro);
                if(ch == EOF) 
                    return 1;
                return 2;

            case 10:
                printf("%d\n",ro);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 11:
                printf(" %d\n",ao);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 12:
                ch = fgetc(fp);
                if(isdigit(ch))
                {
                    printf("%c",ch );
                    state = 12;
                }
                else if(ch == '.')
                {
                    printf("%c",ch );
                    state = 13;
                }
                else
                {
                    printf("%c",ch );
                    state = 16;
                }
                break;

            case 13:
                ch = fgetc(fp);
                if(isdigit(ch))
                {
                    printf("%c",ch );
                    state = 14;
                }
                else 
                    state = 15;
                break;

            case 14:
                ch = fgetc(fp);
                if(isdigit(ch))
                {
                    printf("%c",ch );
                    state = 14;
                }
                else 
                    state = 15;
                break;

            case 15:
                printf(" %d\n",do);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 16:
                printf("%d\n",ic);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 17:
                printf(" %d\n",par);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 18:
                printf(" %d\n",cb);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 19:
                printf(" %d\n",sc);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;

            case 20:
                printf(" %d\n",com);
                if(ch == EOF) 
                    return 1;
                return 2;
                break;
        }
    }
}

int main()
{
        char ch, buffer[15], operators[] = "+-*/%=&!|<>(){}";
        FILE *fp;
        int i,j=0,k;

        fp = fopen("tabc.c","r");

        while(1)
        {
               k = yylex(fp);
               if(k==1)
                    break;
        }

        fclose(fp);

        return 0;
}