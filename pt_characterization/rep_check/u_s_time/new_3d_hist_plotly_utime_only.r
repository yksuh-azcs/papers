library(plotly)
INC1 <- list(
  x = c(0,0,0,0,0,0,0,0,0,0,0,0,0,0), 
  y = c(0,14,14,29,29,43,43,57,57,71,71,86,86,100),
  z = c(2,2,6,6,5,5,5,5,47,47,100,100,8,8),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC2 <- list(
  x = c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1), 
  y = c(0,10,10,20,20,30,30,40,40,50,50,60,60,70,70,80,80,90,90,100),
  z = c(1,1,5,5,4,4,4,4,3,3,6,6,15,15,100,100,23,23,1,1),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC4 <- list(
  x = c(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2), 
  y = c(0,10,10,20,20,30,30,40,40,50,50,60,60,70,70,80,80,90,90,100),
  z = c(0,0,12,12,23,23,12,12,7,7,9,9,7,7,62,62,100,100,44,44),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC8 <- list(
  x = c(4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4), 
  y = c(0,8,8,17,17, 25,25,  33,33,  42,42,  50,50,  58,58,  67,67,  75,75,  83,83,  92,92, 100),
  z = c(1,1, 4, 4, 36, 36, 57, 57, 57, 57, 23, 23, 13, 13, 20, 20, 57, 57, 100, 100, 74, 74, 6, 6),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC16 <- list(
  x = c(5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5), 
  y = c(0,8,8,15,15,23,23,31,31,38,38,46,46,54,54,62,62,69,69,77,77,85,85,92,92,100), 
  z = c(0,0,3,3,17,17,49,49,100,100,61,61,15,15,5,5,8,8,15,15,15,15,8,8,1,1),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC32 <- list(
  x = c(6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6), 
  y = c(0,7,7,13,13,20,20,27,27,33,33,40,40,47,47,53,53,60,60,67,67,73,73,80,80,87,87,93,93,100), 
  z = c(7,7,39,39,83,83,100,100,54,54,22,22,17,17,24,24,38,38,48,48,13,13,2,2,0,0,0,0,0,0),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC64 <- list(
  x = c(7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7), 
  y = c(0,6,6,12,12,18,18,24,24,29,29,35,35,41,41,47,47,53,53,59,59,65,65,71,71,76,76,82,82,88,88,94,94,100),
  z = c(1,1,0,0,1,1,4,4,18,18,37,37,51,51,47,47,38,38,41,41,50,50,76,76,100,100,82,82,49,49,14,14,5,5), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC128 <- list(
  x = c(8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8), 
  y = c(0,10,10,20,20,30,30,40,40,50,50,60,60,70,70,80,80,90,90,100),
  z = c(21,21,51,51,100,100,72,72,54,54,47,47,37,37,8,8,1,1,1,1), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC256 <- list(
  x = c(9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9), 
  y = c(0,6,6,12,12,18,18,24,24,29,29,35,35,41,41,47,47,53,53,59,59,65,65,71,71,76,76,82,82,88,88,94,94,100), 
  z = c(2,2,9,9,18,18,29,29,34,34,93,93,84,84,100,100,73,73,50,50,30,30, 7,7,2,2,2,2,0,0,0,0,2,2),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC512 <- list(
  x = c(10,10,10,10,10,10,10,10,10,10,10,10), 
  y = c(0,17,17,33,33,50,50,67,67,83,83,100), 
  z = c(8,8,52,52,100,100,67,67,13,13,3,3), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC1024 <- list(
  x = c(11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11), 
  y = c(0,12,12,25,25,38,38,50,50,62,62,75,75,88,88,100), 
  z = c(3,3,13,13,69,69, 88,88,100, 100, 40, 40,18,18,1,1), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC2048 <- list(
  x = c(12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12), 
  y = c(0,8,8,17,17,25,25,33,33,42,42,50,50,58,58,67,67,75,75,83,83,92,92,100), 
  z = c(1,1,1,1,22,22,31,31,53,53,82,82,100,100,49,49,32,32,12,12,3,3,1,1), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC4096 <- list(
  x = c(13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13), 
  y = c(0,8,8,15,15,23,23,31,31,38,38,46,46,54,54,62,62,69,69,77,77,85,85,92,92,100), 
  z = c(2,2,0,0,18,18,20,20,31,31,73,73,59,59,100,100,82,82,76,76,61,61,51,51,12,12), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
data <- list(INC1, INC2, INC4, INC8, INC16, INC32, INC64,INC128,INC256,INC512,INC1024,INC2048,INC4096)
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
p <- add_trace(p, x=INC8$x, y=INC8$y, z=INC8$z, line=INC8$line, mode=INC8$mode, type=INC8$type, name = 'INC8')
p <- add_trace(p, x=INC16$x, y=INC16$y, z=INC16$z, line=INC16$line, mode=INC16$mode, type=INC16$type, name = 'INC16')
p <- add_trace(p, x=INC32$x, y=INC32$y, z=INC32$z, line=INC32$line, mode=INC32$mode, type=INC32$type, name = 'INC32')
p <- add_trace(p, x=INC64$x, y=INC64$y, z=INC64$z, line=INC64$line, mode=INC64$mode, type=INC64$type, name = 'INC64')
p <- add_trace(p, x=INC128$x, y=INC128$y, z=INC128$z, line=INC128$line, mode=INC128$mode, type=INC128$type, name = 'INC128')
p <- add_trace(p, x=INC256$x, y=INC256$y, z=INC256$z, line=INC256$line, mode=INC256$mode, type=INC256$type, name = 'INC256')
p <- add_trace(p, x=INC512$x, y=INC512$y, z=INC512$z, line=INC512$line, mode=INC512$mode, type=INC512$type, name = 'INC512')
p <- add_trace(p, x=INC1024$x, y=INC1024$y, z=INC1024$z, line=INC1024$line, mode=INC1024$mode, type=INC1024$type, name = 'INC1024')
p <- add_trace(p, x=INC2048$x, y=INC2048$y, z=INC2048$z, line=INC2048$line, mode=INC2048$mode, type=INC2048$type, name = 'INC2048')
p <- add_trace(p, x=INC4096$x, y=INC4096$y, z=INC4096$z, line=INC4096$line, mode=INC4096$mode, type=INC4096$type, name = 'INC4096')
p <- layout(p, autosize=layout$autosize, title=layout$title, scene = list(
      xaxis = list(title = "Log(TL)"),
      yaxis = list(title = "Norm. PT"),
      zaxis = list(title = "RF")
    ))
Sys.setenv("plotly_username"="yksuh")
Sys.setenv("plotly_api_key"="4jaag7lYwdndqs5J5CLK")
api_create(p, filename = "3dplot_utime_only")
dev.off()

