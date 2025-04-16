.model small               ; Define memory model (code and data < 64KB each)

.data                      ; Start of data segment
N db ?                    ; Variable to store user input number (1–9)
CNT db 1                  ; Initial number of asterisks to print per row (starts with 1)
msg db "Enter a number (1-9):$" ; Prompt message for user input

.code                      ; Start of code segment
.startup                   ; Initialize code execution

; --- Display prompt message ---
MOV DX, offset msg         ; Load address of the message into DX
MOV AH, 09h                ; DOS function to display string (until '$')
INT 21h                    ; Interrupt call to display message

; --- Take input character from user ---
MOV AH, 01h                ; DOS function to take 1 character input from keyboard
INT 21h                    ; Input character (ASCII '1' to '9') returned in AL

; --- Convert ASCII digit to numeric value ---
SUB AL, 30h                ; Convert ASCII to actual number (e.g., '3' ? 3)
MOV N, AL                  ; Store the numeric value in N

; --- Print carriage return and newline ---
MOV DL, 0Dh                ; Carriage return
MOV AH, 02h
INT 21h
MOV DL, 0Ah                ; Line feed
INT 21h

; --- Set CL = number of lines to print ---
MOV CL, N                 ; Set loop counter to user input value (number of rows)

; ----------- MAIN LOOP START (L1) ----------
L1:
MOV BH, CL                ; Copy CL to BH (used for calculating spaces)
DEC BH                    ; BH = number of spaces to print
JZ L3                     ; If BH = 0, skip printing spaces (for first line)

; --- Print spaces before asterisks ---
SPACES:
MOV DX, ' '               ; Load space character into DL
MOV AH, 02h               ; DOS function to print a character
INT 21h
DEC BH                   ; Decrement space counter
JNZ SPACES               ; If BH ? 0, print another space

; ---------- PRINT ASTERISKS ----------
L3:
MOV BL, CNT              ; BL = number of asterisks to print on this line
L2:
MOV DX, '*'              ; Load '*' character into DL
MOV AH, 02h              ; DOS function to print character
INT 21h
DEC BL                  ; Decrement asterisk counter
JNZ L2                  ; Loop until all asterisks printed

; --- Print newline after each row ---
MOV DL, 0Dh              ; Carriage return
MOV AH, 02h
INT 21h
MOV DL, 0Ah              ; Line feed
INT 21h

; --- Increase asterisk count by 2 for next row ---
ADD CNT, 2               ; Next row will have more stars (1 ? 3 ? 5 ...)

; --- Decrease row count and loop if not zero ---
DEC CL                   ; Decrement remaining rows
JNZ L1                   ; If not zero, continue to next line

.exit                     ; Exit program
end                       ; End of program