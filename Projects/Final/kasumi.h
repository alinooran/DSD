
/*---------------------------------------------------------
* Kasumi.h
*---------------------------------------------------------*/
typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
/*----- a 64-bit structure to help with endian issues -----*/
typedef union {
	u32 b32[2];
	u16 b16[4];
	u8 b8[8];
} REGISTER64;
/*------- unions: used to remove "endian" issues ------------------------*/
typedef union {
	u32 b32;
	u16 b16[2];
	u8 b8[4];
} DWORD;
	typedef union {
	u16 b16;
	u8 b8[2];
} WORD;
/*------------- prototypes --------------------------------*/
void KeySchedule( u8 *key );
void Kasumi( u8 *data );
void KGcore( u8 ca, u8 cb, u32 cc, u8 cd, u8 *ck, u8 *co);
