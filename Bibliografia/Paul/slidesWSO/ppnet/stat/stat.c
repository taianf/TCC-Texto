#include <stdio.h>
#include <string.h>
#include <stddef.h>
#include <errno.h>
#include <stdlib.h>
#include <math.h>


int stat(char * file);
FILE *openInput(char *fileName);
int closeFile(FILE *f);


int main (int argc, char *argv[])
{
	char file_name[20];
	
	if ( argc < 2 ) {
		printf("argc: %d\n", argc);
		printf("needs one argument\n");
		return 0;
	}

//	fprintf(stderr, "%s\n", argv[1]);
	strcpy(file_name, argv[1]);

       	stat(file_name);

	return 0;
}

int stat(char * file)
{
	FILE *stream = NULL;

	float t, t1, t2, t3, t4, min1, max1,min2, max2;
	long double tot1, tot2, q1, q2, r1, r2;
 
	long int n = 0;

	fprintf(stderr, "%s\n%", file); 

	if ( ( stream = openInput(file) ) == NULL )
		return 0;

	tot1 = tot2 = q1 = q2 = max1 = max2 = 0;
	min1 = min2 = 100000. ;
	while ( n < 14000 && fscanf(stream, "%f %f %f %f %f\n",  &t, &t1, &t2, &t3, &t4) != EOF ) {
//		printf("%8.2f %8.2f %8.2f %8.2f %8.2f \n",  t, t1, t2, t3, t4);

		if ( min1 > t1 ) min1 = t1;
		if ( min2 > t2 ) min2 = t2;
		if ( max1 < t1 ) max1 = t1;
		if ( max2 < t2 ) max2 = t2;

		n++;
		tot1 += t1;
		tot2 += t2;

		q1 += t1*t1; 
		q2 += t2*t2; 
	}

	tot1 = tot1 / n;
	tot2 = tot2 / n;

	r1 = sqrt((q1/n - tot1*tot1));
	r2 = sqrt((q2/n - tot2*tot2));

	printf("n: %ld \n", n);
	printf("VM: %7.1f, DP: %7.1f,  Min: %7.1f, Max: %7.1f \n", (float)tot1, (float)r1, min1, max1);
	printf("VM: %7.1f, DP: %7.1f,  Min: %7.1f, Max: %7.1f\n", (float)tot2, (float)r2, min2, max2);
		
	return 0;
}


FILE *openInput(char *fileName)
{
	FILE *f = NULL;
	f = fopen(fileName, "r");
	
	if (f == NULL)
		fprintf(stderr, "Open of %s for input failed\n", fileName);

	return f;
}

int closeFile(FILE *f)
{
	int s = 0;
	if (f == NULL) return 0;
	//errno = 0;
	s = fclose(f);
	if (s == EOF) perror("Close failed");
	return s;	
}


/* int test3() */
/* { */
/* 	long nc = 0; */
/* 	printf("%d", EOF); */
/* 	while( getchar()!= EOF ) */
/* 	  ++nc; */

/* #ifdef DEBUG */
/* 	printf("The debug version"); */
/* #endif */

/* 	printf("%d\n", nc); */
/* 	return 0; */
/* } */

/* int test1() */
/* { */
/* 	static char str[8] = {'1','2','3','4','5','6','7','8'}; */
/* 	int i; */

/* 	for (i =  0; i < 8 ; i++) { */
/* 		printf("%c", str[i]); */
/* 	} */
/* 	return 0; */
/* } */

