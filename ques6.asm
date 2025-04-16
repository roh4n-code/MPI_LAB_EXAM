.model small

.data
N db 05h                        ; Number of elements in the array (5)
ARRAY db 53h, 45h, 32h, 23h, 10h ; The array to be sorted

.code
.startup                        ; Program starts here

LEA BX, N                       ; Load address of N into BX
MOV CL, [BX]                    ; Move value of N into CL (CL = 5)
MOV CH, 00                      ; Clear CH ? CX = 0005h

SUB CX, 0001h                   ; CX = N - 1 ? Number of outer loop passes = N - 1

; ---------- OUTER LOOP ----------
Out_L:
LEA BX, ARRAY                   ; Reset BX to point to start of ARRAY
MOV DX, CX                      ; DX = CX ? number of inner loop comparisons

; ---------- INNER LOOP ----------
IN_L:
MOV AL, [BX]                    ; Load current element AL = ARRAY[i]
CMP AL, [BX+1]                  ; Compare with next element ? AL ? ARRAY[i+1]
JNA No_Swap                     ; If AL <= [BX+1], no swap needed, jump

XCHG AL, [BX+1]                 ; Swap AL and [BX+1] ? now AL holds [BX+1]
MOV [BX], AL                   ; Move AL into [BX] ? Swap complete

No_Swap:
INC BX                          ; Move BX to next array index
DEC DX                          ; One less comparison to make
JNZ IN_L                        ; Repeat inner loop until DX = 0

LOOP Out_L                      ; Outer loop ? decrement CX, repeat until CX = 0

.exit                           ; Exit program
end