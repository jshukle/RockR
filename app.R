# Required packages
# Shiny packages
require(shiny)
require(shinyWidgets)
require(shinyBS)
require(shinycssloaders)
require(shinyjs)

#Data manipulation
require(plyr)

#Data loading
require(readxl)
require(readr)

#Plotting
require(ggplot2)
require(ggtern)
#require(gginnards)
require(ggalt)

# Load this package last!
require(colourpicker)

# Load other functions
source("functions.R", local = TRUE)

#### User Interface (UI) ####
ui <- fluidPage(
  
  useShinyjs(),  # Set up shinyjs
  
  # Custom IUPUI CSS theme
  theme = "IUPUI.css",

  tags$head(includeHTML(("google-analytics.html"))),
  
  # This code is used to build what shows in the users browser tab when the app is loaded
  list(tags$head(HTML('<link rel="icon", href="Figs/trident_large.png",
                      type="image/png" />'))),
  div(style="padding: 0px 0px; width: '100%'",
      titlePanel(
        title="", windowTitle="RockR! v.2.2" # Change name and version here!
      )
  ),

  tags$head(
    #tags$meta(name = "description", content = "..."),
    tags$meta(name = "url", content = "http://apps.earthsciences.iupui.edu:3838/RockR"),
    tags$meta(name = "keywords", content = "rockr, ternary, discrimination diagram, bivariate, metamorphic facies, plotting tool, geoscience, petrology, geology"),
    tags$meta(name = "title", content = "RockR!"),
    tags$meta(name = "robots", content = "index, follow"),
    tags$meta(name = "image", content = "Figs/RockR.png")
  ),
  
  div(class = "icon-bar",
      # Create url with the 'twitter-share-button' class
      a(href = "https://www.facebook.com/RockRwebapp/?eid=ARAR3piAw1ZiSVQWLZzVOEJa47Zn11XKpC8WY8s0Izli2wTlSi7mFzaOVdEIAg1y8UJYtcJ_XKD2jIs",
        class = "fa fa-facebook",
        target = "_blank",
        style = "display: inline-block; vertical-align: middle",
        onclick = "gtag('event', 'facebook_icon', {
          'event_category': 'link click',
          'event_label': 'user clicked facebook icon link'
          })"
      ),
      # Copy the script from https://dev.twitter.com/web/javascript/loading into your app
      # You can source it from the URL below. It must go after you've created your link
      a(href = "https://twitter.com/RRwebapp",
        class = "fa fa-twitter",
        target = "_blank",
        style = "display: inline-block; vertical-align: middle",
        onclick = "gtag('event', 'twitter_icon', {
          'event_category': 'link click',
          'event_label': 'user clicked twitter icon link'
          })"
      ),
      a(href="https://twitter.com/intent/tweet?text=Visit%20RockR!&url=http://apps.earthsciences.iupui.edu:3838/RockR/&via=RRwebapp",
        "Tweet",
        class="twitter-share-button",
        style = "display: inline-block; vertical-align: middle"
      ),
      includeScript("widgets.js")
      
  ),
  
  navbarPage( id = "tabs",

    # The title section below is where you can alter the navbar title and logo
    title = a(
      fluidRow(
        column(2,
             img(src="Figs/trident_large.png", height = 40, width = 40)
             ),
        column(10,
            p("IUPUI Earth Sciences Apps")
             )
        ),
      id = "linkIUPUI",
      target = "_blank",
      href = "https://earthsciences.iupui.edu/",
      style = "color: white; font-size: 20px; font-weight: bold",
      onclick = "gtag('event', 'IUPUIEarthSciences', {
          'event_category': 'link click',
          'event_label': 'user clicked IUPUI Earth Sciences link'
          })"
      ),

    # UI code for App Info tab
    tabPanel ( "RockR! Home", fluid = TRUE,# Change app title here!
               
               # this block of code supresses all error output in the final app
               # during development comment this out!!!!
               tags$style(type="text/css",
                          ".shiny-output-error { visibility: hidden; }",
                          ".shiny-output-error:before { visibility: hidden; }"
               ),

               div(style="vertical-align:top; text-align:center",
                   img(src = "Figs/RockR.png", width = "30%")
               ),
               
               tabsetPanel(
                 tabPanel("Introduction",
                          includeHTML("www/Info/RockRInfo.html")
                 ),
                 tabPanel("Available Plots",
                          includeHTML("www/Info/allTables.html")
                 ),
                 tabPanel("Credits",
                          includeHTML("www/Info/RockRCredits.html")
                 )
               )
    ),
    
    # UI code for Bivariate tab
    tabPanel(id = "bv", "Create Bivariate", fluid = TRUE,
               
               # this block of code supresses all error output in the final app
               # during development comment this out!!!!
               tags$style(type="text/css",
                          ".shiny-output-error { visibility: hidden; }",
                          ".shiny-output-error:before { visibility: hidden; }"
               ),
               
               source("uiBV.R", local = TRUE)$value
               
    ),
    
    # UI code for Ternary tab
    tabPanel(id = "tern", "Create Ternary", fluid = TRUE,
               
               # this block of code supresses all error output in the final app
               # during development comment this out!!!!
               tags$style(type="text/css",
                          ".shiny-output-error { visibility: hidden; }",
                          ".shiny-output-error:before { visibility: hidden; }"
               ),
               
               source("uiTernary.R", local = TRUE)$value
               
    ),
    
    # UI code for Mm Facies tab
    tabPanel(id = "pt", "Create Mm Facies", fluid = TRUE,
               
               # this block of code supresses all error output in the final app
               # during development comment this out!!!!
               tags$style(type="text/css",
                          ".shiny-output-error { visibility: hidden; }",
                          ".shiny-output-error:before { visibility: hidden; }"
               ),
               
               source("uiPT.R", local = TRUE)$value
               
    ),
    
    # UI code for Help tab
    tabPanel(id = "help", "Help", fluid = TRUE,# Change app title here!
           
           # this block of code supresses all error output in the final app
           # during development comment this out!!!!
           tags$style(type="text/css",
                      ".shiny-output-error { visibility: hidden; }",
                      ".shiny-output-error:before { visibility: hidden; }"
           ),
      
           tabsetPanel(
             tabPanel("Inputting Data",
                      h4("Download Sample Data Sets"),
                      fluidRow(
                        column(4,
                               h5("Bivariate Sample Data: Andes Oxide Data"),
                               downloadButton('baseDownloadBVData', "Get Bivariate Data")
                        ),
                        column(4,
                               h5("Ternary Sample Data: QFL Data"),
                               downloadButton('baseDownloadTernData', "Get Ternary Data")
                        ),
                        column(4,
                               h5("Mm Facies Sample Data: "),
                               downloadButton('baseDownloadPTData', "Get Mm Facies Data")
                        )
                      ),
                      includeHTML("www/Info/dataInput.html")
                      ),
             tabPanel("Building Plots",
                      includeHTML("www/Info/buildPlot.html")
                      ),
             tabPanel("RockR! offline",
                      
                      h3("Want to use RockR! offline? Want to contribute to RockR!?"),
                      
                      h4("RockR! was designed as a web app. However, because it is truly free
                         and open source, you can download the full program below and run it locally.
                          To run RockR! locally, unzip the RockR! directory, and open the app.R file in Rstudio. 
                         Within Rstudio we recommend you click the BLACK DOWN ARROW next to 'Run App' at
                         the top of the app.R script page and set it to 'Run External', which will run RockR!
                         locally within your default web browser of choice. Next, make sure you have installed
                         all of the required packages to run RockR! (you can find them listed at the top of app.R). 
                         Last just click the 'Run App' to run RockR! locally. When running RockR! locally, the app
                         will never timeout, as it does when run on a server as a web app, and you can run it
                         anywhere at anytime, even in the field! Have fun and rock on!"),
                      
                      h4("Because RockR is an ongoing project. We update the app frequently as we discover bugs that need
                         addressing or when we wish to add functionality. However, you can download current version of RockR as a zip
                         file using the button below. Its open source so feel free to modify/share the program as you see fit."),
                      
                      br(),
                      downloadButton('baseDownloadRockR', "Get RockR!"),
                      
                      br(),
                      h3("Most recent update"),
                      h4("RockR! v.2.2 on 3.January.2019"),
                      h4("Added Folk (1954) sediment classification ternary diagram"),
                      h4("Updated references and available plots tab to reflect Folk addition"),
                      br(),
                      h3("Past updates"),
                      h4("RockR! v.2.1 on 20.December.2018"),
                      h4("Added social media links and share buttons"),
                      h4("Navbar is now fixed when user scrolls, allowing easier app navigation"),
                      br(),
                      h4("RockR! v.2.0 on 18.November.2018"),
                      h4("GGplot plotting code overhaul. Should be more efficient and faster overall"),
                      h4("Paths added to BV, PT, and Ternary sections"),
                      h4("Moved available plots tab to front page."),
                      h4("Moved RockR download to help page."),
                      h4("Added Earth Sciences homepage link to navbar title."),
                      h4("Reorganized files within RockR directory to put all supporting files under 'www/'."),
                      h4("Loading spinner added to plots in all sections."),
                      br(),
                      h4("RockR! v.1.9.1 on 14.November.2018"),
                      h4("Added extrusive and intrusive TAS diagrams modeled after Cox et al. (1979) and Wilson (2007), respectively."),
                      h4("Added peridotite classification ternary diagram."),
                      h4("Updated available plots table."),
                      br(),
                      h4("RockR! v.1.9 on 13.November.2018"),
                      h4("Added paths to Mm group control options."),
                      h4("Added Collision and Intrusion labels to Mm paths."),
                      h4("Improved PT_example file."),
                      h4("Updated some text."),
                      br(),
                      h4("RockR! v.1.7 on 9.November.2018"),
                      h4("Added support for .csv import."),
                      h4("Added click and drag zoom functionality to PT Meta plots."),
                      br()
                      )
           )
           )
  )
)

