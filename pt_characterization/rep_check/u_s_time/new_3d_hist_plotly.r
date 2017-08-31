library(plotly)
INC1 <- list(
  x = c(0,0,0,0,0,0,0,0,0,0,0,0,0,0), 
  #y = c(0,1,1,2,2,3,3,4,4,5,5,6,6,7), 
  y = c(0,14,14,29,29,43,43,57,57,71,71,86,86,100),
  #z = c(0.009,0.009,0.035,0.035,0.026,0.026,0.028,0.028,0.250,0.250,0.603,0.603,0.049,0.049), 
  z = c(1,1,6,6,4,4,5,5,41,41,100,100,8,8), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC2 <- list(
  x = c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1), 
  #y = c(0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10), 
  y = c(0,10,10,20,20,30,30,40,40,50,50,60,60,70,70,80,80,90,90,100),
  #z = c(0.004,0.004,0.031,0.031,0.025,0.025,0.023,0.023,0.022,0.022,0.034,0.034,0.065,0.065,0.636,0.636,0.153,0.153,0.007,0.007),
  z = c(1,1,5,5,4,4,4,4,3,3,5,5,10,10,100,100,24,24,1,1),
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
#  z = c(0.038,0.038,0.087,0.087,0.042,0.042,0.027,0.027,0.033,0.033,0.023,0.023,0.212,0.212,0.369,0.369,0.167,0.167,0.002,0.002),
  z = c(10,10,24,24,11,11,7,7,9,9,6,6,57,57,100,100,45,45,1,1),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC8 <- list(
  x = c(4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4), 
  y = c(0,10,10,20,20,30,30,40,40,50,50,60,60,70,70,80,80,90,90,100),
  z = c(6,6, 32, 32, 65, 65, 26, 26, 9, 9, 10, 10, 17, 17, 60, 60, 100, 100, 10, 10),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC16 <- list(
  x = c(5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5), 
  y = c(0,9,9,18,18,27,27,36,36,45,45,55,55,64,64,73,73,82,82,91,91,100), 
  z = c(0,0,18,18,95,95,100,100,25,25,6,6,6,6,12,12,16,16,15,15,2,2),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC32 <- list(
  x = c(6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6), 
  y = c(0,4,4,9,9,13,13,17,17,22,22,26,26,30,30,35,35,39,39,43,43,48,48,52,52,57,57,61,61,96,96,100), 
  z = c(3,3,29,29,90,90,100,100,27,27,14,14,8,8,21,21,46,46,39,39,6,6,0,0,1,1,0,0,0,0,0,0),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC64 <- list(
  x = c(7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7), 
  y = c(0,7,7,13,13,20,20,27,27,33,33,40,40,47,47,53,53,60,60,67,67,73,73,80,80,87,87,93,93,100),
  z = c(1,1,2,2,15,15,43,43,48,48,39,39,14,14,18,18,54,54,90,90,100,100,47,47,13,13,2,2,1,1), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC128 <- list(
  x = c(8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8), 
  y = c(0,11,11,22,22,33,33,44,44,56,56,67,67,78,78,89,89,100), 
  z = c(2,2,28,28,100,100,62,62,28,28,50,50,22,22,6,6,1,1), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC256 <- list(
  x = c(9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9), 
#  y = c(0,2,2,4,4,6,6,8,8,10,10,12,12,14,14,16,16,18,20,20,22,22,24,24,26,26,36,38), 
  y = c(0,5,5,11,11,16,16,21,21,26,26,32,32,37,37,42,42,47,47,53,53,58,58,63,63,68,68,89,89,95), 
  z = c(5, 5, 23,23, 32, 32, 52, 52, 55, 55, 100, 100, 71, 71, 59, 59, 33, 33, 15, 15, 3, 3, 3,3,2,2,0,0,2,2), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC512 <- list(
  x = c(10,10,10,10,10,10,10,10,10,10), 
  y = c(0,20,20,40,40,60,60,80,80,100), 
  z = c(29,29,100,100,89,89,27,27,5,5), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC1024 <- list(
  x = c(11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11), 
 #y = c(0,5,5,10,10,15,15,20,20,25,25,30,30,35,35,40,40,45), 
  y = c(0,11,11,22,22,33,33,44,44,56,56,67,67,78,78,89,89,100), 
  z = c(13,13,48,48, 100, 100, 97, 97,47,47,11,11,4,4,1,1,1,1), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC2048 <- list(
  x = c(12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12), 
#  y = c(0,5,5,10,10,15,15,20,20,25,25,30,30,35,35,40,40,45,45,50,50,55,55,60), 
  y = c(0,8,8,17,17,25,25,33,33,42,42,50,50,58,58,67,67,75,75,83,83,92,92,100), 
  z = c(4,4,9,9,32,32,72,72,100,100,85,85,40,40,26,26,12,12,1,1,3,3,1,1), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC4096 <- list(
  x = c(13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13), 
#  y = c(0,5,5,10,10,15,15,20,20,25,25,30,30,35,35,40,40,45,45,50,50,55,55,60), 
  y = c(0,8,8,17,17,25,25,33,33,42,42,50,50,58,58,67,67,75,75,83,83,92,92,100), 
  z = c(6,6,6,6,15,15,44,44,58,58,63,63,62,62,100,100,85,85,67,67,38,38,8,8), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC8192 <- list(
  x = c(14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14), 
   y = c(0,5,5,10,10,14,14,19,19,24,24,29,29,33,33,38,38,43,43,48,48,52,52,57,57,62,62,67,67,71,71,76,76,81,81,86,86,90,90,95,95,100), 
  z = c(9,9, 9,9,6,6,19,19,12,12,31,31,53,53,56,56,100,100,84,84,84,84,91,91,69,69,53,53,47,47,34,34,28,28,9,9,9,9,6,6,0,0), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC16384 <- list(
  x = c(15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15), 
  y = c( 0,5,5,11,11,16,16,21,21,26,26,32,32,37,37,42,42,47,47,53,53,58,58,63,63,68,68,74,74,79,79,84,84,89,89,95,95,100), 
  z = c(11,11,26,26,11,11,32,32,47,47,53,53,47,47,37,37,95,95,68,68,100,100,37,37,53,53,47,47,5,5,11,11,0,0,5,5,0,0), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
data <- list(INC1, INC2, INC4, INC8, INC16, INC32, INC64,INC128,INC256,INC512,INC1024,INC2048,INC4096,INC8192,INC16384)
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
p <- add_trace(p, x=INC8192$x, y=INC8192$y, z=INC8192$z, line=INC8192$line, mode=INC8192$mode, type=INC8192$type, name = 'INC8192')
p <- add_trace(p, x=INC16384$x, y=INC16384$y, z=INC16384$z, line=INC16384$line, mode=INC16384$mode, type=INC16384$type, name = 'INC16384')
p <- layout(p, autosize=layout$autosize, title=layout$title, scene = list(
      xaxis = list(title = "Log(TL)"),
      yaxis = list(title = "Norm. PT"),
      zaxis = list(title = "RF")
    ))
Sys.setenv("plotly_username"="yksuh")
Sys.setenv("plotly_api_key"="4jaag7lYwdndqs5J5CLK")
api_create(p, filename = "3dplot")
dev.off()

