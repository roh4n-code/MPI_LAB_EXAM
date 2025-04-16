org 100h                 ; ORG directive: origin address for a .COM program (starts at offset 100h)

.data
binary db 0Ah           ; Binary input value (e.g., 00001010 = 10 in decimal)
gray db ?               ; Variable to store the resulting Gray code

.code
.startup                ; Macro to initialize program start (sets up DS, etc.)

lea si, binary          ; Load address of 'binary' into SI register
mov al, [si]            ; Move the binary value into AL register

shr al, 1               ; Shift AL right by 1 (logical shift) — divides the binary number by 2
                        ; This effectively prepares the MSB for Gray code conversion

xor al, [si]            ; XOR the shifted value with the original binary value
                        ; This is the formula to convert binary to Gray code: Gray = Binary XOR (Binary >> 1)

mov gray, al            ; Store the resulting Gray code into the 'gray' variable

.exit                   ; Macro to exit the program (calls INT 20h internally)
end                     ; End of program