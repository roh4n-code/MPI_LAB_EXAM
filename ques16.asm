.model small             ; Use the 'small' memory model (separate code and data, each < 64KB)

.data                    ; Begin data segment
strlen dw 5             ; Define the length of the string (5 characters)
NEXTLINE db 0Ah, 0Dh, "$"; Newline characters with DOS string terminator '$'
STR db "Hello$"          ; Original string to be reversed (terminated by '$')

.code                    ; Begin code segment
.startup                ; Macro to initialize code and data segment registers

MOV CX, strlen          ; CX = length of string (used for looping)

LEA SI, STR             ; Load address of STR into SI (points to beginning of string)
LEA DI, STR             ; Load address of STR into DI (will be modified to point to end)

ADD DI, CX              ; Move DI to point just past the last character
DEC DI                  ; Now DI points to the last character of the string

SHR CL, 1               ; Divide CL by 2 (only need to do half the swaps to reverse)

; --- Print original string ---
MOV DX, offset STR      ; Load address of STR into DX
MOV AH, 09h             ; DOS print string function (AH=09h)
INT 21H                 ; Call DOS interrupt to print string

L1:                     ; Label for loop start (used for reversing)
XCHG AL, [SI]           ; Exchange AL with the byte at [SI] (store [SI] in AL)
XCHG [DI], AL           ; Exchange AL with [DI] (now [SI] goes to [DI])
XCHG AL, [SI]           ; Put the original [DI] back into [SI]
INC SI                  ; Move SI to next character (left to right)
DEC DI                  ; Move DI to previous character (right to left)
LOOP L1                 ; Decrement CX, repeat loop if CX ? 0

; --- Print newline ---
MOV DX, offset NEXTLINE ; Load address of newline string
MOV AH, 09H             ; DOS print string function
INT 21H                 ; Call DOS interrupt to print newline

; --- Print reversed string ---
MOV DX, offset STR      ; Load address of STR (now reversed)
MOV AH, 09H             ; DOS print string function
INT 21H                 ; Call DOS interrupt to print string

.exit                   ; Macro to terminate the program
END                     ; End of source file