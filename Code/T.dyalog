:Namespace T
    FullMonthNames←'January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December'
    ShortMonthNames←'Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec'

    ⍝Time Functions
    ∇ r←DaysInMonth ym;d
      d←31 28 31 30 31 30 31 31 30 31 30 31
      ym←2↑ym
      :If (0∊ym)∨(ym[2]>⍴d)∨ym[2]<1
          →r←0
      :EndIf
      d[2]+←(0=4|ym[1])∧0≠400|ym[1]
      r←d[ym[2]]
    ∇

    ∇ r←ISODate ts
      r←,'I4,<->,ZI2,<->,ZI2'⎕FMT 1 3⍴3↑ts
    ∇

    ⍝Day of the week 1=Monday ... 7=Sunday
    WeekDay←{7@(0∘=)7|⌊days ⍵}


    Economy7Times←{
        d←days 3↑⍵
        ls←{(days ⍵)-(7≠wd)×wd←WeekDay ⍵}
        (sd ed)←ls¨ (1↑⍵),¨(3 31) (9 30)
        (d≥sd)∧(d<ed):days ↑(⊂3↑⍵),¨(1 30 0 0) (8 30 0 0)
        days ↑(⊂3↑⍵),¨(0 30 0 0)(7 30 0 0)
    }

    days←{                                   ⍝ Days since 1899-12-31 (Meeus).
     ⍺←17520902                              ⍝ start of Gregorian calendar.
     yy mm dd h m s ms←7↑⊂[⍳¯1+⍴⍴⍵]⍵         ⍝ ⎕ts-style 7-item date-time.
     D←dd+(0 60 60 1000⊥↑h m s ms)÷86400000  ⍝ day with fractional part.
     Y M←yy mm+¯1 12×⊂mm≤2                   ⍝ Jan, Feb → month 13 14.
     A←⌊Y÷100                                ⍝ century number.
     B←(⍺<0 100 100⊥↑yy mm dd)×(2-A)+⌊A÷4    ⍝ Gregorian calendar correction.
     ¯2416544+D+B+⊃+/⌊365.25 30.6×Y M+4716 1 ⍝ (fractional) days.
 }

    date←{⎕ML←1                          ⍝ ⎕TS format from day number (Meeus).
     ⍺←¯53799                            ⍝ start of Gregorian calendar (GB).
     qr←{⊂⍤¯1⊢(0,⍺)⊤⍵}                   ⍝ quotient and remainder.
     Z F←1 qr ⍵+2415020                  ⍝
     a←⌊(Z-1867216.25)÷36524.25          ⍝
     A←Z+(Z≥⍺+2415021)×1+a-⌊a÷4          ⍝
     B←A+1524                            ⍝
     C←⌊(B-122.1)÷365.25                 ⍝
     D←⌊C×365.25                         ⍝
     E←⌊(B-D)÷30.6001                    ⍝
     dd df←1 qr(B-D)+F-⌊30.6001×E        ⍝
     mm←E-1+12×E≥14                      ⍝
     yyyy←C-4715+mm>2                    ⍝
     part←60 60 1000 qr⌊0.5+df×86400000  ⍝
     ↑[⎕IO-0.5]yyyy mm dd,part           ⍝
 }

:EndNamespace
