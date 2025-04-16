.model small
.data
FACT dw ?                        ; Variable to store the factorial result (2 bytes = 16-bit)
msg db "Enter a number between 1 and 8:$" ; Prompt message for the user (terminated by $ for int 21h, function 09)

.code
.startup                         ; Entry point of the program

mov dx, offset msg               ; Load the address of the message into DX
mov ah, 09h                      ; DOS function 09h: display string at address in DX
int 21h                          ; Call DOS interrupt to display the message

mov ah, 01h                      ; DOS function 01h: read a character from keyboard (returns ASCII in AL)
int 21h                          ; Call DOS interrupt ? AL now contains ASCII of entered digit (e.g., '5' = 35h)

and al, 0Fh                      ; Convert ASCII digit to numeric value by masking upper nibble (AL = AL & 0Fh)
                                 ; Now AL contains number 0–9 (e.g., '5' = 35h ? AL = 05h)

mov ch, 00h                      ; Clear CH (high byte of CX)
mov cl, al                      ; Move number to CL (CX = input number)

mov ax, 0001h                   ; Initialize AX with 1 (start value for factorial)

L1: MUL cx                      ; Multiply AX by CX ? AX = AX * CX
                                ; Note: MUL with a register (CX) multiplies AX and stores result in AX

Loop L1                         ; Decrement CX and jump to L1 if CX ? 0

lea bx, FACT                   ; Load address of FACT into BX
mov [bx], ax                   ; Store the final factorial result (in AX) into FACT

.exit                          ; Exit the program
end                            ; End of source file
