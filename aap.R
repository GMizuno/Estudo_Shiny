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
    sidebarMenu(
      menuItem(
        text = 'Criando item sidebar',
        icon = icon('globe'),
        tabName = 'aba1' # id para aba
      ),
      menuItem(
        text = 'mais ...',
        icon = icon('plus'),
        menuSubItem(
          text = 'Calendario',
          icon = icon('calendar'),
          tabName = 'aba2'
        ),
        menuSubItem(
          text = 'Perfil',
          icon = icon('users'),
          tabName = 'aba3'
        )
      ),
      menuItem(
        text = 'Livros',
        icon = icon('book'),
        badgeLabel = 'Novo',
        badgeColor = 'green',
        href = 'https://shiny.rstudio.com'
      )
    )
    ), # disable = true tira 
  body = dashboardBody(
    fluidRow(p('testando qualquer coisa',lubridate::today())),
    fluidRow(p('testando qualquer coisa 2',lubridate::today())),
    fluidRow(
      column(
        width = 4,
        p('Testando coluna 1 ')
      ),
      column(
        width = 4,
        p('Testando coluna 2')
      ),
      column(
        width = 4,
        p('Testando coluna 3')
      )
      ),
      fluidRow(
        column(
          width = 2,
          p('Testando coluna 4 ')
        ),
        column(
          width = 3,
          p('Testando coluna 5')
        ),
        column(
          offset = 3, # add espaco entre as colunas
          width = 4,
          p('Testando coluna 5')
        )
        ),
     fluidRow(p('pulando linha')), # gambiarra para pular linha
    fluidRow(p('Linha nova')),
    
  )
)

server <- function(input, output, session){
  
}

shinyApp(ui, server)