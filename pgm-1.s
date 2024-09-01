		PRESERVE8
Stack	EQU 0x00000100
		AREA STACK, NOINIT, READWRITE, ALIGN=3
StackMem SPACE Stack
		
		
		AREA RESET, DATA, READONLY
		
		EXPORT __Vectors
		
__Vectors
		DCD StackMem
		DCD Reset_Handler
		
		AREA tempData, DATA, READONLY, ALIGN=3
			
ROMARRAY1 DCD 0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08
ROMARRAY2 DCD 0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16
		AREA |.data|, DATA, READWRITE, ALIGN=4
LEN EQU 0x08
ARRAY1	SPACE 32
ARRAY2	SPACE 32
		
		AREA |.text|,CODE, READONLY, ALIGN=3
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
Reset_Handler_End

		mov r0,#0x10
		ldr r1,= ROMARRAY2 + 28
		ldr r2,= ARRAY2+28

MEMCPY_LOOP
		ldr r3,[r1],#-4
		str r3,[r2],#-4
		subs r0,r0,#1
		bne MEMCPY_LOOP
		
		mov r0,#LEN
		ldr r1,=ARRAY1+28
		ldr r2,=ARRAY2+28

EXCH_LOOP
		ldr r3,[r1]
		ldr r4,[r2]
		str r4,[r1],#-4
		str r3,[r2],#-4
		subs r0,r0,#1
		bne EXCH_LOOP

stop	b stop
		
		end