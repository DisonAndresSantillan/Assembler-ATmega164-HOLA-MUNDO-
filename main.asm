;
; 1_HOLA_MUNDO_ATmega164p.asm
;
; Created: 22/5/2020 16:30:12
; Author : disonandres
;
; Replace with your application code



.def tempo=r16
.def aux=r17
.def cont=r18
.dseg 
.org 0x100
dig: .byte 4
.cseg
.org 0x00
ldi tempo, 0b11111111
out ddra,tempo
com tempo
out porta,tempo
ldi tempo,0b00000000
out ddrb,tempo
out ddrd,tempo
com tempo
out portb,tempo
out portd,tempo
ldi tempo,0b00001111
out ddrc,tempo
ldi tempo,0b00001111
out portc,tempo
in tempo, MCUCR
andi tempo,0b11101111
out MCUCR,tempo
ldi tempo, high(ramend)
out sph,tempo
ldi tempo,low(ramend)
out spl,tempo

ldi zh,high(tabla_hola<<1)
ldi zl,low(tabla_hola<<1)
ldi xh,high(dig)
ldi xl,low(dig)
ldi cont,4
pasar:
lpm tempo,z+
st x+,tempo
dec cont 
brne pasar 
lazo:
ldi cont,4
 ldi xh,high(dig)
 ldi xl,low(dig)
sec
 ldi aux,0b00000001
 com aux
 lazoa:
 out portc,aux
 ld tempo,x+
 com tempo
 andi tempo,0b01111111
 out porta,tempo
 rcall retardo
 ldi tempo,0xff
 out portc,tempo
 sec
 rol aux
 dec cont
 brne lazoa
rjmp lazo

retardo:
push r16
in r16,sreg
push r16
ldi r16, 255
lazodec:
dec r16
brne lazodec
pop r16
out sreg,r16
pop r16
ret

/*
tabla_hola: 
.db 0b01110111, 0b00110111 ;A,N
.db 0b00111111, 0b01101110 ;D,Y
*/


tabla_hola:
.db 0b01110110,0b00111111 ;h,o
.db 0b00111000,0b01110111 ;l,a






/*
tabla_hola: ; here if you wanna use with numbers display common anode
.db 0b00111111,0b00000110 ;0,1
       .db 0b01011011,0b01001111 ;2,3
       .db 0b01100110,0b01101101 ;4,5
       .db 0b01111101,0b00000111 ;6,7
       .db 0b01111111,0b01101111 ;8,9
	   */
