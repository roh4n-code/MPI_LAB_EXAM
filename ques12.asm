.model small
.data
    msg db "Enter a number between 1 to 9:$" ; Prompt message for user input
    newline db 0Ah,0Dh,"$"                  ; Newline characters for DOS (CR LF)

.code
.startup
    ; Display the message
    MOV DX, offset msg
    MOV AH, 09
    INT 21H

    ; Read a single character from user input
    MOV AH, 01
    INT 21H

    ; Convert ASCII digit to numeric value (e.g., '3' -> 3)
    AND AL, 0FH
    MOV CL, AL       ; Store it in CL (used as outer loop counter)
    MOV CH, 00H      ; Clear CH to form full CX value
    MOV SI, 1        ; Initialize SI to 1 (will control number of * in each row)

OUT_L: ; Outer loop for each line
    ; Print newline
    MOV DX, offset newline
    MOV AH, 09
    INT 21H

    MOV BX, SI       ; BX stores number of '*' to print
    ADD SI, 1        ; Increment SI for next line (i.e., increasing pattern)
    MOV BP, CX       ; Copy outer loop counter to BP for space loop

SPACE: ; Loop for printing leading spaces
    MOV DL, ' '
    MOV AH, 2
    INT 21H
    DEC BP
    JNZ SPACE        ; Print (user_input - line_number) spaces

    JMP IN_L         ; Jump to inner loop for printing '*'

IN_L: ; Inner loop for printing '*'
    MOV DL, '*'
    MOV AH, 2
    INT 21H
    MOV DL, ' '
    INT 21H
    DEC BX
    JNZ IN_L         ; Continue until BX == 0

    LOOP OUT_L       ; CX acts as loop counter for number of lines

.EXIT
END