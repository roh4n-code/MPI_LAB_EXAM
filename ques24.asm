ORG 1000H              ; Set the origin (starting address) to 1000H

MOV BX, 1100H          ; Load the address 1100H into BX (BX will be used to access memory)
MOV AL, [BX]           ; Load the byte at memory location 1100H into AL
MOV DX, 0000H          ; Clear DX (DL = units of 100s, DH = 10s count), used for storing digits

; --- Extract Hundreds Digit ---
HUND:
CMP AL, 64H            ; Compare AL with 100 (64H = 100 decimal)
JB TEN                 ; If AL < 100, go to TEN
SUB AL, 64H            ; Subtract 100 from AL
INC DL                 ; Increment DL (hundreds digit counter)
JMP HUND               ; Repeat until AL < 100

; --- Extract Tens Digit ---
TEN:
CMP AL, 0AH            ; Compare AL with 10
JB UNIT                ; If AL < 10, go to UNIT
SUB AL, 0AH            ; Subtract 10 from AL
INC DH                 ; Increment DH (tens digit counter)
JMP TEN                ; Repeat until AL < 10

; --- Combine and Store Result ---
UNIT:
MOV CL, 4              ; Load 4 into CL (used for rotating bits)
ROL DH, CL             ; Rotate DH left by 4 bits: moves tens digit to upper nibble
ADD AL, DH             ; Add the rotated tens digit to AL (AL contains the units digit now)
MOV [BX+1], AL         ; Store the combined BCD (Binary-Coded Decimal) value at address 1101H
MOV [BX+2], DL         ; Store the hundreds digit at address 1102H

RET                    ; Return from procedure (or end program if it's a .COM file)
