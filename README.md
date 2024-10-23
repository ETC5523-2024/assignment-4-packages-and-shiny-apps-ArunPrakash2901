# ukTownMetrics

`ukTownMetrics` is an R package designed to explore socio-economic metrics of UK towns. The package provides interactive simulations for population growth, education investment, and other key factors that affect employment rates and socio-economic development. You can visualize these metrics and compare towns based on various flags like size and income levels.

## Features

- **Interactive Town Simulations**: Run what-if scenarios to explore how population growth and education investment affect employment and socio-economic outcomes in towns.
- **Size and Income Flags**: Visualize towns based on size or income classification and adjust key variables to see how changes impact socio-economic metrics.
- **Plotly-based Interactive Visualizations**: Hover over interactive graphs to explore data points in detail, allowing for deeper analysis.
- **Vignettes and Articles**: Detailed explanations of the package's functionality with step-by-step examples.

## Installation

You can install the development version of `ukTownMetrics` from GitHub using the `remotes` package:

```r
# Install remotes if you don't have it already
install.packages("remotes")

# Install ukTownMetrics
remotes::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-ArunPrakash2901")


# Example of running simulations and visualizing results
runShinyApp()  # Launches the Shiny app for exploring simulations
```

## Shiny App: UK Town Socio-Economic Explorer
The package comes with an integrated Shiny app that allows users to interactively simulate the impact of different variables on towns' socio-economic metrics.

- **Size Flag Simulation:** Simulate population growth for towns of different sizes (e.g., small towns, large towns).
- **Income Flag Simulation:** Adjust income levels and education investment to see the impact on socio-economic outcomes.
- **Interactive Visualizations:** Explore population growth, education investment, and employment metrics using interactive, hover-enabled graphs.
