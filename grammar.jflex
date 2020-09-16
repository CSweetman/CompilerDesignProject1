import java_cup.runtime.*;

%%

%cup
%line
%column
%unicode
%class Lexer

%{

Symbol newSym(int tokenID){
	return new Symbol(tokenId, yyline, yycolumn);
}


Symbol newSym(int tokenId, Object value){
	return new Symbol(tokenId, yyline, yycolumn, value);
}

%}

/*
*regular expressions, patterns
*/

//------
tab	= \\t
newline = \\n
slash	= \\
letter	= [A-Za-z]
digit	= [0-9]
id	= {letter}+
intlit	= {digit}+	//00003 is valid
comment = {slash}{slash}.*\n
whitespace = [ \n\t\r]
//------

%%

//Lex rules

var		{return newSym(sym.VAR, "var");}
";"		{return newSym(sym.SEMI, ";");}
"="		{return newSym(sym.EQ, "=");}
read	{return newSym(sym.READ, "read");}
print	{return newSym(sym.PRINT, "print");}
"*"		{return newSym(sym.MULT, "*");}
"/"		{return newSym(sym.DIV, "/");}
"+"		{return newSym(sym.PLUS, "+");}
"-"		{return newSym(sym.MINUS, "-");}
//intlit
{intlit}	{return newSym(sym.INTLIT, yytext());}
//id
{id} 	{return newSym(sym.ID, yytext());}
{whitespace} {/* whitespace */}
{comment} {/* comment body */}
. {System.out.println("Illegal character, " + yytext() + " line:" + yyline + " col" + yychar);}