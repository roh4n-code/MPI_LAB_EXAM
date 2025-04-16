.model small
.data
msg db "Enter a number between 1 and 9: $"
New_line db 0Ah, 0Dh, "$"
.code
.startup
    ; Display the prompt
    MOV DX, offset msg
    MOV AH, 09h
    INT 21h

    ; Read user input
    MOV AH, 01h
    INT 21h

    ; Convert ASCII to number
    AND AL, 0Fh
    MOV CL, AL         ; Store number in CL (8-bit)
    XOR CH, CH         ; Clear upper byte of CX
    MOV SI, 1          ; SI = line counter starting from 1

OuterLoop:
    ; Print newline
    MOV DX, offset New_line
    MOV AH, 09h
    INT 21h

    ; Move lower byte of SI into BL (safe because SI <= 9)
    MOV Bx, SI       ; Use SIL (low byte of SI) for compatibility

InnerLoop:
    MOV DL, '*'        ; Print *
    MOV AH, 02h
    INT 21h

    DEC Bx
    JNZ InnerLoop      ; Keep printing until BL == 0

    INC SI
    CMP SI, Cx        ; Compare low byte of SI to input
    JG Done            ; Exit loop if SI > input

    JMP OuterLoop

Done:
.exit
end
