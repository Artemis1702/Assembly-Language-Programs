INCLUDE 'EMU8086.INC'   ;SELECTION SORT
org 100h


.DATA   
NLINE db 13, 10, "$" 
ARR DB 5 DUP(?)



.CODE
LEA BX,ARR
MOV SI,BX
MOV AL,0

INPUT:
    CALL SCAN_NUM 
    MOV [SI],CX                   ;inputting elements in array
    INC SI              
    INC AL
    CMP AL,5
    JNZ INPUT
 
 
LEA BX,ARR 
MOV CL,1
JMP L6
L1: 
    CMP CL,5
    JE  EXIT           
    MOV DL,CL                      ;initiating i and j
    INC CL 
    MOV AH,[BX] 
    MOV SI,BX
    INC SI
L2:                      
    CMP DL,5             
    JE  L4                
    INC DL                           ;loop to find the minimum element
    CMP AH,[SI]        
    JNGE L3
    MOV AH,[SI]        
    MOV DI,SI                       
    
L3: 
    INC SI             
    JMP L2
L4:
     
    CMP  AH,[BX]
    JZ   L5            
    XCHG AH,[BX]       
    XCHG AH,[DI]       
    INC BX             
    JMP L6              
L5:
    INC BX
    JMP L6


L6:
    MOV SI,OFFSET ARR
    MOV CH,0
       
PRINT: 
    XOR AH,AH
    MOV AL,[SI]
    CALL PRINT_NUM 
    INC SI                  
    MOV DL, ' '
    MOV AH, 2               
    INT 21H                                    ;printing each iteration 
    INC CH
    CMP CH,5
    JNZ PRINT
    MOV AH, 09
    MOV DX, OFFSET NLINE 
    INT 21H
    JMP L1
    
EXIT:
    RET
    
    

        
        
DEFINE_PRINT_NUM 
DEFINE_PRINT_NUM_UNS 
DEFINE_SCAN_NUM
