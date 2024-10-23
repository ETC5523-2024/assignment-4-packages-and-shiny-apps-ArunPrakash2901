library(shiny)
library(plotly)
library(forcats)
library(dplyr)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("flatly"),  # Apply the Flatly theme

  # Custom CSS to style the interface and reduce margins/paddings
  tags$style(HTML("
    body {
      margin: 0;
      padding: 0;
    }

    h1 {
      font-size: 36px;
      color: #2C3E50;
      font-weight: bold;
      text-align: center;
      padding-top: 10px;
      margin-bottom: 30px;
    }

    /* Sidebar styling */
    .sidebar {
      padding: 20px 30px;  /* Adjust padding to make the sidebar compact */
      background-color: rgba(255, 255, 255, 0.9);  /* Slightly opaque for contrast */
      font-size: 18px;  /* Larger font size */
      border-radius: 8px; /* Rounded corners for a polished look */
    }

    /* Slider styling */
    .slider-input {
      margin-top: 10px;
      font-size: 18px;   /* Increase font size of slider labels */
    }

    .irs-slider {
      width: 35px;   /* Increase size of slider handle */
      height: 35px;
    }

    .irs-single, .irs-bar {
      background-color: #3498DB; /* Change slider color */
    }

    .irs-grid-text {
      font-size: 16px; /* Increase slider grid text size */
    }

    .irs-bar {
      border-radius: 5px;
    }

    /* Button Styling */
    .btn {
      background-color: #3498DB;
      color: white;
      border-radius: 5px;
      margin-top: 15px;  /* More space between button and controls */
      padding: 10px 20px;  /* Larger button size */
      font-size: 16px;    /* Larger font size for buttons */
    }
    .btn:hover {
      background-color: #2980B9;
    }

    /* Maximize graph width */
    .shiny-plot-output {
      width: 100%;  /* Make graphs take up full width */
      margin-left: -20px; /* Remove gap from the left */
      margin-right: -20px; /* Remove gap from the right */
    }

    /* Reduce the gap between the sidebar and the main panel */
    .mainPanel {
      margin-top: -30px; /* Reduce the margin between the panels */
    }

    /* Center alignment for the tabset and graphs */
    .nav-tabs, .tab-content {
      text-align: center;
    }
  ")),

  # Center the title and align elements
  titlePanel(
    div("UK Town Socio-Economic Explorer",
        style = "text-align:center; padding-bottom: 10px;")
  ),

  fluidRow(
    column(5,  # Sidebar column
           sidebarPanel(
             h3("Simulation Controls"),  # Sidebar Title
             tabsetPanel(
               # First tab for Size Flag
               tabPanel("Size Flag",
                        h4("Select Size and Growth Options"),  # Add Heading
                        selectizeInput("size_flag", "Select Size Flag",
                                       choices = unique(ukTownData$size[!ukTownData$size %in% c("Inner London BUA", "Outer london BUA", "Not BUA", "Other Small BUAs")]),
                                       selected = unique(ukTownData$size[!ukTownData$size %in% c("Inner London BUA", "Outer london BUA", "Not BUA", "Other Small BUAs")])[1]),
                        sliderInput("pop_growth_size", "Population Growth (%)", min = -50, max = 50, value = 0, width = "100%"),  # Full width slider
                        actionButton("update_size", "Update Size Flag", class = "btn")
               ),
               # Second tab for Income Flag
               tabPanel("Income Flag",
                        h4("Select Income and Education Investment"),  # Add Heading
                        selectizeInput("income_flag", "Select Income Flag",
                                       choices = unique(na.omit(ukTownData$income[!grepl("city", ukTownData$income, ignore.case = TRUE)])),
                                       selected = unique(ukTownData$income[!grepl("city", ukTownData$income, ignore.case = TRUE)])[1]),
                        sliderInput("pop_growth_income", "Population Growth (%)", min = -50, max = 50, value = 0, width = "100%"),  # Full width slider
                        sliderInput("edu_investment", "Education Investment (%)", min = 0, max = 100, value = 10, width = "100%"),  # Full width slider
                        actionButton("update_income", "Update Income Flag", class = "btn")
               )
             )
           )
    ),
    column(7,  # Main panel column (wider for bigger graphs)
           tabsetPanel(
             # Tab for Size Flag-based visualization
             tabPanel("Size Flag Simulations",
                      h4(class = "plot-title", "Size Flag Simulations"),
                      plotlyOutput("size_simulation_plot", height = "800px")  # Increased height and full width for graphs
             ),
             # Tab for Income Flag-based visualization
             tabPanel("Income Flag Simulations",
                      h4(class = "plot-title", "Income Flag Simulations"),
                      plotlyOutput("simulated_population_plot", height = "800px"),  # Increased height and full width for graphs
                      plotlyOutput("simulated_education_plot", height = "800px")   # Increased height and full width for graphs
             )
           )
    )
  )
)


server <- function(input, output, session) {

  # Define the population growth simulation function for the income flag
  simulate_population_growth <- function(data, growth_rate) {
    data %>%
      mutate(simulated_population = population * (1 + growth_rate / 100))
  }

  # Define the size effect simulation function for the size flag
  simulate_size_effect <- function(data, growth_rate) {
    data %>%
      mutate(simulated_population = population * (1 + growth_rate / 100))
  }

  # Define the education investment simulation function
  simulate_education_investment <- function(data, investment_rate) {
    data %>%
      mutate(simulated_edu_score = edu_score * (1 + investment_rate / 100))
  }

  # Reactive data filtered by the selected size flag, removing unwanted size flags
  filtered_data_size <- reactive({
    data <- ukTownData[ukTownData$size == input$size_flag & !ukTownData$size %in% c("Inner London BUA", "Outer london BUA", "Not BUA", "Other Small BUAs"), ]
    data
  })

  # Reactive data filtered by the selected income flag (no cities or NA)
  filtered_data_income <- reactive({
    data <- ukTownData[ukTownData$income == input$income_flag & !is.na(ukTownData$income), ]
    data
  })

  # Plotly graph for size flag simulation (size-based population changes) with towns on the y-axis
  output$size_simulation_plot <- renderPlotly({
    data <- simulate_size_effect(filtered_data_size(), input$pop_growth_size)

    if (nrow(data) > 0) {
      # Reorder town based on simulated population
      data <- data %>%
        mutate(town = fct_reorder(town, simulated_population))

      plot_ly(data, y = ~town, x = ~simulated_population, type = "bar",
              text = ~paste("Town:", town, "<br>Population:", simulated_population),
              hoverinfo = "text",
              marker = list(color = "orange")) %>%
        layout(title = paste("Simulated Population Growth for", input$size_flag, "Towns"),
               xaxis = list(title = "Simulated Population"),
               yaxis = list(title = "Town"),
               height = 800)  # Adjust plot height here
    }
  })

  # Plotly graph for simulated population growth based on income flag with towns on the y-axis
  output$simulated_population_plot <- renderPlotly({
    data <- simulate_population_growth(filtered_data_income(), input$pop_growth_income)

    if (nrow(data) > 0) {
      # Reorder town based on simulated population
      data <- data %>%
        mutate(town = fct_reorder(town, simulated_population))

      plot_ly(data, y = ~town, x = ~simulated_population, type = "bar",
              text = ~paste("Town:", town, "<br>Simulated Population:", simulated_population),
              hoverinfo = "text",
              marker = list(color = "lightblue")) %>%
        layout(title = paste("Simulated Population Growth for", input$income_flag, "Towns"),
               xaxis = list(title = "Simulated Population"),
               yaxis = list(title = "Town"),
               height = 800)  # Adjust plot height here
    }
  })

  # Plotly graph for simulated education investment based on income flag with towns on the y-axis
  output$simulated_education_plot <- renderPlotly({
    data <- simulate_education_investment(filtered_data_income(), input$edu_investment)

    if (nrow(data) > 0) {
      # Reorder town based on simulated education score
      data <- data %>%
        mutate(town = fct_reorder(town, simulated_edu_score))

      plot_ly(data, y = ~town, x = ~simulated_edu_score, type = "bar",
              text = ~paste("Town:", town, "<br>Simulated Education Score:", simulated_edu_score),
              hoverinfo = "text",
              marker = list(color = "peachpuff4")) %>%
        layout(title = paste("Simulated Education Investment for", input$income_flag, "Towns"),
               xaxis = list(title = "Simulated Education Score"),
               yaxis = list(title = "Town"),
               height = 800)  # Adjust plot height here
    }
  })
}


shinyApp(ui = ui, server = server)

