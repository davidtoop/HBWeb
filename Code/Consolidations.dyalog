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
        r←wh
      ∇       
    :EndNamespace

:EndNamespace
