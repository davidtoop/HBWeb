 page_index section;md;now;solarday;solarmon;tempday;tempmon
 now←⎕TS
 md←section.Add _.div'' '.main-grid'
 solarday←'style="grid-column:4;grid-row:1;"'md.Add _.div
 solarday.Add Charts.solardaily now

 solarmon←'style="grid-column:4;grid-row:2;"'md.Add _.div
 solarmon.Add Charts.solarmonthly now

 tempday←'style="grid-column:2;grid-row:1;"'md.Add _.div
 tempday.Add Charts.tempdaily now

 tempmon←'style="grid-column:2;grid-row:2;"'md.Add _.div
 tempmon.Add Charts.tempmonthly now
