


# CollectionView
![](https://badgen.net/badge/iOS/13/blue) ![](https://badgen.net/badge/Swift/5/orange)

# Desafio:
Utilizar JSON para fazer parse do nosso conteúdo. Seu desafio é muito simples: Você deve realizar parse desta url (https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products) para construir a tela a seguir.


## Screenshots 
<img src="https://github.com/guilhermeRangel/CollectionViewWithAPI/blob/master/CollectionViewWithAPI/ImagesUrl/home1.png" alt="alt text" width="260">  <img src="https://github.com/guilhermeRangel/CollectionViewWithAPI/blob/master/CollectionViewWithAPI/ImagesUrl/home2.png" alt="alt text" width="260">
<img src="https://github.com/guilhermeRangel/CollectionViewWithAPI/blob/master/CollectionViewWithAPI/ImagesUrl/details1.png" alt="alt text" width="260"> <img src="https://github.com/guilhermeRangel/CollectionViewWithAPI/blob/master/CollectionViewWithAPI/ImagesUrl/details2.png" alt="alt text" width="260"> 

## Instalação

Para fazer o dowload do repositorio 

```
git clone https://github.com/guilhermeRangel/CollectionViewWithAPI.git

```

Em seguida, instale bibliotecas de terceiros

```
pod install
```


# Sobre o projeto
Projeto desenvolvido na linguagem swift com arquitetura MVVM + Coordinator

# Dificuldades encontradas
- Em um primeiro momento idealizei a arquitetura dos componentes sendo duas collection view e uma table view, após percebi que o melhor seria ser uma table view onde cada celula da table conteria uma collection view com celular reutilizaveis e para cada celular da table view conteria um titulo em sua section, devido ao curto prazo não reeimplementei.
- Tive algumas dificuldades para adicionr o Header na collection view devido ao seu comportamento de scroll horizontal, 

# Proximos Passos
- Melhorar a Reability.
- Refatorar arquitetura dos componentes do projeto.
- Adicionar placeholder nas imagens até ser realizado o download das imagens da API.
- Adicionar Cache para imagens.
- Refatorar código