#### End User Interface (UI) ####

##### Server ####
server <- function(input, output, session){
  
  # watches for users to click the IUPUI Earth Sciences link and records the event with Google Analytics
  # onclick("linkIUPUI",
  #         ga_collect_event(event_category = "Link", event_action = "Link Clicked",
  #                                       event_label = "User clicked IUPUI link")
  #         )
  
  onclick(
    id = "tabs",
    shinyjs::runjs("window.scrollTo(0,0)")
  )


  # # load Ternary section server code
  source("serverBV.R", local = TRUE)$value
  
  # load Ternary section server code
  source("serverTernary.R", local = TRUE)$value
  
  # load PT section server code
  source("serverPT.R", local = TRUE)$value
  
  # output$baseDownloadBuild <- downloadHandler(
  #   filename <- function() {
  #     "BuildDiscrim.html"
  #   },
  # 
  #   content <- function(file) {
  #     file.copy("Info/Downloads/BuildDiscrim.ppt", file)
  #   },
  #   contentType = "application/zip"
  # )
  
  output$baseDownloadRockR <- downloadHandler(
    filename <- function() {
      "RockR.zip"
    },
    
    content <- function(file) {
      file.copy("www/Downloads/RockR.zip", file)
    },
    contentType = "application/zip"
  )
  
  output$baseDownloadBVData <- downloadHandler(
    filename <- function() {
      "Andes_Example.xlsx"
    },
    
    content <- function(file) {
      file.copy("www/Downloads/ExampleData/Andes.xlsx", file)
    }
  )
  
  output$baseDownloadTernData <- downloadHandler(
    filename <- function() {
      "QFL_Example.xlsx"
    },
    
    content <- function(file) {
      file.copy("www/Downloads/ExampleData/qfl1.xlsx", file)
    }
  )
  
  output$baseDownloadPTData <- downloadHandler(
    filename <- function() {
      "PT_Example.xlsx"
    },
    
    content <- function(file) {
      file.copy("www/Downloads/ExampleData/PTsample.xlsx", file)
    }
  )
  
} 
#### End Server ####

# Initiate app by calling this function
shinyApp(ui=ui, server=server)
