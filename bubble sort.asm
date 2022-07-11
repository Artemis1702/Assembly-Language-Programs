INCLUDE 'EMU8086.INC'   ;BUBBLE SORT
org 100h


.DATA
ARR DB 5 DUP(?)
NLINE db 13, 10, "$" 


.CODE
LEA BX,ARR
MOV SI,BX
MOV AH,0 


INPUT: 
    CALL SCAN_NUM 
    MOV [SI],CX          
    INC SI                       ;input the numbers into an array
    INC AH
    CMP AH,5
    JNZ INPUT



LEA BX,ARR
MOV CL,1
MOV DI,BX 
JMP L4
L1:
    CMP CL,5             
    JE  EXIT             
    MOV DL,CL                    ;creating i and j
    INC CL 
    MOV AL,[BX]
    MOV DI,BX
    MOV SI,BX
    INC SI
L2:
    CMP DL,5             
    JE  L4             
    INC DL                       ;j incremented each time it goes to loop 2 
    CMP AL,[SI]          
    JNGE L3                      ;compare ith value with the jth value  and exchanging if needed
    XCHG AL,[SI]         
    XCHG AL,[DI]            
    JMP L3               

L3:
    MOV AL,[SI]
    MOV DI,SI                      
    INC SI               
    JMP L2
            
L4:
       MOV SI,OFFSET ARR
       MOV CH,0
       
PRINT: 
    XOR AH,AH
    MOV AL,[SI]
    CALL PRINT_NUM          
    INC SI
    MOV DL, ' '
    MOV AH, 2               
    INT 21H
    INC CH
    CMP CH,5                                 ;printing each iteration 
    JNZ PRINT
    MOV AH, 09
    MOV DX, offset NLINE  
    INT 21H
    JMP L1
    
EXIT:
    RET

DEFINE_PRINT_NUM 
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM
 
                    




