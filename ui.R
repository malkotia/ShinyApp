#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram

shinyUI(fluidPage(
  
  # Application title
  h1("Simulation of exponential distribution",align="center"),
  br(),
  h1("Understanding the impact of Number of simulations, sample size and Lambda",align="center"),
  br(),
  br(),
  # Slide bar for number of parameters 
  fluidRow(
    column(4,offset=1,
      sliderInput("Samplesize","Sample Size for Simulation:",
        min=10,
        max=100,
        value=40)
    ),    
    
      column(4,offset=1,
        sliderInput("nosim","Number of Simulations:",
                    min=100,
                    max=10000,
                    value=1000)
      ),    
    
      
        column(4,offset=1,
          sliderInput("Lambda","Lambda Value:",
                      min=0.1,
                      max=0.4,
                      value=0.2)
        ),  
    # Show a plot of the generated distribution
    
    column(12,
    mainPanel(
    plotOutput("simulationPlot")
    )
  )
)))
