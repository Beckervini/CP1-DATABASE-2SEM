# Dicionário de Dados

Este é o dicionário de dados detalhado que documenta a estrutura e o significado dos dados armazenados nas tabelas do projeto.

## Tabela: DIM_CLIENTE

| Coluna       | Tipo de Dado   | Restrição     | Descrição                                                                              |
|--------------|----------------|---------------|----------------------------------------------------------------------------------------|
| COD_CLIENTE  | NUMBER         | PK            | Código único que identifica cada cliente.                                               |
| NOM_CLIENTE  | VARCHAR2(50)   | NOT NULL      | Nome completo do cliente.                                                              |

## Tabela: DIM_PRODUTO

| Coluna       | Tipo de Dado   | Restrição     | Descrição                                                                              |
|--------------|----------------|---------------|----------------------------------------------------------------------------------------|
| COD_PRODUTO  | NUMBER         | PK            | Código único que identifica cada produto.                                               |
| NOM_PRODUTO  | VARCHAR2(100)  | NOT NULL      | Nome completo do produto.                                                              |
| STA_ATIVO    | CHAR(1)        | NOT NULL      | Indica se o produto está ativo ou inativo no sistema. Valores possíveis: 'A' (Ativo), 'I' (Inativo). |

## Tabela: DIM_TEMPO

| Coluna       | Tipo de Dado   | Restrição     | Descrição                                                                              |
|--------------|----------------|---------------|----------------------------------------------------------------------------------------|
| COD_TEMPO    | NUMBER         | PK            | Código único que identifica o tempo (data).                                             |
| ANO          | NUMBER         | NOT NULL      | Ano do evento de venda ou outra transação.                                             |
| MES          | NUMBER         | NOT NULL      | Mês do evento de venda ou outra transação.                                             |
| DIA          | NUMBER         | NOT NULL      | Dia do evento de venda ou outra transação.                                             |

## Tabela: DIM_VENDEDOR

| Coluna       | Tipo de Dado   | Restrição     | Descrição                                                                              |
|--------------|----------------|---------------|----------------------------------------------------------------------------------------|
| COD_VENDEDOR | NUMBER         | PK            | Código único que identifica cada vendedor.                                             |
| NOM_VENDEDOR | VARCHAR2(50)   | NOT NULL      | Nome completo do vendedor.                                                            |

## Tabela: FATO_VENDAS

| Coluna        | Tipo de Dado   | Restrição     | Descrição                                                                              |
|---------------|----------------|---------------|----------------------------------------------------------------------------------------|
| COD_VENDA     | NUMBER         | PK            | Código único da transação de venda.                                                    |
| COD_CLIENTE   | NUMBER         | FK -> DIM_CLIENTE(COD_CLIENTE) | Referência ao cliente que realizou a compra.                                      |
| COD_PRODUTO   | NUMBER         | FK -> DIM_PRODUTO(COD_PRODUTO) | Referência ao produto que foi vendido.                                             |
| COD_TEMPO     | NUMBER         | FK -> DIM_TEMPO(COD_TEMPO)     | Referência ao tempo (data) em que a venda foi realizada.                            |
| COD_VENDEDOR  | NUMBER         | FK -> DIM_VENDEDOR(COD_VENDEDOR) | Referência ao vendedor responsável pela venda.                                    |
| QTD_VENDIDA   | NUMBER         | NOT NULL      | Quantidade de produtos vendidos na transação.                                         |
| VALOR_TOTAL   | NUMBER(12, 2)  | NOT NULL      | Valor total da venda, considerando a quantidade e o preço unitário do produto.        |

## Tabela: AUDITORIA_DIMENSOES

| Coluna         | Tipo de Dado   | Restrição     | Descrição                                                                              |
|----------------|----------------|---------------|----------------------------------------------------------------------------------------|
| ID_AUDITORIA   | NUMBER         | PK            | Código único que identifica cada registro de auditoria.                                |
| NOME_TABELA    | VARCHAR2(100)  | NOT NULL      | Nome da tabela de dimensão que sofreu a operação de inserção.                          |
| OPERACAO       | VARCHAR2(10)   | NOT NULL      | Tipo de operação (neste caso, sempre será 'INSERT').                                   |
| DATA_OPERACAO  | DATE           | NOT NULL      | Data e hora em que a operação foi realizada.                                           |
| USUARIO        | VARCHAR2(50)   | NOT NULL      | Nome do usuário que realizou a operação.                                               |
| DADOS_INSERIDOS| VARCHAR2(4000) | NOT NULL      | Detalhes dos dados que foram inseridos na operação.                                    |

## Resumo das Chaves Primárias (PK) e Chaves Estrangeiras (FK)

- **DIM_CLIENTE**
  - PK: `COD_CLIENTE`
  
- **DIM_PRODUTO**
  - PK: `COD_PRODUTO`
  
- **DIM_TEMPO**
  - PK: `COD_TEMPO`
  
- **DIM_VENDEDOR**
  - PK: `COD_VENDEDOR`

- **FATO_VENDAS**
  - PK: `COD_VENDA`
  - FK: `COD_CLIENTE` -> `DIM_CLIENTE(COD_CLIENTE)`
  - FK: `COD_PRODUTO` -> `DIM_PRODUTO(COD_PRODUTO)`
  - FK: `COD_TEMPO` -> `DIM_TEMPO(COD_TEMPO)`
  - FK: `COD_VENDEDOR` -> `DIM_VENDEDOR(COD_VENDEDOR)`

- **AUDITORIA_DIMENSOES**
  - PK: `ID_AUDITORIA`

  Descrição Geral
DIM_CLIENTE: Tabela de dimensão que armazena os clientes do sistema, com nome e um código único para cada cliente.

DIM_PRODUTO: Armazena informações sobre os produtos, como código, nome e status (ativo ou inativo).

DIM_TEMPO: Representa a dimensão temporal, armazenando ano, mês e dia de cada transação ou evento no sistema.

DIM_VENDEDOR: Contém informações sobre os vendedores, incluindo o nome e o código de cada um.

FATO_VENDAS: Tabela de fatos que armazena as transações de vendas, relacionando os clientes, produtos, datas e vendedores, além de armazenar as quantidades vendidas e o valor total de cada venda.

AUDITORIA_DIMENSOES: Tabela de auditoria que registra as operações de inserção realizadas nas tabelas de dimensão. Esta tabela é usada para manter um histórico de modificações e garantir rastreabilidade.


