require(shiny)
require(shinydashboard)
require(readr)
require(dplyr)
require(lubridate)
require(ggplot2)

proj <- read_csv2(file = 'https://raw.githubusercontent.com/jonates/opendata/master/projecao_IBGE_2018/projecao_IBGE_2018_atualizada06042020.csv',
                  locale = locale(encoding = "ISO-8859-1"))
pop <- proj %>% filter(Ano == 2020, Codigo_UF != 0) %>% group_by(Nome_Regiao) %>%
  summarise(total_por_regiao = sum(Populacao_Total))

evn <- proj %>%  filter(Codigo_UF == 0)

ui <- dashboardPage(
  title = 'Meu Dash',
  skin = 'purple',
  header <- dashboardHeader(
    title = "Graficos do IBGE"),
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem('População', icon = icon('users'), tabName = 'pop')
    ),
    sidebarMenu(
      menuItem('Expectativa de vida', icon = icon('clock'), tabName = 'evn')
    ),
    sidebarMenu(
      selectInput('reg', "Regiões:", unique(evn$Nome_Regiao), selected = "Todas")
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
                width = 6, 
                solidHeader = TRUE
              ),
              box(title = 'Medida descritiva',
                  footer = 'Fonte: IBGE',
                  status = 'primary',
                  tableOutput('ENVmed'), 
                  width = 6, 
                  solidHeader = TRUE)
      
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
    if (input$reg == 'Todas'){
      ggplot(data = evn) + geom_line(aes(x = Ano, y = EVN, color = Nome_Regiao))
    } else{
      data <- evn %>% filter(Nome_Regiao == input$reg)
      ggplot(data = data) + geom_line(aes(x = Ano, y = EVN)) + labs(title = input$reg)
    }
  })
  output$ENVmed <- renderTable({
    dados <- evn %>% group_by(Nome_Regiao) %>%
      summarise(Media_EVN = mean(EVN),
                Media_Homens_EVN = mean(EVN_Homens),
                Media_Mulheres_EVN = mean(EVN_Mulheres))
    dados
  })
  output$popregiao <- renderPlot({
    ggplot(data = pop) + geom_col(aes(x = Nome_Regiao, y = total_por_regiao,
                                      fill = Nome_Regiao)) + 
      labs(x = 'Regiões do Brasil', y = 'População Residente')
  })
}

shinyApp(ui, server)
