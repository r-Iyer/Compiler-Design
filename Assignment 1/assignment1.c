#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include<stdlib.h>
#define KEYWORD 1
#define INTEGERCONSTANT 2
#define IDENTIFIER 3
#define PARENTHESIS 4
#define ARGUMENT 5
#define HEADERFILE 6
#define OPERATOR 7
void keyw(char *p);
int i=0,id=0,kw=0,num=0,op=0;
char keys[32][10]={"auto","break","case","char","const","continue","default",
"do","double","else","enum","extern","float","for","goto",
"if","int","long","register","return","short","signed",
"sizeof","static","struct","switch","typedef","union",
"unsigned","void","volatile","while"};
void main()
{
char ch,str[25],seps[15]=" \t\n,;(){}[]#\"<>",oper[]="!%^&*-+=~|.<>/?";
int j;
FILE *f1;

f1 = fopen("example.c","r");

while((ch=fgetc(f1))!=EOF)
{
for(j=0;j<=14;j++)
{
if(ch==oper[j])
{
printf("%c is an Operator i.e %d\n",ch,OPERATOR);
op++;
str[i]='\0';
keyw(str);
}
}
for(j=0;j<=14;j++)
{
if(i==-1)
break;
if(ch==seps[j])
{
if(ch=='#')
{
while(ch!='>')
{
printf("%c",ch);
ch=fgetc(f1);
}
printf("%c is a Header File i.e %d\n",ch,HEADERFILE);
i=-1;
break;
}
else if(ch == seps[5]||ch == seps[6]||ch == seps[7]||ch == seps[8])
{
printf("%c is a Paranthesis i.e %d\n",ch,PARENTHESIS);
}
if(ch=='"')
{
do
{
ch=fgetc(f1);
printf("%c",ch);
}while(ch!='"');
printf("\b is an Argument i.e %d\n",ARGUMENT);
i=-1;
break;
}
str[i]='\0';
keyw(str);
}
}
if(i!=-1)
{
str[i]=ch;
i++;
}
else
i=0;
}
}






void keyw(char *p)
{
int k,flag=0;
for(k=0;k<=31;k++)
{
if(strcmp(keys[k],p)==0)
{
printf("%s is a Keyword i.e%d\n",p,KEYWORD);
kw++;
flag=1;
break;
}
}
if(flag==0)
{
if(isdigit(p[0]))
{
printf("%s is an IntegerConstant i.e %d\n",p,INTEGERCONSTANT);
num++;
}
else
{
//if(p[0]!=13&&p[0]!=10)
if(p[0]!='\0')
{
printf("%s is an Identifier i.e %d\n",p, IDENTIFIER);
id++;
}
}
}
i=-1;
}
