Delay     EQU 4064
GPIOSET   EQU 0x400F6218
GPIOCLR   EQU 0x400F6298
GPIO6DIR  EQU 0x400F6018
GPIO6MASK EQU 0x400F6098
SCU_PC_12 EQU 0x40086630

	AREA RESET, DATA, READONLY
	dcd Reset_Handler;
	dcd Reset_Handler;
	
	AREA beg, CODE, READONLY
	ENTRY
Reset_Handler PROC
;Initialise GPIOs
	ldr r0,=SCU_PC_12;
	mov r1, 0x24;
	str r1, [r0];	

;Set output direction for GPIO6
	ldr r0,=GPIO6DIR;
	mov r1, 0x800;
	str r1, [r0];
	
;Set mask for GPIO
	ldr r0,=GPIO6MASK;
	mov r1, #0;
	str r1, [r0];
	
;Main loop
lp
	ldr r0,=GPIOSET;
	ldr r1, [r0];
	subs r1, 0x800;
	beq led_off;
;Turn the LED on
	mov r1, 0x800;
	str r1, [r0];
	
	b delay;
;Turn the LED off
led_off
	ldr r0,=GPIOCLR;
	mov r1, 0x800;
	str r1, [r0];

delay
;Make delay
	mov r3, #Delay;

continue2
	mov r0, #Delay;
continue1
	subs r0, r0, 0x1;
	bne continue1;
	
	subs r3, r3, 0x1;
	bne continue2;
	
	b lp;
	
	ENDP
	
	END 