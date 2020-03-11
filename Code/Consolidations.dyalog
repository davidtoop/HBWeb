:Namespace Consolidations
    ⍝Consilidate various sensor data for reporting and charting
    :Namespace Power
      ∇r←ToPower dat;avgi;dur;pwr;volts;wh
        ⍝Calculate duration in seconds
        ⍝dur←.001×24 60 1000⊥⍉0 4↓date(days dat[;8+⍳7])-days dat[;1+⍳7]
        avgi←((dat[;16])(÷⍨⍤0 1)dat[;17 19 21]) ⍝Average current
        volts←#.Config.OWL.Voltage
        pwr←(volts×0.1)×avgi
        wh←0.25×pwr
        r←0⌈wh
      ∇
      
      ∇ r←days DaysPower dat;daypwr
        daypwr←days DayPower¨ dat
        r←↑daypwr
      ∇

      ∇ r←day DayPower dat;dayts;dp;dypwr;e7pwr;ed;m;pwr;sd;solarcar;ts
          :if 0∊⍴dat
            r←⍬
            →0
          :endif

          pwr←ToPower dat
          dayts←10000 100 100⊤day
          ts←#.T.days dayts(,⍤1)⍉100 100⊤dat[;1]
          (sd ed)←#.T.Economy7Times dayts
          m←(ts≥sd)∧ts<ed
          e7pwr←+/m/pwr[;1]
          dypwr←+/(~m)/pwr[;1]
          solarcar←+⌿pwr[;2 3]
          r←(#.T.days dayts),e7pwr,dypwr,solarcar
      ∇
    :EndNamespace

:EndNamespace
