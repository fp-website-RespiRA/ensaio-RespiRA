# ---- 1. Configurar o ambiente ----
# Este script serve para a exploração inicial dos dados antes de passar para o relatório Quarto.

library(tidyverse)
library(here)
library(janitor)
library(gtsummary)
library(gt)

# ---- 2. Ler os dados ----
dados <- read_csv(here("data", "raw", "respira.csv")) %>% 
  clean_names()

# ---- 3. Explorar os dados (Instruções do Ponto 3) ----
glimpse(dados)
summary(dados)

# Verificar missings (NAs)
dados %>% 
  summarise(across(everything(), ~ sum(is.na(.x))))

# ---- 4. Preparação de variáveis ----
dados <- dados %>%
  mutate(
    sexo = factor(sexo, labels = c("Feminino", "Masculino")),
    grupo = factor(grupo, labels = c("Controlo", "App RespiRA")),
    delta_act = act_semana12 - act_baseline
  )

# ---- 5. Manipulação básica----
# Contar por grupo e sexo
dados %>% count(grupo, sexo)