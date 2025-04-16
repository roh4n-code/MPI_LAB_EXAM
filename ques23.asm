.model small             ; Define memory model as small (one data and one code segment)
.data                    ; Start of data segment

Num dw 5                 ; Define a word variable 'Num' with value 5 (used as loop count)

Block1 DB 23h, 42h, 63h, 77h, 25h   ; Define 5 bytes of data in Block1
Block2 DB 31h, 12h, 50h, 33h, 20h   ; Define 5 bytes of data in Block2

.code                    ; Start of code segment
.startup                 ; Directive to indicate the start of the program (sets up segment registers)

    MOV AX, DS           ; Move data segment address into AX
    MOV ES, AX           ; Copy it to ES (Extra Segment) so that both DS and ES point to the same segment

    MOV CX, Num          ; Load loop counter with value of Num (5)

    LEA SI, Block1       ; Load effective address of Block1 into SI (source index)
    LEA DI, Block2       ; Load effective address of Block2 into DI (destination index)

    CLD                  ; Clear direction flag (ensures SI and DI increment after each operation)

L1: 
    LODSB                ; Load byte at DS:SI into AL and increment SI
    ADD AL, ES:[DI]      ; Add byte at ES:DI (Block2) to AL (value from Block1)
    STOSB                ; Store AL into ES:DI and increment DI
    LOOP L1              ; Decrement CX and repeat loop if CX ? 0

.EXIT                   ; End of program execution
END                     ; End of file