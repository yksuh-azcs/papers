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
INC8 <- list(
  x = c(4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4), 
  y = c(0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10), 
  z = c(0.01801802,0.01801802, 0.09509510, 0.09509510, 0.19419419, 0.19419419, 0.07807808, 0.07807808, 0.02602603, 0.02602603, 0.02902903, 0.02902903, 0.05205205, 0.05205205, 0.18018018, 0.18018018, 0.29829830, 0.29829830, 0.02902903, 0.02902903),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC16 <- list(
  x = c(5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5), 
  y = c(0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11), 
  z = c(0.001,0.001, 0.060, 0.060, 0.324, 0.324, 0.341, 0.341, 0.085, 0.085, 0.021, 0.021, 0.019, 0.019, 0.040, 0.040, 0.053, 0.053, 0.050, 0.050, 0.006, 0.006),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC32 <- list(
  x = c(6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6), 
  y = c(0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,14,14,22,22,23), 
  z = c(0.007,0.007,0.075,0.075, 0.234, 0.234, 0.259, 0.259, 0.071, 0.071, 0.036, 0.036, 0.022, 0.022, 0.055, 0.055, 0.120, 0.120, 0.100, 0.100, 0.016, 0.016, 0.001, 0.001,0.002,0.002, 0.001, 0.001,0, 0, 0.001,0.0001),
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC64 <- list(
  x = c(7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7), 
  y = c(0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,14,14,15), 
  z = c(0.002,0.002, 0.004, 0.004, 0.031,0.031, 0.089, 0.089, 0.099, 0.099, 0.080, 0.080, 0.029, 0.029, 0.037, 0.037, 0.111, 0.111, 0.184, 0.184, 0.205, 0.205, 0.096, 0.096, 0.026, 0.026, 0.004, 0.004, 0.003, 0.003), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC128 <- list(
  x = c(8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8), 
  y = c(0,2,2,4,4,6,6,8,8,10,10,12,12,14,14,16,16,18), 
  z = c(0.003344482,0.003344482, 0.046822742, 0.046822742, 0.167224080, 0.167224080, 0.103678930, 0.103678930, 0.046822742, 0.046822742, 0.083612040,0.083612040, 0.036789298, 0.036789298, 0.010033445, 0.010033445, 0.001672241, 0.001672241), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC256 <- list(
  x = c(9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9), 
  y = c(0,2,2,4,4,6,6,8,8,10,10,12,12,14,14,16,16,18,20,20,22,22,24,24,26,26,36,38), 
  z = c(0.005016722, 0.005016722, 0.025083612, 0.025083612, 0.035117057, 0.035117057, 0.056856187, 0.056856187, 0.060200669, 0.060200669, 0.110367893, 0.110367893, 0.078595318, 0.078595318, 
0.065217391, 0.065217391, 0.036789298, 0.036789298, 0.016722408, 0.016722408, 0.003344482,0.003344482,0.001672241, 0.001672241,0,0,0.001672241,0.001672241), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC512 <- list(
  x = c(10,10,10,10,10,10,10,10,10,10), 
  y = c(0,5,5,10,10,15,15,20,20,25), 
  z = c(0.022895623,0.022895623, 0.080134680, 0.080134680, 0.071380471, 0.071380471, 0.021548822, 0.021548822, 0.004040404, 0.004040404), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
),
INC1024 <- list(
  x = c(11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11), 
  y = c(0,5,5,10,10,15,15,20,20,25,25,30,30,35,35,40,40,45), 
  z = c(0.0081081081,0.0081081081, 0.0297297297, 0.0297297297, 0.0621621622, 0.0621621622, 0.0601351351, 0.0601351351, 0.0290540541, 0.0290540541, 0.0067567568, 0.0067567568, 0.0027027027, 0.0027027027, 0.0006756757, 0.0006756757, 0.0006756757, 0.0006756757), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC2048 <- list(
  x = c(12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12), 
  y = c(0,5,5,10,10,15,15,20,20,25,25,30,30,35,35,40,40,45,45,50,50,55,55,60), 
  z = c(0.0020066890,0.0020066890, 0.0046822742, 0.0046822742, 0.0167224080, 0.0167224080, 0.0374581940, 0.0374581940, 0.0521739130, 0.0521739130,0.0441471572,0.0441471572, 
0.0207357860,0.0207357860, 0.0133779264, 0.0133779264, 0.0060200669, 0.0060200669, 0.0006688963, 0.0006688963, 0.0013377926, 0.0013377926, 0.0006688963, 0.0006688963), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC4096 <- list(
  x = c(13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13), 
  y = c(0,5,5,10,10,15,15,20,20,25,25,30,30,35,35,40,40,45,45,50,50,55,55,60), 
  z = c(0.002090592,0.002090592, 0.002090592, 0.002090592, 0.005574913, 0.005574913, 0.016027875, 0.016027875, 0.020905923, 0.020905923, 0.022996516, 0.022996516, 0.022299652, 0.022299652,
 0.036236934, 0.036236934, 0.030662021, 0.030662021, 0.024390244, 0.024390244, 0.013937282, 0.013937282, 0.002787456, 0.002787456), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC8192 <- list(
  x = c(14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14), 
  y = c(0,5,5,10,10,15,15,20,20,25,25,30,30,35,35,40,40,45,45,50,50,55,55,60,60,65,65,70,70,75,75,80,80,85,85,90,90,95,95,100,100,105), 
  z = c(0.002307692,0.002307692, 0.002307692, 0.002307692, 0.001538462, 0.001538462, 0.004615385, 0.004615385, 0.003076923, 0.003076923, 0.007692308, 0.007692308, 0.013076923, 0.013076923, 
0.013846154, 0.013846154, 0.024615385, 0.024615385, 0.020769231, 0.020769231, 0.020769231, 0.020769231, 0.022307692, 0.022307692, 0.016923077, 0.016923077, 0.013076923, 0.013076923, 
0.011538462,0.011538462, 0.008461538, 0.008461538, 0.006923077, 0.006923077, 0.002307692, 0.002307692, 0.002307692, 0.002307692, 0.001538462, 0.001538462, 0.000000000, 0.000000000), 
  line = list(
    color = "Purpule", 
    width = 10
  ), 
  mode = "lines", 
  type = "scatter3d"
)
INC16384 <- list(
  x = c(15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15), 
  y = c(0,10,10,20,20,30,30,40,40,50,50,60,60,70,70,80,80,90,90,100,100,110,110,120,120,130,130,140,140,150,150,160,160,170,170,180,180,190), 
  z = c(0.0015384615,0.0015384615, 0.0038461538, 0.0038461538, 0.0015384615, 0.0015384615, 0.0046153846, 0.0046153846, 0.0069230769, 0.0069230769, 0.0076923077, 0.0076923077, 
0.0069230769,0.0069230769, 0.0053846154, 0.0053846154, 0.0138461538, 0.0138461538, 0.0100000000, 0.0100000000, 0.0146153846, 0.0146153846, 0.0053846154, 0.0053846154, 
0.0076923077,0.0076923077, 0.0069230769, 0.0069230769, 0.0007692308, 0.0007692308, 0.0015384615, 0.0015384615, 0.0000000000, 0.0000000000, 0.0007692308, 0.0007692308, 
0.0000000000, 0.0000000000), 
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

