.model small         ; Define memory model as small (1 code + 1 data segment)
.data               ; Start of data segment

BCDNum db 45h       ; Define a BCD number: 45h (which represents decimal 45 in BCD)

.code               ; Start of code segment
.startup            ; Setup for small model program, sets DS = CS

MOV AL, BCDNum      ; Load the BCD number (45h) into AL register
CALL BCDtoBIN       ; Call the procedure to convert BCD to binary
INT 21H
.exit               ; Exit the program

; --- Procedure: BCDtoBIN ---
; Converts a BCD value in AL to binary and leaves result in AL

BCDtoBIN PROC

MOV BL, AL          ; Copy AL to BL for later use
AND BL, 0Fh         ; Mask upper nibble -> BL now contains the units digit (e.g., 5 from 45h)

AND AL, 0F0h        ; Mask lower nibble -> AL now contains upper nibble (e.g., 40h from 45h)
MOV CL, 4           ; Set CL = 4 (number of bits in a nibble)
ROR AL, CL          ; Rotate AL right by 4 bits -> AL now contains the tens digit (e.g., 4)

MOV BH, 0Ah         ; Set BH = 10 (used to multiply the tens digit)
MUL BH              ; AL = AL * 10 (convert tens part to decimal)

ADD AL, BL          ; Add the units digit -> AL now contains full binary result

RET                 ; Return from procedure

BCDtoBIN ENDP       ; End of procedure
END                 ; End of program