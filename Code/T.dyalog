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

:EndNamespace
