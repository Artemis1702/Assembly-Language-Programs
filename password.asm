
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data  

msg1 db "Enter Your Pssword : $" 
msg2 db "Re-Enter Your Password : $"
msg3 db "Valid Password!$"
msg4 db "Invalid Password!$"  
nline db 13,10,"$"
pass db 50,50 dup(?)  
passlen db 0 
pass1 db 50,50 dup(?)  
passlen1 db 0
upno db 0
lono db 0  
digno db 0


.code  
first:
    call newline
    lea dx,msg1
    mov ah,9h
    int 21h
    lea dx,pass           ;entering password
    mov ah,0ah
    int 21h 
    call newline

    xor bx,bx
    mov bl,pass[1]
    mov passlen,bl
    mov pass[bx+2],'$'

second:
    lea dx,msg2 
    mov ah,9
    int 21h   
    lea dx,pass1              ;re-entering password
    mov ah,0ah
    int 21h 

    mov bx,0
    mov bl,pass1[1]
    mov passlen1,bl
    mov pass1[bx+2],'$'

mov al,passlen
cmp al,passlen1
je comp                           ;whether first and second have same number of characters
call newline 
call error
call newline
jmp first    

comp: 
    cmp al,8h
    jge func                 ;whether password has 8 characters
    call newline 
    call error
    call newline
    jmp first 
    



func:
    call newline  
    xor cx,cx
    mov cl,passlen
    mov si,2h
l1:
    mov al,pass1[si] 
    cmp pass[si],al
    je up
    call newline             ;whether the characters of both are same
    call error
    call newline
    jmp first
    up: 
        cmp al,'A'
        jl lo                   ;whether uppercase there
        cmp al,'Z'
        jg lo
        inc upno
    lo:
        cmp al,'a'
        jl dig
        cmp al,'z'                  ;whether lower case there
        jg dig
        inc lono
    dig:
        cmp al,'0'
        jl next                       ;whether digit there
        cmp al,'9'
        jg next
        inc digno
    next:
        inc si
loop l1

cmp upno,1
jl inval

cmp lono,1
jl inval

cmp digno,1
jl inval


call newline
call correct
jmp exit


inval:
    call newline
    call error
    call newline
    jmp first

exit:
    ret
          

newline proc
 lea dx,nline
 mov ah,9h
 int 21h
 ret
newline endp    

error proc
    lea dx,msg4
    mov ah,9h
    int 21h
    ret
error endp

correct proc
    lea dx,msg3
    mov ah,9h
    int 21h
    ret
correct endp
      
      

      





