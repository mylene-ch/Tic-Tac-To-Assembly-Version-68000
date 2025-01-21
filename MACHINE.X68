*-----------------------------------------------------------
* Title      :GAME IMPORVED VERSION (MACHINE version)
* Written by :ZRW
* Date       :30/12/2024
* Description:DRAPEAU ANGLAIS
* NOTE: WOKRING VERSION: GAME_HUMAIN IN GAME6 && MACHINE IN GAME7
*-----------------------------------------------------------
    ORG         $400                                                   

    JSR         SHOW_GRILL 
    MOVE.L      #1, D6 *COUTER MAX=9
    **Players choose patterns first
choose_pattern:
    MOVE.L      #0, D1      
    JSR         POS_CURS
    MOVE.L      #ERACE_LINE,A0
    JSR         AFFCHAINE
    MOVE.L      #1, D1      
    JSR         POS_CURS
    MOVE.L      #ERACE_LINE,A0
    JSR         AFFCHAINE
    MOVE.L      #0, D1      
    JSR         POS_CURS
    MOVE.L      #TIP0,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    JSR         SAISCAR
    MOVE.B      D1, PLAYER_CHOIX
    JSR         ALALIGNE
    
    *****CHECK INPUT****
    JSR         CHECK_VALID_INPUT
    CMP.B       #1, INVALID_INPUT
    BNE         STORE_INPUT
    MOVE.L      #TIP10,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    MOVE.L      #TIP9,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    JSR         choose_pattern
    *****CHECK INPUT****
STORE_INPUT:    
    CMP.B       #88, PLAYER_CHOIX
    BNE         AUTO_X
    BRA         AUTO_O
AUTO_X:
    MOVE.B      #88, AUTO_CHOIX
    BRA         game_start
AUTO_O:
    MOVE.B      #79, AUTO_CHOIX

game_start:
    BTST.L      #0, D6 ***If the turn number is odd, player play; else machine plays
    BEQ         SET_AUTO 
    MOVE.B      PLAYER_CHOIX ,PATTERN_TO_PLAY
    BRA         choose_case
SET_AUTO:
    MOVE.B      AUTO_CHOIX ,PATTERN_TO_PLAY
    BRA         AUTO_FILL

choose_case:
    MOVE.L      #4, D1      
    JSR         POS_CURS
    MOVE.L      #ERACE_LINE,A0
    JSR         AFFCHAINE
    MOVE.L      #4, D1      
    JSR         POS_CURS
    MOVE.L      #TIP1,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    *SAISIR STDIN POUR i  
    JSR         SAISCAR
    SUB.B       #$30, D1
    MOVE.B      D1, CHOSEN_LINE
    CMP.B       #2, CHOSEN_LINE
    BGT         choose_case
    JSR         ALALIGNE    
SAISI_j:
    MOVE.L      #6, D1      
    JSR         POS_CURS
    MOVE.L      #ERACE_LINE,A0
    JSR         AFFCHAINE
    MOVE.L      #6, D1      
    JSR         POS_CURS    
    MOVE.L      #TIP2,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    *SAISIR STDIN POUR j
    JSR         SAISCAR
    SUB.B       #$30, D1
    MOVE.B      D1, CHOSEN_COL
    CMP.B       #2, CHOSEN_COL
    BGT         SAISI_j
    JSR         ALALIGNE
    
    JSR         CALCULEK 
    JSR         GET_COOR
    *****K IS SORTED IN K****
    
    **CHECK EMPTY**
    MOVE.L      #GRILL, A1
    MOVE.L      #0,D1
    MOVE.B      K,D1
    ADD.L       D1,A1
    CMP.B       #$FF, (A1)
    BEQ         CONTINUE **IF NOT EMPTY, REENETR i AND j***
    MOVE.L      #TIP8,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    MOVE.L      #TIP9,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    BRA         choose_case
    **CHECK EMPTY**
AUTO_FILL
    MOVE.L      #GRILL, A1
    MOVE.L      #0, D5
FIND_EMPTY
    CMP.B       #$FF, (A1)
    BEQ         SET_AUTO_iANDj
    ADD         #1, A1
    ADD.B       #1, D5
    BRA         FIND_EMPTY
SET_AUTO_iANDj:
    MOVE.L      #3, D7
    DIVU        D7, D5 *(LINE=i=D5/3)
    MOVE.B      D5, CHOSEN_LINE
    SWAP        D5
    MOVE.B      D5, CHOSEN_COL *(COL=i=D5 MOD 3)
    JSR         GET_COOR
  
    
