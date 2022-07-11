org 100h  ;count sort

.data
array db 50 dup(?)
index_array db 256 dup(0)
output_array db 50 dup(?)

inputNumber dw 0000h

array_size dw 0000h
max_size dw 256

; Helper Strings
newline db 0dh, 0ah, '$'

; Prompt Strings
get_array_size db "Enter Array Size : $"
get_array_elems db "Elements : $"

.code

lea dx, get_array_size
call print_string

call getNumberInput
mov ax, inputNumber
mov array_size, ax

lea dx, newline
call print_string

lea dx, get_array_elems
call print_string

mov cx, array_size
lea di, array
array_input:
    call getNumberInput
    mov ax, inputNumber
    stosb
    loop array_input

call sort

ret

proc sort

    call prepareIndexArray
    call accumulateIndexArray
    call sortUsingIndexArray
    ret  
    
endp sort

proc accumulateIndexArray
    
    lea si, index_array
    lea di, index_array
    inc di

    xor bx, bx

    mov cx, max_size
    dec cx
    aia_loop:
        xor bx, bx
        add bl, [si]
        add bl, [di]
        mov [di], bl
        inc di
        inc si         
        loop aia_loop
    
    ret    
endp accumulateIndexArray

proc sortUsingIndexArray
    
    lea bx, array
    lea si, index_array
    lea di, output_array
    
    mov cx, array_size
    suia_loop:
        
        xor ax, ax
        mov al, [bx]
        add si, ax

        xor ax, ax
        mov al, [si]
        add di, ax
        sub al, 1
        mov [si], al
        dec di
        
        xor ax, ax
        mov al, [bx]
        mov [di], al
        
        lea di, output_array
        lea si, index_array
        
        inc bx
        
        loop suia_loop
    
    ret
endp sortUsingIndexArray


proc prepareIndexArray
    
    lea si, array
    lea di, index_array

    mov cx, array_size
    pia_while:
        xor ax, ax
        mov al, [si]
        add di, ax
        
        xor bx, bx
        mov bl, [di]
        add bx, 1
        mov [di], bl
        
        lea di, index_array
        inc si
        
        loop pia_while
   
    ret
        
endp prepareIndexArray

proc print_string
    mov ah, 9
    int 21h
    ret    
endp print_string

proc getNumberInput
    
    mov bx, 0
    while:
        mov ah, 1
        int 21h
        
        cmp al, ' '
        je done_getting_number
        
        cmp al, 0dh
        je done_getting_number
        
        mov ah, 0
        sub al, '0'
        push ax
        mov ax, 10
        mul bx
        mov bx, ax
        pop ax
        add bx, ax

    jmp while
    
    done_getting_number:
        mov inputNumber, bx
    
    ret
endp getNumberInput



