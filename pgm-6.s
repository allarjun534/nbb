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
Array DCD 1,2,3,4,5,6,7,8,9,10
;Len EQU 10

		AREA |.text|, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
Reset_Handler_End

		ldr r0,=Array
		mov r1,#0
		mov r2,#9
		mov r3,#0x12
		bl Binary_Search_Start

foreverloop	b foreverloop

Binary_Search_Start
		mov r4,r0
		mov r0,#0
		
Binary_Search_Loop
		add r5,r1,r2
		lsr r5,r5,#1
		lsl r7,r5,#2
		ldr r6,[r4,r7]
		cmp r3,r6
		addeq r0,r0,r5
		addeq r0,r0,#1
		moveq pc,lr
		sublt r5,r5,#1
		movlt r2,r5
		addgt r5,r5,#1
		movgt r1,r5
		cmp r1,r2
		moveq pc,r8
		b Binary_Search_Loop
		end