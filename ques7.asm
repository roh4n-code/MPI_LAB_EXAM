.model small
.data
N db 05h
ARRAY db 53h, 32h, 45h, 10h, 23h
.code
.startup
LEA BX, N
MOV CL, [BX]
MOV CH, 00
SUB CX, 0001h   ; DEC CX
Out_L:
LEA BX, ARRAY
MOV DX, CX
IN_L:
MOV AL, [BX]
CMP AL, [BX+1]
JAE No_Swap     ; Changed from JNA to JAE for descending order
XCHG AL, [BX+1]
MOV [BX], AL
No_Swap:
INC BX
DEC DX
JNZ IN_L
LOOP Out_L
.exit
end