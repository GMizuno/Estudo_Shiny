require(shiny)
require(shinydashboard)
require(readr)
require(dplyr)

proj <- read_csv2(file = 'https://raw.githubusercontent.com/jonates/opendata/master/projecao_IBGE_2018/projecao_IBGE_2018_atualizada06042020.csv',
                  locale = locale(encoding = "ISO-8859-1"))
pop <- proj %>% filter(Ano == 2020, Codigo_UF != 0) %>% group_by(Nome_Regiao) %>%
  summarise(total_por_regiao = sum(Populacao_Total))

evn <- proj %>%  filter(Codigo_UF == 0)

ui <- dashboardPage(
  title = 'Dash',
  header <- dashboardHeader(
    title = 'Testando multiplos itens no sidebar'
  ),
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem('População', icon = icon('users'), tabName = 'pop'),
      menuItem('Expectativa de vida', icon = icon('clock'), tabName = 'evn')
    )
  ),
  body <- dashboardBody(
    tabItems(
      tabItem('evn',
              box(
                title = 'Expectativa de vida ao nascer por UF, Sul, 2010-2060',
                footer = 'Fonte: IBGE',
                status = 'primary',
                plotOutput('ENV'), 
                width = 12, 
                solidHeader = TRUE
              )
              ),
      tabItem('pop',
              box(
                title = 'População residente por regiões do Brasil, 2020',
                footer = 'Fonte: IBGE',
                status = 'primary',
                plotOutput('popregiao'), 
                width = 12,
                solidHeader = TRUE
              )
              )
    )
  )
)

server <- function(input, output, session){
  output$ENV <- renderPlot({
    ggplot(data = evn) + geom_line(aes(x = Ano, y = EVN, color = Nome_Regiao))
  })
  output$popregiao <- renderPlot({
    ggplot(data = pop) + geom_col(aes(x = Nome_Regiao, y = total_por_regiao,
                                              fill = Nome_Regiao)) + 
      labs(x = 'Regiões do Brasil', y = 'População Residente')
  })
}

shinyApp(ui, server)