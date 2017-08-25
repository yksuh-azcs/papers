library(plotly)
INC1 <- list(
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
INC2 <- list(
  x = c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1), 
  y = c(0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10), 
  z = c(0.004,0.004,0.031,0.031,0.025,0.025,0.023,0.023,0.022,0.022,0.034,0.034,0.065,0.065,0.636,0.636,0.153,0.153,0.007,0.007),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC4 <- list(
  x = c(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2), 
  y = c(0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10), 
  z = c(0.038,0.038,0.087,0.087,0.042,0.042,0.027,0.027,0.033,0.033,0.023,0.023,0.212,0.212,0.369,0.369,0.167,0.167,0.002,0.002),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
data <- list(INC1, INC2, INC4)
layout <- list(
  autosize = FALSE, 
  height = 600, 
  title = "3d Stacked Histogram", 
  width = 600
)
p <- plot_ly()
p <- add_trace(p, x=INC1$x, y=INC1$y, z=INC1$z, line=INC1$line, mode=INC1$mode, type=INC1$type, name = 'INC1')
p <- add_trace(p, x=INC2$x, y=INC2$y, z=INC2$z, line=INC2$line, mode=INC2$mode, type=INC2$type, name = 'INC2')
p <- add_trace(p, x=INC4$x, y=INC4$y, z=INC4$z, line=INC4$line, mode=INC4$mode, type=INC4$type, name = 'INC4')
p <- layout(p, autosize=layout$autosize, title=layout$title, scene = list(
      xaxis = list(title = "Log(TL)"),
      yaxis = list(title = "Norm. PT"),
      zaxis = list(title = "RF")
    ))
Sys.setenv("plotly_username"="yksuh")
Sys.setenv("plotly_api_key"="4jaag7lYwdndqs5J5CLK")
api_create(p, filename = "3dplot")
dev.off()

library(plotly)
trace1 <- list(
  x = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), 
  y = c(1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5), 
  z = c(22, 20, 19, 21, 22, 21, 8, 9, 9, 9, 8, 7, 5, 6, 5, 4, 3), 
  line = list(
    color = "Purpule", 
    width = 3
  ), 
  mode = "lines", 
  type = "scatter3d"
)
trace2 <- list(
  x = c(0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5), 
  y = c(1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5), 
  z = c(22, 20, 19, 21, 22, 21, 8, 9, 9, 9, 8, 7, 5, 6, 5, 4, 3), 
  line = list(
    color = "Red", 
    width = 3
  ), 
  mode = "lines", 
  type = "scatter3d"
)
trace3 <- list(
  x = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1), 
  y = c(1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5), 
  z = c(22, 20, 19, 21, 22, 21, 8, 9, 9, 9, 8, 7, 5, 6, 5, 4, 3), 
  line = list(
    color = "Gray", 
    width = 3
  ), 
  mode = "lines", 
  type = "scatter3d"
)
trace4 <- list(
  x = c(1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5), 
  y = c(1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5), 
  z = c(22, 20, 19, 21, 22, 21, 8, 9, 9, 9, 8, 7, 5, 6, 5, 4, 3), 
  line = list(
    color = "Green", 
    width = 3
  ), 
  mode = "lines", 
  type = "scatter3d"
)
data <- list(trace1, trace2, trace3, trace4)
layout <- list(
  autosize = FALSE, 
  height = 600, 
  title = "3d Stacked Histogram", 
  width = 600
)
p <- plot_ly()
p <- add_trace(p, x=trace1$x, y=trace1$y, z=trace1$z, line=trace1$line, mode=trace1$mode, type=trace1$type, name = 'INC1')
p <- add_trace(p, x=trace2$x, y=trace2$y, z=trace2$z, line=trace2$line, mode=trace2$mode, type=trace2$type, name = 'INC2')
p <- add_trace(p, x=trace3$x, y=trace3$y, z=trace3$z, line=trace3$line, mode=trace3$mode, type=trace3$type, name = 'INC4')
p <- add_trace(p, x=trace4$x, y=trace4$y, z=trace4$z, line=trace4$line, mode=trace4$mode, type=trace4$type, name = 'INC1')
p <- layout(p, autosize=layout$autosize, height=layout$height, title=layout$title, width=layout$width)
