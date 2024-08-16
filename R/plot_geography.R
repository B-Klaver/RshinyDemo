#' @title Plot rates over time by geography.
#' @name plot_geography
#' @rdname plot_geography
#' @export plot_geography
#' @aliases plot_geography
#' @description  plot_geography() will create a plotly object.
#' @author Braeden Klaver
#' @usage plot_geography(data)
#' @param data The dataset for the plot
#' @return Plotly object

plot_geography <- function(data) {
  
  
  #set up the colors
  plot_data <- data %>%
    dplyr::mutate(
      colour = '#003E7A'
    )
  
  
  plt <- plotly::plot_ly(
    data = plot_data,
    x = ~ .data[['surveillance_reported_year']],
    y = ~ .data[['value']],
    name = ~ .data[['surveillance_region_ha']],
    color = ~ I(colour),
    type = 'scatter',
    mode = 'lines',
    showlegend = TRUE,
    hoverinfo = "text",
    hovertext = paste0(
      "<br><b>Disease:</b> ", plot_data$reporting_condition,
      "<br><b>Region:</b> ", plot_data$surveillance_region_ha,
      "<br><b>Year:</b> ", plot_data$surveillance_reported_year,
      "<br><b>Rate:</b> ", format(plot_data$value, nsmall = 1), " per 100,000 population"
    )
  ) %>%
    plotly::config(
      displaylogo = FALSE,
      displayModeBar = TRUE,
      modeBarButtonsToRemove = c("zoomIn2d", "zoomOut2d")
    ) %>%
    plotly::layout(
      legend = list(title = NULL,
                    xanchor = 'center',
                    yanchor = 'bottom',
                    orientation = "h",
                    traceorder = "normal",
                    font = list(size = 14),
                    x = 0.5,
                    y = -0.2), #-0.25
      hoverlabel = list(align = "left"),
      margin = list(l = 45, 
                    r = 10, 
                    b = 75, 
                    t = 70, #85
                    pad = 0)
    ) %>%
    plotly::layout(
      title = list(text = '', 
                   font = list(size = 16),
                   y = 0.925),
      xaxis = list(title = '',
                   tickvals = seq(min(plot_data$surveillance_reported_year), 
                                  max(plot_data$surveillance_reported_year), 
                                  by = 1),
                   tickformat = NULL,
                   tickangle = 0,
                   range = c(min(as.numeric(plot_data$surveillance_reported_year)) - 1,
                             max(as.numeric(plot_data$surveillance_reported_year)) + 1),
                   titlefont = list(size = 14),
                   tickfont = list(size = 14),
                   dtick = "M1",
                   showgrid = F,
                   ticks = "outside", 
                   ticklen = 3, 
                   tickwidth = 2, 
                   tickcolor = plotly::toRGB("black"), 
                   linecolor = plotly::toRGB("black"),
                   showticklabels = TRUE, 
                   zeroline = F, 
                   showline = T),
      yaxis = list(title = '<b>Rate per 100,000 population</b>',
                   range = NULL,
                   titlefont = list(size = 14),
                   tickfont = list(size = 14),
                   showgrid = T,
                   ticks = "outside",
                   ticklen = 3,
                   tickwidth = 2,
                   tickcolor = plotly::toRGB("black"),
                   linecolor = plotly::toRGB("black"),
                   showticklabels = TRUE,
                   zeroline = F,
                   showline = T,
                   rangemode = "tozero",
                   tickformat = "digit",
                   ticksuffix = NULL)
    )
  
  return(plt)
  
}

