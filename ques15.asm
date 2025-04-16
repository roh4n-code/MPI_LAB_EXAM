.model small
.data
    StrLen dw 5                              ; Length of the string
    STR db 'MADAM'                           ; Original string
    REVSTR db 5 dup('$')                     ; Reversed string placeholder
    Msg1 db 0Ah, 0Dh, 'The string is a palindrome.$'
    Msg2 db 0Ah, 0Dh, 'The string is NOT a palindrome.$'
    MsgOriginal db 0Ah, 0Dh, 'Original: $'
    MsgReversed db 0Ah, 0Dh, 'Reversed: $'
    NewLine db 0Ah, 0Dh, '$'

.code
.startup
    ; Initialize segment registers
    MOV AX, @data
    MOV DS, AX
    MOV ES, AX

    ; Get string length
    MOV CX, StrLen
    MOV SI, offset STR
    MOV DI, offset REVSTR
    ADD SI, CX
    DEC SI          ; Point SI to last char of STR

ReverseLoop:
    MOV AL, [SI]
    MOV [DI], AL
    INC DI
    DEC SI
    LOOP ReverseLoop

    ; Null-terminate reversed string
    MOV AL, '$'
    MOV [DI], AL

    ; Compare strings
    MOV CX, StrLen
    MOV SI, offset STR
    MOV DI, offset REVSTR
    MOV BL, 1           ; Assume it's a palindrome

CompareLoop:
    MOV AL, [SI]
    MOV DL, [DI]
    CMP AL, DL
    JNE NotPalindrome
    INC SI
    INC DI
    LOOP CompareLoop
    JMP IsPalindrome

NotPalindrome:
    MOV BL, 0           ; It's not a palindrome

IsPalindrome:
    ; Print Original String
    MOV DX, offset MsgOriginal
    MOV AH, 09h
    INT 21h

    MOV DX, offset STR
    MOV AH, 09h
    INT 21h

    ; Print Reversed String
    MOV DX, offset MsgReversed
    MOV AH, 09h
    INT 21h

    MOV DX, offset REVSTR
    MOV AH, 09h
    INT 21h

    ; Print result message
    CMP BL, 1
    JE PrintPalindrome

    MOV DX, offset Msg2
    MOV AH, 09h
    INT 21h
    JMP Done

PrintPalindrome:
    MOV DX, offset Msg1
    MOV AH, 09h
    INT 21h

Done:
    MOV AH, 4Ch
    INT 21h

end
