		PRESERVE8
Stack	EQU 0x00000100
		AREA STACK, NOINIT, READWRITE
StackMem SPACE Stack
		
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
		
__Vectors
		DCD StackMem
		DCD Reset_Handler

		AREA tempData, DATA, READONLY
Array DCD 1,2,3,55,5,6,7,8,9,10
Len EQU 10

		AREA |.text|, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
Reset_Handler_End

		ldr r0,= Array
		mov r1, #Len
		mov r2,#55
		bl Linear_Search_Start

stop	b stop

Linear_Search_Start
		export Linear_Search_Start
		mov r4,r0
		mov r3,#0
		mov r0,#0

loop
		add r3,r3,#1
		ldr r5,[r4]
		cmp r5,r2
		addeq r0,r0,r3
		moveq pc,lr
		add r4,r4,#4
		cmp r3,r1
		bne loop
		mov pc,lr
		
		end