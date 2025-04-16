.model small
.data
Deg_Cent db 0Ah
Deg_Far db ?

.code
.startup
LEA BX, Deg_Cent
MOV AL, [BX]
MOV BL, 09h
MUL BL
MOV BL, 05h
DIV BL
ADD AL, 20h
LEA BX, Deg_Far
MOV [BX], AL

.exit
end
