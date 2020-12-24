require(shiny)
require(shinydashboard)
require(ggplot2)

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
  sidebar <- dashboardSidebar(
    width = '150px',
    disable = FALSE,
    collapsed = TRUE, # app inicia com side bar recolhido
    sidebarMenu()
  ),
  body = dashboardBody(
    h1('Usando Box'),
    fluidRow(
      valueBoxOutput(outputId = 'populacao', width = 4),
      valueBoxOutput(outputId = 'fecundidade', width = 4),
      valueBoxOutput(outputId = 'EVN', width = 4),
    ),
    fluidRow(
      box(
        title = 'Distribui????o da popula????o por grupo et??rio, BR 2020',
        footer = 'Fonte: IBGE. Proje????o 2018',
        status = 'primary', 
        solidHeader = TRUE, # muda o header
        collapsible = TRUE, # permite recolher as informacoes
        # collapsed = TRUE, comecar fechado
        width = 6,
        plotOutput('gropoetario')
        ),
      box(
        title = 'Distribui????o da popula????o por sexo, BR 2020',
        footer = 'Fonte: IBGE. Proje????o 2018',
        status = 'primary', 
        solidHeader = TRUE, # muda o header
        collapsible = TRUE, # permite recolher as informacoes
        # collapsed = TRUE, comecar fechado
        width = 6,
        plotOutput('sexo')
      )
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
  output$gropoetario <- renderPlot({
    ggplot() + geom_col( aes(x = c("<15 ano", "15-64 anos", "65+anos"), 
                             y = c(20.87, 69.30, 9.83)), fill = 'maroon', col = 'grey') +
      xlab('grupos etarios') + ylab('procentagem')
  })
  output$sexo <- renderPlot({
    ggplot() + geom_col( aes(x = c("Masculino", "Feminino"), 
                             y = c(51, 49)), fill = 'maroon', col = 'grey') +
      xlab('grupos etarios') + ylab('procentagem')
  })
  
}

shinyApp(ui, server)