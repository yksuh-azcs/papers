library(plotly)
INC1 <- list(
  x = c(0,0,0,0,0,0,0,0), 
  y = c(0,25,25,50,50,75,75,100),
  z = c(5,5,43,43,100,100,9,9),
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
  z = c(0,5,5,5,4,4,4,4,3,3,6,6,15,15,100,100,23,23,1,1),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
#data <- list(INC1, INC2, INC4, INC8, INC16, INC32, INC64,INC128,INC256,INC512,INC1024,INC2048,INC4096)
data <- list(INC1)
layout <- list(
  autosize = FALSE, 
  height = 600, 
  title = "3d Stacked Histogram", 
  width = 600
)
p <- plot_ly()
p <- add_trace(p, x=INC1$x, y=INC1$y, z=INC1$z, line=INC1$line, mode=INC1$mode, type=INC1$type, name = 'INC1')
#p <- add_trace(p, x=INC2$x, y=INC2$y, z=INC2$z, line=INC2$line, mode=INC2$mode, type=INC2$type, name = 'INC2')
#p <- add_trace(p, x=INC4$x, y=INC4$y, z=INC4$z, line=INC4$line, mode=INC4$mode, type=INC4$type, name = 'INC4')
#p <- add_trace(p, x=INC8$x, y=INC8$y, z=INC8$z, line=INC8$line, mode=INC8$mode, type=INC8$type, name = 'INC8')
#p <- add_trace(p, x=INC16$x, y=INC16$y, z=INC16$z, line=INC16$line, mode=INC16$mode, type=INC16$type, name = 'INC16')
#p <- add_trace(p, x=INC32$x, y=INC32$y, z=INC32$z, line=INC32$line, mode=INC32$mode, type=INC32$type, name = 'INC32')
#p <- add_trace(p, x=INC64$x, y=INC64$y, z=INC64$z, line=INC64$line, mode=INC64$mode, type=INC64$type, name = 'INC64')
#p <- add_trace(p, x=INC128$x, y=INC128$y, z=INC128$z, line=INC128$line, mode=INC128$mode, type=INC128$type, name = 'INC128')
#p <- add_trace(p, x=INC256$x, y=INC256$y, z=INC256$z, line=INC256$line, mode=INC256$mode, type=INC256$type, name = 'INC256')
#p <- add_trace(p, x=INC512$x, y=INC512$y, z=INC512$z, line=INC512$line, mode=INC512$mode, type=INC512$type, name = 'INC512')
#p <- add_trace(p, x=INC1024$x, y=INC1024$y, z=INC1024$z, line=INC1024$line, mode=INC1024$mode, type=INC1024$type, name = 'INC1024')
#p <- add_trace(p, x=INC2048$x, y=INC2048$y, z=INC2048$z, line=INC2048$line, mode=INC2048$mode, type=INC2048$type, name = 'INC2048')
#p <- add_trace(p, x=INC4096$x, y=INC4096$y, z=INC4096$z, line=INC4096$line, mode=INC4096$mode, type=INC4096$type, name = 'INC4096')
p <- layout(p, autosize=layout$autosize, title=layout$title, scene = list(
      xaxis = list(title = "Log(TL)"),
      yaxis = list(title = "Norm. PT"),
      zaxis = list(title = "RF")
    ))
Sys.setenv("plotly_username"="yksuh")
Sys.setenv("plotly_api_key"="4jaag7lYwdndqs5J5CLK")
api_create(p, filename = "3dplot_utime_only")
dev.off()

