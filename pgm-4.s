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
		ldr r5,[r1,#12]
		ldr r6,[r1,#16]
		
		cmp r2,#1
		bne chk_sub
		adds r7,r3,r5
		adc r8,r4,r6
		b last
		
chk_sub	cmp r2,#2
		bne chk_mul
		subs r7,r3,r5
		sbc r8,r4,r6
		b last
		
chk_mul	cmp r2,#3
		bne default
		umull r7,r8,r3,r5
		umull r9,r10,r4,r6
		umull r6,r3,r4,r6
		adds r8,r8,r9
		adcs r9,r10,r6
		adc r10,r3,#0
		umull r5,r3,r4,r5
		adds r8,r8,r5
		adcs r9,r9,r3
		adc r10,r10,#0
		b last
		
default	mov r7,#0
		mov r8,#0
		mov r9,#0
		mov r10,#0

last	str r7,[r1,#20]
		str r8,[r1,#24]
		str r9,[r1,#28]
		str r10,[r1,#32]

stop	b stop
		end