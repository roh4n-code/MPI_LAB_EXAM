
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model small
.data
NSUM db ?
msg db "Enter a number b/w 1 and 20 :$"


.code
.startup

MOV DX , offset msg 
MOV AH , 09H
INT 21H

MOV AH,01h
INT 21H

AND AL,0FH  

MOV CL,AL 
XOR CH,CH

MOV DL,00H 

HERE:
ADD DL,CL
LOOP HERE

MOV NSUM, DL;
.exit
END





