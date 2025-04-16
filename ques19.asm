.model small
.stack 100h

.data
; No explicit data segment used — assumes data is already at 5000h and 6000h

.code
.startup
    ; Initialize DS and ES to point to two blocks in memory
    MOV AX, 5000h       ; Source block at segment 5000h
    MOV DS, AX

    MOV AX, 6000h       ; Destination block at segment 6000h
    MOV ES, AX

    MOV SI, 0000h       ; Offset for source
    MOV DI, 0000h       ; Offset for destination

    MOV CX, 14h         ; Compare 20 bytes (14h = 20 in hex)
    MOV BL, 0           ; Default: not equal

    CLD                 ; Clear direction flag (compare forward)

    REPE CMPSB          ; Compare bytes from DS:SI and ES:DI while equal
    JNE EXIT            ; If not equal, jump to EXIT

    MOV BL, 1           ; If all bytes are equal, set BL = 1

EXIT:
    .EXIT
END
