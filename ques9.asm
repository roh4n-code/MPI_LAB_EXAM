.model small
.data
Num1 db 25h
Num2 db 10h
LCM_Out dw ?
.code
.startup

MOV AL, Num1    ; AL will hold multiples of Num1
MOV BL, Num2    ; BL will hold the original Num2
MOV CL, Num1    ; CL stores the original Num1 for incrementing 
mov ch,0
MOV SI, AX
FIND_LCM:
    MOV AH, 0       ; Clear AH for division
    MOV AX, SI      ; Store current multiple of Num1 in DL
    DIV BL          ; Divide by Num2
    CMP AH, 0       ; Check if remainder is zero
    JZ DONE         ; If remainder is zero, we found LCM
    
    ; If not, try the next multiple of Num1
    ADD SI, CX      ; Add Num1 to AL to get next multiple
    JMP FIND_LCM    ; Continue checking

DONE:
    MOV LCM_Out, SI ; Store LCM result
.exit
end