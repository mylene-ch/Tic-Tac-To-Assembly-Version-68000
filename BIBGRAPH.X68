DRAW_LINE:
    MOVE #84,D0
    TRAP #15
    RTS
DRAW_ELLIPSE:
    MOVE #91,D0
    TRAP #15
    RTS
    
DRAWX:
    JSR         DRAW_LINE
    ADD         #60, D1
    ADD         #-60, D3
    JSR         DRAW_LINE
    RTS

SHOW_GRILL: *JSR SHOW_GRILL
    *OUTSIDE LINES
    MOVE        #300, D1
    MOVE        #100, D2
    MOVE        #300, D3
    MOVE        #400, D4
    JSR         DRAW_LINE
    MOVE        #300, D1
    MOVE        #100, D2
    MOVE        #600, D3
    MOVE        #100, D4
    JSR         DRAW_LINE
    MOVE        #600, D1
    MOVE        #100, D2
    MOVE        #600, D3
    MOVE        #400, D4
    JSR         DRAW_LINE
    MOVE        #600, D1
    MOVE        #400, D2
    MOVE        #300, D3
    MOVE        #400, D4
    JSR         DRAW_LINE
    
    *INNER LINES
    MOVE        #400, D1
    MOVE        #100, D2
    MOVE        #400, D3
    MOVE        #400, D4
    JSR         DRAW_LINE
    MOVE        #500, D1
    MOVE        #100, D2
    MOVE        #500, D3
    MOVE        #400, D4
    JSR         DRAW_LINE
    MOVE        #300, D1
    MOVE        #200, D2
    MOVE        #600, D3
    MOVE        #200, D4
    JSR         DRAW_LINE
    MOVE        #300, D1
    MOVE        #300, D2
    MOVE        #600, D3
    MOVE        #300, D4
    JSR         DRAW_LINE
    RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
