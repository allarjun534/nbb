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
			
ROMARRAY DCD 0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08
	
		AREA |.data|, DATA, READWRITE, ALIGN=3
LEN EQU 0x08
NOOVERLAP	EQU 32
ARRAY	SPACE 32
		
		AREA |.text|,CODE, READONLY, ALIGN=4
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
Reset_Handler_End

		mov r0,#0x08
		ldr r1,= ROMARRAY + 28
		ldr r2,= ARRAY + 28
memcpy_loop
		ldr r3,[r1],#-4
		str r3,[r2],#-4
		subs r0,r0,#1
		bne memcpy_loop
		
		mov r0,#LEN
		ldr r1,= ARRAY + 28
		ldr r2,= ARRAY + 28 + NOOVERLAP

transfer_loop
		ldr r3,[r1],#-4
		str r3,[r2],#-4
		subs r0,r0,#1
		bne transfer_loop

stop	b stop
		end