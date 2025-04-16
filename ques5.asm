.model small
.data
N db 07h
FIB_Out db 7 DUP<1>

.code
.startup
LEA BX, N
MOV CL, [BX]
MOV CH, 00h
LEA BX, FIB_Out
MOV [BX], 0h
MOV [BX+1], 1h
SUB CX, 02h

L1:
MOV AL, [BX]
ADD AL, [BX+1]
MOV [BX+2], AL
INC BX
LOOP L1

.exit
end
