 r←BuildConfig fn
⍝Build a Configuration Object
 r←⎕NS''
 r.OWL←r.⎕NS''
 r.OWL.Voltage←230

 ⍝
 r.Charts←r.⎕NS''
 r.Charts.PowerMonthly←r.Charts.⎕NS''
 r.Charts.PowerMonthly.BarWidth←0.2
 r.Charts.PowerMonthly.BarOffset←0.3
