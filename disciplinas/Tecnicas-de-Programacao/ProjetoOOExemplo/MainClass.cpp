#include <stdio.h>
#include <time.h>

#include "MainClass.h"

MainClass::MainClass ():
Simao(3, 10, 1976, "Jean Simao"),
Einstein(14, 3, 1879, "Albert Einstein"),
Newton(4, 1, 1643, "Isaac Newton"),

utfpr("UTFPR"),
dainf("DAINF"),
daeln("DAELN"),
dafis("DAFIS"),

princeton("Princenton"),
prin_fis("Fisica Princenton"),

cambridge("Cambridge"),
cam_mat("Matematica Cambridge")
{
	time_t timestamp;
	time(&timestamp);

	struct tm *now = localtime(&timestamp);

	dia = now->tm_mday;
	mes = now->tm_mon + 1;
	ano = now->tm_year + 1900;

	utfpr.afiliaDepartamento(&dainf);
	utfpr.afiliaDepartamento(&daeln);
	utfpr.afiliaDepartamento(&dafis);

	princeton.afiliaDepartamento(&prin_fis);

	cambridge.afiliaDepartamento(&cam_mat);

	Simao.afiliaUniversidade(&utfpr);
	Simao.afiliaDepartamento(&dainf);

	Einstein.afiliaUniversidade(&princeton);
	Einstein.afiliaDepartamento(&prin_fis);

	Newton.afiliaUniversidade(&cambridge);
	Newton.afiliaDepartamento(&cam_mat);
}

void MainClass::loop () {
	printf("\nHoje eh: %02d/%02d/%d\n\n", dia, mes, ano);

	utfpr.printDepartamentos();
	princeton.printDepartamentos();
	cambridge.printDepartamentos();

	Simao.calculaIdade(dia, mes, ano);
	Einstein.calculaIdade(dia, mes, ano);
	Newton.calculaIdade(dia, mes, ano);

	Simao.printIdade();
	Einstein.printIdade();
	Newton.printIdade();
	putchar('\n');

	Simao.printOndeTrabalha();
	Einstein.printOndeTrabalha();
	Newton.printOndeTrabalha();
	putchar('\n');
}
