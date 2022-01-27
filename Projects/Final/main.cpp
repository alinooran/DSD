#include <iostream>
#include <stdlib.h>
#include "kasumi.h"
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char** argv) {
	
	REGISTER64 pt; 	// PT
	u8 *kt; // pointer of 64-bit KT buffer
	u8 *ct;	// pointer of 64-bit CT buffer
	int i,n;

	kt = (u8 *)malloc(sizeof(u8)*16);
	ct = (u8 *)malloc(sizeof(u8)*8);
	
	//kt = 4F1271C53D8E98504F1271C53D8E9850
	//pt = AD6D521E5715819F
	kt[0] = (u8)0x4f;
	kt[1] = (u8)0x12;
	kt[2] = (u8)0x71;
	kt[3] = (u8)0xc5;
	kt[4] = (u8)0x3d;
	kt[5] = (u8)0x8e;
	kt[6] = (u8)0x98;
	kt[7] = (u8)0x50;
	kt[8] = (u8)0x4f;
	kt[9] = (u8)0x12;
	kt[10] = (u8)0x71;
	kt[11] = (u8)0xc5;
	kt[12] = (u8)0x3d;
	kt[13] = (u8)0x8e;
	kt[14] = (u8)0x98;
	kt[15] = (u8)0x50;

	pt.b8[0] = 0xad;
	pt.b8[1] = 0x6d;
	pt.b8[2] = 0x52;
	pt.b8[3] = 0x1e;
	pt.b8[4] = 0x57;
	pt.b8[5] = 0x15;
	pt.b8[6] = 0x81;
	pt.b8[7] = 0x9F;
	
	printf ("kt = ");
	for( unsigned i=0; i<16; i++ )
		printf ("%02x",kt[i]);
	printf ("\n");

	printf ("pt = %08x%08x\n",pt.b32[1], pt.b32[0]);
	
	KeySchedule( kt );
	
	
	Kasumi( pt.b8 ); /* First encryption to create modifier */
	for( i=0; i<8; ++i )
	   *(ct+i) = pt.b8[i];	

	printf("ct = ");	
	for( unsigned i=0; i<8; i++ )
		printf("%02x", *(ct+i) );
	printf ("\n");
		
	return 0;
}
