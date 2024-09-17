# 📍 Carlos CEP Finder

O **Carlos CEP Finder** é a solução perfeita para o nosso amigo Carlos, que tem dificuldades em lidar com a tecnologia e a caderneta 📒 ao procurar CEPs e endereços. Este projeto foi criado para facilitar seu fluxo de trabalho, permitindo buscar CEPs, visualizar no mapa 🗺️ e armazenar os dados de forma simples e eficiente.

## ✨ Funcionalidades Principais

- 🔍 **Busca de CEP**: Busque por CEPs (inteiros ou apenas parte deles) utilizando uma API.
- 📝 **Histórico de Busca**: Armazena até 5 resultados no histórico local, facilitando consultas futuras.
- 🗺️ **Visualização no Mapa**: Mostra a localização do CEP pesquisado.
- 🏠 **Armazenamento de Endereço**: Salve o cep, endereço além do número e complemento (quando aplicável).
- 🌍 **Geolocalização**: Identifica sua localização atual ou utiliza uma posição padrão se a permissão de localização for negada.

## 📚 Guia Técnico de Endereçamento

Este projeto segue as normas dos Correios para o correto endereçamento de correspondências. Aqui estão alguns trechos do [Guia Técnico de Endereçamento de Correspondências](https://www.correios.com.br/enviar/correspondencia/arquivos/nacional/guia-tecnico-de-enderecamento-de-correspondencias.pdf):

- **Número**: O número do imóvel é utilizado para especificar onde o objeto deve ser entregue. Em logradouros sem numeração, foi utilizado nesse aplicativo apenas um campo vázio.
- **Complemento**: É utilizado para especificar detalhes do endereço, como "LOJA B", "APARTAMENTO 701", etc.

Exemplo:  
`AVENIDA OCEANICA 123, LOJA B`, 
`AVENIDA OCEANICA, LOJA B`, 
`AVENIDA OCEANICA`

## 🔧 Tecnologias Utilizadas

Este projeto foi desenvolvido utilizando as seguintes tecnologias e padrões como base:

- 🧼 **Clean Architecture**: Garantindo um código bem organizado e escalável.
- 🛠️ **Flutter Modular**: Facilitando a navegação e organização dos módulos.
- 🔄 **flutter_bloc**: Gerenciando os estados do aplicativo de maneira eficiente.

## 🛠️ Funcionalidades Adicionais

- Permite o **registro de CEPs repetidos** com complementos ou número diferentes, útil para situações como apartamentos no mesmo prédio ou casas em um condomínio. Por exemplo:
  - `Endereço: 42701-740, Apartamento 701`
  - `Endereço: 42701-740, Apartamento 801`
  
  Isso ajuda a lidar com cenários onde pessoas compartilham o mesmo CEP mas têm endereços diferentes.

- Funciona **offline** para exibir os dados já salvos no histórico, salva-los e mostrar os dados da caderneta, mas a busca de novos CEPs requer conexão com a internet.

## 🚀 Como Executar o Projeto

1. Clone este repositório:
   ```bash
   git clone https://github.com/barretoalecio/carlos-cep-finder.git
   
2. Realize um pub get:
   ```bash
   flutter pub get
   
3. Realize um pub get:
   ```bash
   flutter run
   
## Demonstração 🎥

[Clique aqui para acessar a demonstração do projeto](https://www.youtube.com/watch?v=Ttp9EdzOddQ)

## 📱 APK

[Baixe a APK desse projeto aqui](https://drive.google.com/drive/folders/1d5tcVO7K1KbZsrU7OyxGt-z8jA7X9v1a?usp=sharing)