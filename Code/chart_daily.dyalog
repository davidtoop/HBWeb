 {svg}←chart_daily ts;raw;prev;data;mask;xmax;yd;yy;x;sp;Causeway;System;⎕USING;fill;back;svg;shadow

 raw←'SOLAR'DB.GetDay ts
 prev←'SOLAR'DB.GetDay date(days ⎕TS)-1
 :If (0∊⍴raw)∧0∊⍴prev
     svg←'NO DATA AVAILABLE'
     →0
 :ElseIf 0∊⍴raw
     data←#.solar.ConsolInverters prev
     yy←0⌈(data[;2],0)[data[;1]⍳DB.AllTimeKeys]
     yd←(⍴yy)⍴0
 :ElseIf 0∊⍴prev
     data←#.solar.ConsolInverters raw
     yd←0⌈(data[;2],0)[data[;1]⍳DB.AllTimeKeys]
     yy←(⍴yd)⍴0
 :Else
     data←#.solar.ConsolInverters raw
     yd←0⌈(data[;2],0)[data[;1]⍳DB.AllTimeKeys]
     data←#.solar.ConsolInverters prev
     yy←0⌈(data[;2],0)[data[;1]⍳DB.AllTimeKeys]
 :EndIf

 x←⍕¨DB.AllTimeKeys
 ⍝
 ⍝
 ##.InitCauseway ⍬  ⍝ Initialise the Causeway and System namespace in this scope (notice we have localised them, along with ⎕USING)

 sp←⎕NEW Causeway.SharpPlot  ⍝ ColdStart

 sp.SetNewline'⋄'
 sp.Heading←'Today'

 sp.FrameStyle←Causeway.FrameStyles.Boxed
 sp.SetBackground System.Drawing.Color.Moccasin Causeway.FillStyle.GradientBottom
 ⍝sp.BarChartStyle←Causeway.BarChartStyles.(TicksBetween+ValueTags+ForceZero+StackedBars)
 ⍝sp.YAxisStyle←Causeway.YAxisStyles.(MiddleLabels+GridLines+CenteredCaption)
 ⍝sp.SetXTickMarks(20 4)
 ⍝sp.ValueTagStyle←Causeway.ValueTagStyles.(Middle+SectorValues+ShowAllTags)  ⍝ remove ShowAllTags to hide tags larger than bar
 ⍝sp.SetValueFont'Arial' 8 System.Drawing.FontStyle.Bold System.Drawing.Color.Navy
 ⍝sp.ValueTagFormat←'###0⋄Units'
 ⍝sp.Gap←0
 ⍝sp.GroupGap←0.5
 ⍝sp.MarginLeft←64
 ⍝sp.SetColors⊂System.Drawing.Color.(Green Red)
 ⍝sp.SetFillStyles Causeway.FillStyle.Halftone
 sp.YCaption←'Wh'
 sp.XCaption←'Time'

 ⍝sp.SetYLabels⊂'Project⋄'∘,∘⍕¨6437+⍳⍴1⊃vdata
 ⍝sp.SetKeyText⊂'Last Year' 'This Year'

 mask←{(∨\⍵)∧⌽∨\⌽⍵}(0≠yy)∨0≠yd
 yd←mask/yd
 yy←mask/yy
 x←mask/x
 sp.SetXLabels x

 sp.SetPenWidths⊂1.3 1.3
 sp.SetYRange 0,(⌈/yd,yy)
 sp.DrawLineGraph yd
 sp.DrawLineGraph yy
 svg←sp.RenderSvg Causeway.SvgMode.FitWidth 96 Causeway.PageMode.Vertical

