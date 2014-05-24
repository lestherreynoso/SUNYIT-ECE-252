#include <iostream>
using namespace std 

int main(void)
{int a[20] = (15, 20, 14, 13, 17, 9, 10, 5, 18, 7, 19, 8, 1, 3, 4, 11, 2, 6, 12, 16);
int swap, i, j;
for (i=0; i<20; i++)
	{for j=1; j<21; j++)
		{ if (a[j]>a[i])
			{swap = a[i];
			 a[i]=a[j];
			 a[j]=swap;}
		     else j++;
		}
	}
	return;
}