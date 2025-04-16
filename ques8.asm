.model small

.data
Num1 db 20h          ; First number = 32 (in hex: 20h)
Num2 db 36h          ; Second number = 54 (in hex: 36h)
GCD_Out db ?         ; Variable to store the final GCD result

.code
.startup             ; Program starts

MOV AL, Num1         ; Load Num1 into AL register (AL = 32)
MOV BL, Num2         ; Load Num2 into BL register (BL = 54)

; -------- Euclidean Algorithm Begins --------
L1:
CMP AL, BL           ; Compare AL and BL
JE SKIP              ; If AL == BL, jump to SKIP (GCD found)

JB ELSE              ; If AL < BL, jump to ELSE (need to subtract AL from BL)

SUB AL, BL           ; AL = AL - BL (when AL > BL)
JMP L1               ; Repeat the loop

ELSE:
SUB BL, AL           ; BL = BL - AL (when AL < BL)
JMP L1               ; Repeat the loop

; -------- GCD Found --------
SKIP:
MOV GCD_Out, AL      ; Store GCD (which is in AL or BL) into GCD_Out

.exit
end
