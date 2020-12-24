require(readr)
require(ggplot2)
require(dplyr)
require(shinydashboard)
require(shiny)

proj <- read_csv2(file = 'https://raw.githubusercontent.com/jonates/opendata/master/projecao_IBGE_2018/projecao_IBGE_2018_atualizada06042020.csv',
                  locale = locale(encoding = "ISO-8859-1"))

pop_sul <- proj %>% filter(Codigo_UF != 0, Nome_Regiao == 'Sul') 

ui <- dashboardPage(
  header <- dashboardHeader(),
  sidebar <- dashboardSidebar(),
  body <- dashboardBody(
    box(
      title = 'Expectativa de vida ao nascer por UF, Sul, 2010-2060',
      footer = 'Fonte: IBGE',
      status = 'primary',
      plotOutput('ENVSul'), 
      solidHeader = TRUE
    )
  )
)

server <- function(input, output, session){
  output$ENVSul <- renderPlot({
    ggplot(data = pop_sul) + geom_line(aes(x = Ano, y = EVN, color = Nome_UF))
  })
}

shinyApp(ui, server)







shinyApp(ui, server)