CONTINUE:     
    MOVE.B      PATTERN_TO_PLAY, (A1) *THE VALIDE INPUTS ARE CAPITAL X OR O
    JSR         ALALIGNE
    CMP.B       #88, PATTERN_TO_PLAY
    BNE         DRAWO
    MOVE.W      X1, D1
    MOVE.W      X2, D2
    MOVE.W      Y1, D3
    MOVE.W      Y2, D4     
    JSR         DRAWX
    BRA         CH_WIN
DRAWO:
    MOVE.W      X1, D1
    MOVE.W      X2, D2
    MOVE.W      Y1, D3
    MOVE.W      Y2, D4
    JSR         DRAW_ELLIPSE

CH_WIN:
****Q7: CHECK WIN********
    MOVE.L      #GRILL, A1
    JSR         CHECK_WIN_LINE
    CMP.B       #1, X_WIN
    BEQ         FINISH_X_WIN
    CMP.B       #1, O_WIN
    BEQ         FINISH_O_WIN
    
    JSR         CHECK_WIN_COL
    CMP.B       #1, X_WIN
    BEQ         FINISH_X_WIN
    CMP.B       #1, O_WIN
    BEQ         FINISH_O_WIN

    MOVE.B      #0, D0
    MOVE.B      #0, D1
    MOVE.B      CHOSEN_LINE,D0
    MOVE.B      CHOSEN_COL,D1
    CMP.B       D0,D1
    BEQ         CH_WIN_D1
    BRA         CHECK_D2
CH_WIN_D1:
    JSR         CHECK_WIN_DIAG1
    CMP.B       #1, X_WIN
    BEQ         FINISH_X_WIN
    CMP.B       #1, O_WIN
    BEQ         FINISH_O_WIN
    
CHECK_D2:    
    MOVE        #0, D1
    ADD.B       CHOSEN_LINE, D1
    ADD.B       CHOSEN_COL, D1
    CMP.B       #2, D1
    BEQ         CH_WIN_D2
    BRA         NOT_ON_DIAG
CH_WIN_D2:
    JSR         CHECK_WIN_DIAG2
    CMP.B       #1, X_WIN
    BEQ         FINISH_X_WIN
    CMP.B       #1, O_WIN
    BEQ         FINISH_O_WIN


NOT_ON_DIAG:
    ADD.B       #1, D6 *INCREMENT COUNTER
    CMP.B       #10, D6
    BLT         game_start


FINISH_DRAW:
    JSR         ALALIGNE    
    MOVE.L      #TIP6,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    MOVE.L      #TIP7,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    JMP         FINPRG
FINISH_X_WIN:
    JSR         ALALIGNE
    MOVE.L      #TIP4,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    MOVE.L      #TIP6,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    JMP         FINPRG
FINISH_O_WIN:
    JSR         ALALIGNE
    MOVE.L      #TIP5,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    MOVE.L      #TIP6,A0
    JSR         AFFCHAINE
    JSR         ALALIGNE
    JMP         FINPRG


    

    JMP         FINPRG
    INCLUDE     'BIBLIO_MACHINE.X68' 
    INCLUDE     'BIBGRAPH.X68'
***variables simples***
GRILL DS.B 9
CHOSEN_LINE DS.B 1
CHOSEN_COL DS.B 1
PLAYER_CHOIX DC.B 1
AUTO_CHOIX DC.B 1 
PATTERN_TO_PLAY DC.B 1
INVALID_INPUT DS.B 1
K DS.B  1
X1 DS.W 1
X2 DS.W 1
Y1 DS.W 1
Y2 DS.W 1
X_WIN DS.B  1
O_WIN DS.B  1

***sentences to print***
TIP0 DC.L 'Player 1: please choose your pattern',0
ERACE_LINE DC.L '                                ',0
TIP1 DC.L 'Choose the line to play in:',0
TIP2 DC.L 'Choose the colomn to play in:',0
TIP3 DC.L 'Choose your pattern to play: x or o',0
TIP4 DC.L 'X won the game',0
TIP5 DC.L 'O won the game',0
TIP6 DC.L 'The game is over',0
TIP7 DC.L 'There is no winner, it is a draw',0
TIP8 DC.L 'The case you chose is not available',0
TIP9 DC.L 'Please choose again.',0
TIP10 DC.L 'Your input is not valid',0

 

    END    $400     













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
