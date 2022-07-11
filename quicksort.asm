DATA SEGMENT        ;Quick sort

    ARR DW 24, 20, 10, 7, 2

    I   DW  ? 
    J   DW  ?
    P   DW  0                           
    R   DW  4                         
    Q   DW  ?
    X   DW  ?

ENDS

STACK SEGMENT

    STK DB  100  DUP(0)
    TOP EQU 100

ENDS

CODE SEGMENT

    ASSUME CS: CODE, DS: DATA, SS:STACK

    START:

    
        MOV  AX, @DATA
        MOV  DS, AX
        MOV  AX, STACK
        MOV  SS, AX
        MOV  SP, TOP

  
        CALL QUICKSORT


        MOV  AH, 7
        INT  21H


        MOV  AX, 4C00H
        INT  21H

        

        QUICKSORT PROC

          
            MOV  AX, P 
            CMP  AX, R                  
            JGE  BIGGER1                

           
            CALL PARTITION

           
            MOV  Q, AX

            
            INC  AX
            PUSH AX
            PUSH R

                                    
            MOV  AX, Q
            MOV  R, AX
            DEC  R
            CALL QUICKSORT

            
            POP  R
            POP  P 
            CALL QUICKSORT 

            
            BIGGER1:
                RET

        QUICKSORT ENDP

        

        PARTITION PROC

           
            MOV  SI, OFFSET ARR
            MOV  AX, R
            SHL  AX, 1                  
            ADD  SI, AX
            MOV  AX, [ SI ]       
            MOV  X,  AX                

            
            MOV  AX, P
            MOV  I,  AX
            DEC  I

            
            MOV  AX, P
            MOV  J,  AX

           
            FOR_J:

            
                MOV  SI, OFFSET ARR
                MOV  AX, J
                SHL  AX, 1             
                ADD  SI, AX
                MOV  AX, [ SI ]        

               
                CMP  AX, X
                JG   BIGGER             

               
                INC  I
                
               
                MOV  DI, OFFSET ARR
                MOV  CX, I
                SHL  CX, 1             
                ADD  DI, CX
                MOV  CX, [ DI ]        

              
                MOV  [ DI ], AX
                MOV  [ SI ], CX
            
             
                BIGGER:

                    INC  J             
                    MOV  AX, R
                    CMP  J,  AX        
                    JL   FOR_J          

          
            INC  I
            MOV  SI, OFFSET ARR
            MOV  AX, I
            SHL  AX, 1                
            ADD  SI, AX
            MOV  AX, [ SI ]           

           
            MOV  DI, OFFSET ARR
            MOV  CX, R
            SHL  CX, 1                 
            ADD  DI, CX
            MOV  CX, [ DI ]            

            
            MOV  [ DI ], AX
            MOV  [ SI ], CX  

            
            MOV  AX, I
            RET

        PARTITION ENDP
    
ENDS

    END START