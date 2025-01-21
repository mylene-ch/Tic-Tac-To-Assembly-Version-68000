AFFCAR:
    MOVE #6, D0
    TRAP #15
    RTS

SAISCAR:
    MOVE #5, D0
    TRAP #15
    RTS
    
FINPRG:
    MOVE #9, D0
    TRAP #15
    
AFFCHAINE:
    MOVE.B  (A0)+, D1
    JSR     AFFCAR
    CMP.B   #0,D1
    BNE AFFCHAINE
    RTS
    
SAISCHAINE:   
    JSR     SAISCAR
    MOVE.b  D1, (A0)+
    CMP.b   #13, D1
    BNE     SAISCHAINE
    ADD.L   #-1, A0
    MOVE.B  #0, (A0)
    RTS


POS_CURS:
    MOVE #11, D0
    TRAP #15
    RTS
   
ALALIGNE:
    MOVE.B      #13, D1
    JSR         AFFCAR
    MOVE.B      #10, D1
    JSR         AFFCAR
    RTS  
    
CALCULEK:*THE VALUE OF K WILL BE IN K
    MOVE        #0, D0
    MOVE.B      CHOSEN_LINE, D0
    MULU        #3, D0
    ADD.B       CHOSEN_COL, D0
    MOVE.B      D0, K
    RTS
      

GET_COOR:
    MOVE        #320, D1
    MOVE        #120, D2
    MOVE        #380, D3
    MOVE        #180, D4
    MOVE        #0, D5
    ADD.B       CHOSEN_LINE,D5
    CMP         #0,D5
    BEQ         SET_COL
    MULU        #100, D5
    ADD         D5, D2
    ADD         D5, D4
    SET_COL:
    MOVE        #0, D5
    ADD.B       CHOSEN_COL,D5
    CMP         #0, D5
    BEQ         SET
    MULU        #100, D5
    ADD         D5, D1
    ADD         D5, D3
    SET:
    MOVE.W        D1, X1
    MOVE.W        D2, X2
    MOVE.W        D3, Y1
    MOVE.W        D4, Y2
    RTS    

CHECK_VALID_INPUT:
    CMP.B       #88, PLAYER_CHOIX
    BEQ         PASS
    CMP.B       #79, PLAYER_CHOIX
    BEQ         PASS
    BRA         REPUT
    REPUT:
    MOVE.B      #1, INVALID_INPUT
    RTS
    PASS:
    MOVE.B      #0, INVALID_INPUT
    RTS

CHECK_WIN_LINE:
    MOVE.L      #0, D1
    MOVE.L      #0, D2
    MOVE.L      #0, D3
    MOVE.L      #0, D4
    MOVE.L      #0, D5
    ADD.B       CHOSEN_LINE, D1
    ADD.B       PATTERN_TO_PLAY, D4
    MOVE.L      #GRILL, A1
    ADD.B       CHOSEN_LINE, D5
    MULU        #3, D5
    ADD.L       D5, A1  
    MOVE.B      (A1),D2 *D2 has the contune of the first case of the line
    CMP.B       D4, D2
    BNE         CUT
    MOVE.L      #GRILL, A1
    MOVE.L      #0,D5
    ADD.B       CHOSEN_LINE, D5
    MULU        #3, D5
    ADD.B       #1, D5
    ADD.L       D5, A1
    MOVE.B     (A1),D3 *D3 has the contenu of the second case of the line
    CMP.B       D4,D3
    BNE         CUT
    MOVE.L      #GRILL, A1
    MOVE.L      #0,D5
    ADD.B       CHOSEN_LINE, D5
    MULU        #3, D5
    ADD.B       #2, D5
    ADD.L       D5, A1
    MOVE.B      (A1),D2 *D2 has the contune of the third case of the line
    CMP.B       D4,D2
    BNE         CUT
    CMP.B       #88, PATTERN_TO_PLAY
    BEQ         SET_X_WIN_L
    BRA         SET_O_WIN_L
    SET_X_WIN_L:
    MOVE.B      #1,X_WIN
    RTS
    SET_O_WIN_L:
    MOVE.B      #1,O_WIN
    RTS

    
