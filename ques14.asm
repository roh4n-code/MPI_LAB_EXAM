.model small             ; Define memory model as 'small' (code and data in separate segments, each <64KB)
.data                    ; Start of data segment

StrLen dw 4              ; Define the length of the string (4 characters)
STR DB "BITS$"           ; Original string (null-terminated with '$' for INT 21h, AH=09h)
REVSTR DB 4 DUP(0)       ; Space to store the reversed string (4 bytes initialized to 0)
NextLine DB 0Ah, 0Dh, "$"; New line (carriage return + line feed) with '$' terminator

.code                    ; Start of code segment
.startup                 ; Setup code segment and jump to main code

MOV AX, DS               ; Copy current data segment value
MOV ES, AX               ; Set ES = DS (Extra Segment = Data Segment)
MOV CX, StrLen           ; CX = length of string (used as counter)

LEA SI, STR              ; Load address of original string into SI (source index)
LEA DI, REVSTR           ; Load address of reversed string into DI (destination index)

ADD DI, CX               ; Point DI to the end of REVSTR
DEC DI                   ; Move DI one position back (to last valid position)

L1:                      ; Label for loop to reverse string
CLD                      ; Clear direction flag (increment SI after LODSB)
LODSB                    ; Load byte at DS:SI into AL, increment SI
STD                      ; Set direction flag (DI will decrement after STOSB)
STOSB                    ; Store AL into ES:DI and decrement DI
LOOP L1                  ; Decrement CX and repeat loop if CX != 0

; Print original string
MOV DX, offset STR       ; Load address of STR into DX
MOV AH, 09h              ; Function 09h of INT 21h: display string until '$'
INT 21h                  ; DOS interrupt

; Print newline
MOV DX, offset NextLine  ; Load address of newline string
MOV AH, 09h              ; Display newline
INT 21h

; Print reversed string
MOV DX, offset REVSTR    ; Load address of reversed string
MOV AH, 09h              ; Display reversed string
INT 21h

END                      ; End of program