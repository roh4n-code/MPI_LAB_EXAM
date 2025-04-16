.model small

.data
StrLen dw 4                   ; Length of the string to copy
STR DB "BITS$"                ; Source string, null-terminated with '$' for DOS print
STRCPY DB 4 DUP(0)            ; Destination buffer, initialized with 4 zero bytes
NextLine DB 0Ah, 0Dh, "$"     ; New line and carriage return, followed by '$' for print

.code
.startup

MOV AX, DS                    ; Copy current data segment into AX
MOV ES, AX                    ; ES = DS, so both source and destination segments are the same
MOV CX, StrLen                ; CX = number of characters to copy

LEA SI, STR                   ; Load effective address of source string into SI
LEA DI, STRCPY                ; Load effective address of destination buffer into DI

CLD                           ; Clear direction flag (process strings left to right)

L1:
LODSB                         ; Load byte from DS:SI into AL, and increment SI
STOSB                         ; Store byte from AL into ES:DI, and increment DI
LOOP L1                       ; Decrement CX, repeat if CX != 0

; Display the original string
MOV DX, offset STR
MOV AH, 09h
INT 21h

; Print a newline
MOV DX, offset NextLine
MOV AH, 09h
INT 21h

; Display the copied string
MOV DX, offset STRCPY
MOV AH, 09h
INT 21h

.EXIT
ENDD