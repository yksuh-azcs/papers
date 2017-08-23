library(plotly)
trace1 <- list(
  x = c(0,0,0,0,0,0,0,0,0,0,0,0,0,0), 
  y = c(0,1,1,2,2,3,3,4,4,5,5,6,6,7), 
  z = c(0.009,0.009,0.035,0.035,0.026,0.026,0.028,0.028,0.250,0.250,0.603,0.603,0.049,0.049), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
#data <- list(trace1, trace2, trace3)
data <- list(trace1)
layout <- list(
  autosize = FALSE, 
  height = 600, 
  title = "3d Stacked Histogram", 
  width = 600
)
p <- plot_ly()
p <- add_trace(p, x=trace1$x, y=trace1$y, z=trace1$z, line=trace1$line, mode=trace1$mode, type=trace1$type)
p <- add_trace(p, x=trace2$x, y=trace2$y, z=trace2$z, line=trace2$line, mode=trace2$mode, type=trace2$type)
p <- add_trace(p, x=trace3$x, y=trace3$y, z=trace3$z, line=trace3$line, mode=trace3$mode, type=trace3$type)
p <- layout(p, autosize=layout$autosize, title=layout$title)
