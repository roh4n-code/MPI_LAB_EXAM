.model small
.data
StrLen dw 8
STR db 'BITSSTIB$'
NotE db 'String is NOT a Palindrome$'
Equal db 'String is a Palindrome$'
REVSTR db 8 dup(?)
Newline db 0AH,0DH,'$'
.code
.startup

MOV AX,DS
MOV ES,AX

LEA SI,STR
LEA DI,REVSTR
ADD SI,StrLen
DEC SI

MOV CX,StrLen

L1:
    MOV AL,[SI]
    MOV [DI],AL
    DEC SI
    INC DI
LOOP L1

LEA SI,STR
LEA DI,STR
ADD SI,StrLen
DEC SI

MOV CX,StrLen
L2:
    MOV AH,[SI]
    MOV AL,[DI]
    CMP AH,AL
    JNE NotEqual
    INC DI
    DEC SI
LOOP L2
         
MOV DX, offset Equal
MOV AH,09H
INT 21H
MOV DX, offset Newline
MOV AH,09H
INT 21H              
MOV DX, offset STR
MOV AH,09H
INT 21H
MOV DX, offset Newline
MOV AH,09H
INT 21H              
MOV DX, offset REVSTR
MOV AH,09H
INT 21H
.exit

NotEqual:
MOV DX, offset NotE
MOV AH,09H
INT 21H
MOV DX, offset Newline
MOV AH,09H
INT 21H              
MOV DX, offset STR
MOV AH,09H
INT 21H
MOV DX, offset Newline
MOV AH,09H
INT 21H              
MOV DX, offset REVSTR
MOV AH,09H
INT 21H

.exit
end