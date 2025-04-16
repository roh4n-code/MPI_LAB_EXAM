.model small
.data
    Num1 db 06h         ; First number
    Num2 db 04h         ; Second number
    Result dw ?         ; 16-bit result to store product

.code
.startup

    ; Load operands
    MOV AL, Num1        ; AL = Multiplicand
    MOV BL, Num2        ; BL = Multiplier

    ; Clear result
    XOR DX, DX          ; DX = 0 (High byte of result)
    XOR AH, AH          ; AH = 0 (Temporary register for shifting)

    MOV CL, 8           ; 8 bits to process

MultiplyLoop:
    TEST BL, 01h        ; Check if LSB of multiplier is 1
    JZ SkipAdd
    ADD DX, AX          ; Add multiplicand to result

SkipAdd:
    SHL AX, 1           ; Shift multiplicand left (multiply by 2)
    SHR BL, 1           ; Shift multiplier right (divide by 2)
    DEC CL
    JNZ MultiplyLoop

    ; Store result
    MOV Result, DX

    ; Done
    MOV AH, 4Ch
    INT 21h 
    END
    
    
    .model small

.data
NUM1 db 06h
NUM2 db 04h
ANS dw ?

.code
.startup

MOV AL,NUM1
MOV BL,NUM2

MOV CL,8

XOR DX,DX
XOR AH,AH

MUL:
TEST BL,01h
JZ SKIPMUL
ADD DX,AX

SKIPMUL:
SHL AX,1
SHR Bl,1
DEC CL
JZ MUL
 

MOV ANS,DX

MOV AH,4CH 
INT 21H
END
