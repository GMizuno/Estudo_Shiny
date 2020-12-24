require(readr)
require(ggplot2)
require(dplyr)
require(shinydashboard)
require(shiny)

proj <- read_csv2(file = 'https://raw.githubusercontent.com/jonates/opendata/master/projecao_IBGE_2018/projecao_IBGE_2018_atualizada06042020.csv',
                 locale = locale(encoding = "ISO-8859-1"))

pop_regioes <- proj %>% filter(Codigo_UF == 0, Codigo_Regiao != 0, Ano == 2020)
pop_nor <- proj %>% filter(Codigo_UF != 0, Nome_Regiao == 'Nordeste', Ano == 2020) %>% 
  mutate(Nome_UF = factor(x = Nome_UF, levels = Nome_UF))

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    box(
      title = 'População residente por regiões do Brasil, 2020',
      footer = 'Fonte: IBGE',
      status = 'primary',
      plotOutput('popregiao'), 
      width = 12,
      solidHeader = TRUE
    ),
    box(
      title = 'População residente por UF, Nordeste do Brasil, 2020',
      footer = 'Fonte: IBGE',
      status = 'warning',
      plotOutput('NE'),
      width = 12,
      height = 10,
      solidHeader = TRUE
    )
  )
)

server <- function(input, output, session){
  output$popregiao <- renderPlot({
    ggplot(data = pop_regioes) + geom_col(aes(x = Nome_Regiao, y = Populacao_Total,
                                            fill = Nome_Regiao)) + 
      labs(x = 'Regiões do Brasil', y = 'População Residente')
  })
  output$NE <- renderPlot({
    ggplot(data = pop_nor) + geom_col(aes(x = Nome_UF, y = Populacao_Total),
                                      fill = 'blue') + 
      labs(x = 'Regiões do Brasil', y = 'População Residente')
  })
}

shinyApp(ui, server)