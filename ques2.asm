.model small
.data
Deg_Far db 0Ah       ; Fahrenheit input
Deg_Kel dw ?          ; To store Kelvin output

.code
.startup
  
LEA BX, Deg_Far
MOV AL,[BX]
SUB AL,20h

MOV BL,05h
MUL BL

MOV BL,09h
DIV BL

ADD AX, 111h

LEA BX, Deg_Kel
MOV [BX],AL

.exit
END