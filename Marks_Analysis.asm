; Marks_Analysis.asm
;
; Author:                Isha Gadani, Guntas Singh Chugh, Ayan Satani
; Student Number:        041085940, 041091309, 041089567
; Date:                  17 November 2023
;
; Purpose:               Assign grades to a specific range of marks and tally the occurrences

EIGHTY   equ     80      ; Grades For 80+
SEVENTY  equ     70      ; Grades For 70+
SIXTY    equ     60      ; Grades For 60+
FIFTY    equ     50      ; Grades For 50+

        org     $1000   ; Origin for Data
Marks                   ; Starting address of Marks
#include Marks.txt      ; Include the text file in the same folder
EndMarks                ; Ending address of Marks
                        ; Expected Result: A A A A F D F B D C B D C F A F

        org     $1020           ; Starting address of grade storage
Storage ds      EndMarks-Marks  ; Allocate memory for the grade storage
CounterA rmb    1               ; Counter for Grade A
CounterB rmb    1               ; Counter for Grade B
CounterC rmb    1               ; Counter for Grade C
CounterD rmb    1               ; Counter for Grade D
CounterF rmb    1               ; Counter for Grade F

        org     $2000           ; Starting address of program
        lds     #$2000
        ldx     #Marks          ; Pointer to the start of the array
        ldy     #Storage        ; Pointer to the allocated memory space
        clr     CounterA        ; Initialize counters to zero
        clr     CounterB
        clr     CounterC
        clr     CounterD
        clr     CounterF

Loop    ldaa    1,x+            ; Load a with the first element in the array, with post increment
Check80 cmpa    #EIGHTY         ; Compare a to 80
        bhs     GradeA          ; If higher, assign A
Check70 cmpa    #SEVENTY        ; Compare a to 70
        bhs     GradeB          ; If higher, assign B
Check60 cmpa    #SIXTY          ; Compare a to 60
        bhs     GradeC          ; If higher, assign C
Fgrade  cmpa    #FIFTY          ; Compare a to 50
        bhs     GradeD          ; If higher, assign D
        bra     GradeF          ; If Lower, assign F

GradeA  ldab    #'A'             ; assigning A
        inc     CounterA        ; Increment counter for Grade A
        bra     Next            ; Go to Label Next
GradeB  ldab    #'B'             ; assigning B
        inc     CounterB        ; Increment counter for Grade B
        bra     Next            ; Go to Label Next
GradeC  ldab    #'C'             ; assigning C
        inc     CounterC        ; Increment counter for Grade C
        bra     Next            ; Go to Label Next
GradeD  ldab    #'D'             ; assigning D
        inc     CounterD        ; Increment counter for Grade D
        bra     Next            ; Go to Label Next
GradeF  ldab    #'F'             ; assigning F
        inc     CounterF        ; Increment counter for Grade F

Next    stab    1,y+            ; Store the letter grade to the allocated memory
        cpx     #EndMarks       ; compare x, if the end of array
        bne     Loop            ; No, loop again

        ; Store the counters in memory
        staa    CounterA, A  ; Store the count for Grade A at address $1030
        staa    CounterB, B  ; Store the count for Grade B at address $1031
        staa    CounterC, C  ; Store the count for Grade C at address $1032
        staa    CounterD, D  ; Store the count for Grade D at address $1033
        staa    CounterF, F  ; Store the count for Grade F at address $1034

        swi                     ; Yes
        end