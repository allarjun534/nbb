		PRESERVE8
Stack	EQU 0x00000100
		AREA STACK, NOINIT, READWRITE
StackMem SPACE Stack
		
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
		
__Vectors
		DCD StackMem
		DCD Reset_Handler			
	
		AREA |.text|, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
Reset_Handler_End

		ldr r1,= 0x20000000
		ldr r2,[r1]
		ldr r3,[r1,#4]
		ldr r4,[r1,#8]
		
		cmp r2,#1
		bne chk_sub
		adds r7,r3,r4
		b last
		
chk_sub	cmp r2,#2
		bne chk_mul
		subs r7,r3,r4
		b last
		
chk_mul	cmp r2,#3
		bne chk_div
		umull r7,r8,r3,r4
		b last
		
chk_div	cmp r2,#4
		bne last
		udiv r7,r3,r4

last	str r7,[r1,#20]
		str r8,[r1,#24]

stop	b stop
		end