CHECK_WIN_COL:
    MOVE.L      #0, D1
    MOVE.L      #0, D2
    MOVE.L      #0, D3
    MOVE.L      #0, D4
    ADD.B       PATTERN_TO_PLAY, D4
    ADD.B       CHOSEN_COL, D1
    MOVE.L      #GRILL, A1
    ADD.L       D1, A1  
    MOVE.B      (A1),D2 *D2 has the contune of the first case of the colomn
    CMP.B       D4, D2
    BNE         CUT
    MOVE.B      #3, D1
    ADD.B       CHOSEN_COL, D1
    MOVE.L      #GRILL, A1
    ADD.L       D1, A1
    MOVE.B      (A1),D3 *D3 has the contenu of the second case of the colomn
    CMP.B       D4,D3
    BNE         CUT
    MOVE.B      #6, D1
    ADD.B       CHOSEN_COL, D1
    MOVE.L      #GRILL, A1
    ADD.L       D1, A1
    MOVE.B      (A1),D2 *D2 has the contune of the third case of the colomn
    CMP.B       D2,D4
    BNE         CUT
    CMP.B       #88, PATTERN_TO_PLAY
    BEQ         SET_X_WIN_C
    BRA         SET_O_WIN_C
    SET_X_WIN_C:
    MOVE.B      #1,X_WIN
    RTS
    SET_O_WIN_C:
    MOVE.B      #1,O_WIN
    RTS
    
CHECK_WIN_DIAG1:
    MOVE.L      #0, D1
    MOVE.L      #0, D4
    ADD.B       PATTERN_TO_PLAY, D4
    MOVE.L      #GRILL, A1
    MOVE.B      (A1),D2 *D2 has the contune of the first case of the DIAG1
    CMP.B       D4, D2
    BNE         CUT
    MOVE.B      #4, D1
    MOVE.L      #GRILL, A1
    ADD.L       D1, A1
    MOVE.B      (A1),D3 *D3 has the contenu of the second case of the DIAG1
    CMP.B       D4,D3
    BNE         CUT
    MOVE.B      #8, D1
    MOVE.L      #GRILL, A1
    ADD.L       D1, A1
    MOVE.B      (A1),D2 *D2 has the contenu of the third case of the DIAG1
    CMP.        D2,D4
    BNE         CUT
    CMP.B       #88, PATTERN_TO_PLAY
    BEQ         SET_X_WIN_D1
    BRA         SET_O_WIN_D1
    SET_X_WIN_D1:
    MOVE.B      #1,X_WIN
    RTS
    SET_O_WIN_D1:
    MOVE.B      #1,O_WIN
    RTS



    
CHECK_WIN_DIAG2:
    MOVE.L      #2, D1
    MOVE.L      #0, D4
    MOVE.L      #GRILL, A1
    ADD.B       PATTERN_TO_PLAY, D4
    ADD.L       D1, A1       
    MOVE.B      (A1),D2 *D2 has the contune of the first case of the DIAG2
    CMP.B       D4, D2
    BNE         CUT
    MOVE.L      #4, D1
    MOVE.L      #GRILL, A1
    ADD.L       D1, A1
    MOVE.B      (A1),D3 *D3 has the contenu of the second case of the DIAG2
    CMP.B       D4,D3
    BNE         CUT
    MOVE.L      #6, D1
    MOVE.L      #GRILL, A1
    ADD.L       D1, A1
    MOVE.B      (A1),D2 *D2 has the contenu of the third case of the DIAG2
    CMP.B       D2,D4
    BNE         CUT
    CMP.B       #88, PATTERN_TO_PLAY
    BEQ         SET_X_WIN_D2
    BRA         SET_O_WIN_D2
    SET_X_WIN_D2:
    MOVE.B      #1,X_WIN
    RTS
    SET_O_WIN_D2:
    MOVE.B      #1,O_WIN
    RTS

CUT:
    RTS
    









    
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
