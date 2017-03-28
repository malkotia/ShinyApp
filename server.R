#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$simulationPlot <- renderPlot({
    
    lambda  <- input$Lambda
    nosim  <- input$nosim
    n  <- input$Samplesize  
    
    sample <- replicate(nosim, mean(rexp(n,lambda)))
    
    
    sampledf <-data.frame(sample)
    sampleplot <- ggplot(sampledf,aes(x=sample)) +geom_histogram(alpha = .20, binwidth=.2,colour="red") +
    ggtitle("Distribution of means of sample")+xlab("Mean of Sample")+ylab("Frequency")+theme(plot.title = element_text(size=20,hjust = 0.5),axis.title=element_text(size=18))
    xnormvalue <- seq(2,8,length=100)
    theorymean <-1/lambda
    theorysd=theorymean/sqrt(40)
    ynormvalue <- dnorm(xnormvalue,mean=theorymean, sd=theorysd)
    #scale y values
    ynormvalue <- nosim*ynormvalue*lambda
    
    xynormvalue <- data.frame(cbind(xnormvalue,ynormvalue))
    
    sampleplot <- sampleplot + geom_point(data = xynormvalue,aes(x = xynormvalue$xnormvalue, y = xynormvalue$ynormvalue)) 
    print(sampleplot)
    
  })
})
