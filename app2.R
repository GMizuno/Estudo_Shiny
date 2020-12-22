require(shiny)
require(shinydashboard)

ui <- dashboardPage(
  title = 'Meu Dash',
  skin = 'blue',
  header = dashboardHeader(
    title = img(
      src = 'https://ih1.redbubble.net/image.543360195.2115/pp,840x830-pad,1000x1000,f8f8f8.u4.jpg',
      width = '40px',
      heigth = '47px'),
    titleWidth = '200px'
  ),
  sidebar = dashboardSidebar(
    width = '150px',
    disable = FALSE,
    collapsed = TRUE, # app inicia com side bar recolhido
    sidebarMenu()
    ),
  body = dashboardBody(
    h1('Usando valueBox'),
    fluidRow(
      valueBoxOutput(outputId = 'populacao', width = 4),
      valueBoxOutput(outputId = 'fecundidade', width = 4),
      valueBoxOutput(outputId = 'EVN', width = 4),
    )
  )
)

server <- function(input, output, session){
  output$populacao <- renderValueBox({ 
    valueBox(
      value = '211.881.593',
      subtitle = 'Residentes no BR',
      icon = icon('users'),
      color = 'red'
    )
    })
  output$fecundidade <- renderValueBox({ 
    valueBox(
      value = '1.76 filhos/mulher',
      subtitle = 'Residentes no BR',
      icon = icon('baby'),
      color = 'blue'
    )
  })
  output$EVN <- renderValueBox({ 
    valueBox(
      value = '76.74 anos',
      subtitle = 'Residentes no BR',
      icon = icon('clock'),
      color = 'green'
    )
  })
}

shinyApp(ui, server)