.model small

.data
msg db "enter a number between 1 and 9:$" ; Prompt message for user
New_line db 0AH, 0DH, "$"                 ; New line (Line Feed + Carriage Return)

.code
.startup                      ; Program starts here

; ---------- Print prompt message ----------
MOV DX, offset msg            ; Load address of message
MOV AH, 09                    ; DOS interrupt to display string (function 09h)
INT 21h

; ---------- Take input ----------
MOV AH, 1                     ; Function 01h: read character from keyboard
INT 21h                       ; AL contains ASCII of the digit

AND AL, 0Fh                   ; Convert ASCII to actual number (e.g., '5' = 35h ? 5)
MOV CL, AL                    ; Store number in CL (counter)
MOV CH, 00                    ; Clear CH, now CX = number of lines to print
MOV SI, CX                    ; Copy count to SI for restoring inside outer loop

; ---------- Outer loop (lines) ----------
Out_L:
MOV DX, offset New_line       ; Print newline
MOV AH, 09
INT 21h

MOV BX, SI                    ; BX = number of asterisks to print on this line

; ---------- Inner loop (stars) ----------
IN_L:
MOV DL, '*'                   ; Character to print
MOV AH, 2                     ; DOS function 02h: print character in DL
INT 21h

DEC BX                        ; Decrement inner counter
JNZ IN_L                      ; If BX ? 0, continue printing stars

LOOP Out_L                    ; Decrement CX, jump to Out_L if CX ? 0

.exit                         ; Exit program
end