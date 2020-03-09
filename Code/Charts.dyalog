:Namespace Charts
⍝

    ∇ sp←formatchart sp
      sp.SetNewline'⋄'
      sp.FrameStyle←+/Causeway.FrameStyles.(Boxed Rounded)
      sp.SetBackground ##.Theme.primary Causeway.FillStyle.GradientBottom
      sp.DefineFont'AS' 'Verdana,Aria,Sans'
      sp.SetHeadingFont'AS' 20 System.Drawing.FontStyle.Bold ##.Theme.dark
      sp.SetLabelFont 'AS' 10 System.Drawing.FontStyle.Regular ##.Theme.dark
    ∇
    ∇ sp←formattemp sp
        sp.YIntercept←0
        sp.MissingValue←¯1000
        sp.SetYRange ¯20 50
    ∇

    ∇ sp←formatpower sp
        ⍝sp.DataStyle←Causeway.DataStyles.Relative
        sp.YCaption←'Wh'
        sp.XCaption←'Time'
        sp.SetPenWidths⊂0.3 0.3 4
        sp.SetLineStyles⊂Causeway.LineStyle.(Solid Solid Solid)
        sp.SetColors ⊂System.Drawing.Color.(Blue Red Green)
        sp.XAxisStyle←Causeway.XAxisStyles.Time
    ∇


    Economy7Times←{
        d←##.T.days 3↑⍵
        ls←{(##.T.days ⍵)-(7≠wd)×wd←##.T.WeekDay ⍵}
        (sd ed)←ls¨ (1↑⍵),¨(3 31) (9 30)
        (d≥sd)∧(d<ed):##.T.days ↑(⊂3↑⍵),¨(2 30 0 0) (9 30 0 0)
        ##.T.days ↑(⊂3↑⍵),¨(1 30 0 0)(8 30 0 0)
    }

    XAxisTimes←{⍺←⎕TS ⋄ ¯1+#.days(3↑⍺)(,⍤1)⍉100 100⊤⍵}

    NADailyMessage←{
      ⍺←''
      r←'NO DATA AVAILABLE ',(0≠⍴⍺)/'FOR ',⍺,' '
      r,←'ON ',(##.T.ISODate ⍵)
      r
    }

    NAMonthlyMessage←{
        ⍺←''
        r←'NO DATA AVAILABLE ',(0≠≢⍺)/'FOR ',⍺,' '
        r,←'ON ',(##.T.FullMonthNames[⍵[2]]),' ',⍕⍵[1]
        r
    }

    ∇ svg←powerdaily ts;Causeway;System;dat;pwr;sp;tk;x;y1;y2;y3
        pwr←'POWER' #.DB.GetDay ts
        :if 0∊⍴pwr
            svg←'POWER' NADailyMessage ts
            →0
        :endif
        dat←#.Consolidations.Power.ToPower pwr
        tk←##.DB.TimeKeys 15
        dat←0⌈(dat⍪0)[pwr[;1]⍳tk;]
        xx←x←ts XAxisTimes tk
        y1←dat[;1]
        y2←dat[;3]
        y3←dat[;2]
        ⍝#.yy←y1←⊂↓[1](dat[;,1]-dat[;,3]),dat[;,3]
        ##.InitCauseway ⍬
        sp←⎕NEW Causeway.SharpPlot
        sp.Heading←'Power Consumption ',##.T.ISODate ts
        sp←formatpower formatchart sp
        sp.SetXDatumLines ⊂¯1+Economy7Times ts
        sp.SetDatumLineStyle (System.Drawing.Color.Black) (System.Drawing.LineStyle.Solid) (1)
        sp.SetKeyText ⊂'Total' 'Car' 'Solar'
        sp.LineGraphStyle←Causeway.LineGraphStyles.SurfaceShading
        sp.DrawLineGraph y1 x
        sp.DrawLineGraph y2 x
        sp.LineGraphStyle←Causeway.LineGraphStyles.XYPlot
        sp.DrawLineGraph y3 x
        svg←sp.RenderSvg Causeway.SvgMode.FitWidth 96 Causeway.PageMode.Vertical
    ∇
    ∇ svg←powermonthly ts;Causeway;System;dat;dy;pwr;sp;tk;x;y1;y2;y3
        (dy pwr)←'POWER' #.DB.Month ts
        :if 0∊⍴pwr
            svg←'POWER' NADailyMessage ts
            →0
        :endif
    ⍝   dat←#.Consolidations.Power.ToPower ¨pwr
    ⍝     tk←##.DB.TimeKeys 15
    ⍝     dat←0⌈(dat⍪0)[pwr[;1]⍳tk;]
    ⍝     x←ts XAxisTimes tk
    ⍝     y1←dat[;1]
    ⍝     y2←dat[;3]
    ⍝     y3←dat[;2]
    ⍝     ⍝#.yy←y1←⊂↓[1](dat[;,1]-dat[;,3]),dat[;,3]
    ⍝     ##.InitCauseway ⍬
    ⍝     sp←⎕NEW Causeway.SharpPlot
    ⍝     sp.Heading←'Power Consumption ',##.T.ISODate ts
    ⍝     sp←formatpower formatchart sp
    ⍝     ⍝sp.SetXLabels tk
    ⍝     sp.SetKeyText ⊂'Total' 'Car' 'Solar'
    ⍝     sp.LineGraphStyle←Causeway.LineGraphStyles.SurfaceShading
    ⍝     sp.DrawLineGraph y1 x
    ⍝     sp.DrawLineGraph y2 x
    ⍝     sp.LineGraphStyle←Causeway.LineGraphStyles.XYPlot
    ⍝     sp.DrawLineGraph y3 x
    ⍝     svg←sp.RenderSvg Causeway.SvgMode.FitWidth 96 Causeway.PageMode.Vertical
∇
    ∇ svg←solarmonthly ts;Causeway;System;data;daydata;dy;md;sp;x;y;⎕USING
      ⍝Plot the month - given by the  second element of ts
      (dy data)←'SOLAR'#.DB.GetMonth ts
      :If 0∊⍴data
          svg←'NO DATA AVAILABLE FOR ',(##.T.FullMonthNames[ts[2]]),' ',⍕ts[1]
          →0
      :EndIf
      (x y)←↓[1]↑,¨##.solar.ConsolInverters¨dy,¨{0 1↓⍵}¨data
      x←3⌷10000 100 100⊤x
      md←⍳##.T.DaysInMonth ts
      y←(y,0)[x⍳md]
      x←md
     
      ##.InitCauseway ⍬
      sp←⎕NEW Causeway.SharpPlot
      sp.Heading←'Solar ',(ts[2]⊃##.T.FullMonthNames),' ',,⍕ts[1]
      sp←formatchart sp
      sp.YCaption←'Wh'
      sp.XCaption←'Date'
      sp.SetXLabels x
      sp.DrawBarChart y
      svg←sp.RenderSvg Causeway.SvgMode.FitWidth 96 Causeway.PageMode.Vertical
    ∇
    ∇ svg←solardaily ts;Causeway;System;back;data;fill;mask;prev;raw;shadow;sp;tk;x;xmax;yd;yy;⎕USING
     
      raw←'SOLAR'##.DB.GetDay ts
      prev←'SOLAR'##.DB.GetDay ##.date(##.days ⎕TS)-1
      tk←##.DB.AllTimeKeys
      :If (0∊⍴raw)∧0∊⍴prev
          svg←'NO DATA AVAILABLE'
          →0
      :ElseIf 0∊⍴raw
          data←#.solar.ConsolInverters prev
          yy←0⌈(data[;2],0)[data[;1]⍳tk]
          yd←(⍴yy)⍴0
      :ElseIf 0∊⍴prev
          data←#.solar.ConsolInverters raw
          yd←0⌈(data[;2],0)[data[;1]⍳tk]
          yy←(⍴yd)⍴0
      :Else
          data←#.solar.ConsolInverters raw
          yd←0⌈(data[;2],0)[data[;1]⍳tk]
          data←#.solar.ConsolInverters prev
          yy←0⌈(data[;2],0)[data[;1]⍳tk]
      :EndIf
     
      x←⍕¨tk
 ⍝
      ##.InitCauseway ⍬  ⍝ Initialise the Causeway and System namespace in this scope (notice we have localised them, along with ⎕USING)
      sp←⎕NEW Causeway.SharpPlot  ⍝ ColdStart
⍝     
      sp←formatchart sp
      sp.Heading←'Solar ',(##.T.ISODate ts)
      sp.YCaption←'Wh'
      sp.XCaption←'Time'
     
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
     
     
    ∇

    ∇ svg←tempmonthly ts;Causeway;System;avgminmax;data;dmax;dmin;dy;md;pd;sp;x;y;⎕USING
      ⍝Plot the month - given by the  second element of ts
      (dy data)←'OUTTEMP'#.DB.GetMonth ts
      :If 0∊⍴data
          svg←'NO DATA AVAILABLE FOR ',(##.T.FullMonthNames[ts[2]]),' ',⍕ts[1]
          →0
      :EndIf
      avgminmax←{(0.1×⌊0.5+÷/+⌿(⊂3 2)⌷[2]⍵),.1×(⌊⌿5⌷[2]⍵),⌈⌿6⌷[2]⍵}
      y←↑avgminmax¨data

      md←⍳##.T.DaysInMonth ts
      x←,3⌷10000 100 100⊤dy
      y←(y⍪3/¯1000)[x⍳md;]
      x←md
     
      ##.InitCauseway ⍬
      sp←⎕NEW Causeway.SharpPlot
      sp.Heading←'Outdoor Temperature ',(ts[2]⊃##.T.ShortMonthNames),' ',,⍕ts[1]
      sp←formattemp formatchart sp
      sp.YCaption←'Temp °C'
      sp.XCaption←'Date'
      sp.SetXLabels x
      sp.LineGraphStyle←Causeway.LineGraphStyles.(Markers+HaloMarkers+GridLines)
      sp.MissingValue←¯1000

      sp.DrawLineGraph ⊂y[;1]

      sp.MinMaxChartStyle←Causeway.MinMaxChartStyles.(ErrorBars+ValueTags)
      sp.ValueTagFormat←'##.0'
      
      (dmin dmax)←↓[1]y[;3 2]
      sp.DrawMinMaxChart dmin dmax x

      svg←sp.RenderSvg Causeway.SvgMode.FitWidth 96 Causeway.PageMode.Vertical
    ∇
    ∇ svg←tempdaily ts;Causeway;System;algn;avgt;back;ckey;daiy;data;fill;mask;prev;shadow;sp;td;tk;ty;x;xmax;yd;yy;⎕USING
     
      daiy←'OUTTEMP'##.DB.GetDay ts
      prev←'OUTTEMP'##.DB.GetDay ##.date(##.days ⎕TS)-1
      avgt←{⍵[;,1],.01×⌊.5+10×÷/⍵[;3 2]}
      algn←{(⍵[;2],¯1000)[⍵[;1]⍳⍺]}
      ckey←{z←{⍵+{(15≠⍵)×⍵}15-15|⍵}(x←100 100⊤⍵)[2;] ⋄ z[(z=60)/⍳⍴z]←100 ⋄ z+100×x[1;]}
      daiy[;1]←ckey daiy[;1] ⋄ prev[;1]←ckey prev[;1]
      tk←##.DB.TimeKeys 15
      :If (0∊⍴daiy)∧0∊⍴prev
          svg←'NO DATA AVAILABLE'
          →0
      :Endif

      :if ~0∊⍴daiy
        td←tk algn avgt daiy
      :else
        td←(⍴tk)⍴0
      :endif
      
      :if ~0∊⍴prev
        ty←tk algn avgt prev
      :Else
        ty←(⍴tk)⍴0
      :endif
      x←⍕¨tk
 ⍝
      ##.InitCauseway ⍬  ⍝ Initialise the Causeway and System namespace in this scope (notice we have localised them, along with ⎕USING)
      sp←⎕NEW Causeway.SharpPlot  ⍝ ColdStart
⍝     
      sp←formattemp formatchart sp
      sp.Heading←'Outdoor Temperature ',(##.T.ISODate ts)
      sp.YCaption←'Temp °C'
      sp.XCaption←'Time'
      mask←{(∨\⍵)∧⌽∨\⌽⍵}(0≠ty)∨0≠td
      td←mask/td
      ty←mask/ty
      x←mask/x
      sp.SetXLabels x
     
      sp.SetPenWidths⊂1.3 1.3
      sp.DrawLineGraph td
      sp.DrawLineGraph ty
      svg←sp.RenderSvg Causeway.SvgMode.FitWidth 96 Causeway.PageMode.Vertical
     
     
    ∇

:EndNamespace
