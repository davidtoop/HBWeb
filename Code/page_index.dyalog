 page_index section;md;cell;chart
 md←section.Add _.div'' '.main-grid'
 chart←'style="grid-column:4;grid-row:1;"'md.Add _.div
 chart.Add chart_daily ⎕TS
