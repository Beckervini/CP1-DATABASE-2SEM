CREATE OR REPLACE PROCEDURE LOAD_DIM_CLIENTE IS
BEGIN
    INSERT INTO DIM_CLIENTE (
        COD_CLIENTE,
        NOM_CLIENTE
    )
        SELECT
            DISTINCT COD_CLIENTE,
            NOM_CLIENTE
        FROM
            CLIENTE C;
END LOAD_DIM_CLIENTE;

EXCEPTION
    WHEN OTHERS THEN
        -- Tratamento de exceções gerais
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao carregar dados em DIM_CLIENTE: ' || SQLERRM);
END LOAD_DIM_CLIENTE;
/

CREATE OR REPLACE PROCEDURE LOAD_DIM_PRODUTO IS
BEGIN
    INSERT INTO DIM_PRODUTO (
        COD_PRODUTO,
        NOM_PRODUTO,
        STA_ATIVO
    )
        SELECT
            DISTINCT COD_PRODUTO,
            NOM_PRODUTO,
            STA_ATIVO
        FROM
            PRODUTO;
END LOAD_DIM_PRODUTO;

EXCEPTION
    WHEN OTHERS THEN
        -- Tratamento de exceções gerais
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao carregar dados em DIM_PRODUTO: ' || SQLERRM);
END LOAD_DIM_PRODUTO;
/
CREATE OR REPLACE PROCEDURE LOAD_DIM_PRODUTO IS
BEGIN
    INSERT INTO DIM_PRODUTO (
        COD_PRODUTO,
        NOM_PRODUTO,
        STA_ATIVO
    )
    SELECT DISTINCT
        COD_PRODUTO,
        NOM_PRODUTO,
        STA_ATIVO
    FROM
        PRODUTO;
    
    COMMIT;
END LOAD_DIM_PRODUTO;
/
CREATE OR REPLACE PROCEDURE LOAD_DIM_TEMPO IS
BEGIN
    
    INSERT INTO DIM_TEMPO (
        COD_TEMPO,   
        ANO,        
        MES,         
        DIA  
    )        
    SELECT DISTINCT
        TO_NUMBER(TO_CHAR(DAT_PEDIDO, 'YYYYMMDD')) AS COD_TEMPO,  
        TO_NUMBER(TO_CHAR(DAT_PEDIDO, 'YYYY')) AS ANO,          
        TO_NUMBER(TO_CHAR(DAT_PEDIDO, 'MM')) AS MES,              
        TO_NUMBER(TO_CHAR(DAT_PEDIDO, 'DD')) AS DIA               
        PEDIDO; 
    
   
    COMMIT;
END LOAD_DIM_TEMPO;

WHEN OTHERS THEN
        -- Tratamento de exceções gerais
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao carregar dados em DIM_TEMPO: ' || SQLERRM);
END LOAD_DIM_TEMPO;
/

/
CREATE OR REPLACE PROCEDURE LOAD_DIM_VENDEDOR IS
BEGIN
    INSERT INTO DIM_VENDEDOR (
        COD_VENDEDOR,
        NOM_VENDEDOR
    )
    SELECT DISTINCT
        COD_VENDEDOR,
        NOM_VENDEDOR
    FROM
        VENDEDOR;
    
    COMMIT;
END LOAD_DIM_VENDEDOR;

EXCEPTION
    WHEN OTHERS THEN
        -- Tratamento de exceções gerais
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao carregar dados em DIM_VENDEDOR: ' || SQLERRM);
END LOAD_DIM_VENDEDOR;
/
CREATE OR REPLACE PROCEDURE LOAD_FATO_VENDAS IS
BEGIN
    INSERT INTO FATO_VENDAS (
        COD_VENDA,
        COD_CLIENTE,
        COD_PRODUTO,
        COD_TEMPO,
        COD_VENDEDOR,
        QTD_VENDIDA,
        VALOR_TOTAL
    )
    SELECT
        P.COD_PEDIDO,                              -- Código do Pedido
        P.COD_CLIENTE,                             -- Código do Cliente
        IP.COD_PRODUTO,                            -- Código do Produto
        (SELECT T.COD_TEMPO                        
         FROM DIM_TEMPO T
         WHERE T.ANO = EXTRACT(YEAR FROM P.DAT_PEDIDO)
         AND T.MES = EXTRACT(MONTH FROM P.DAT_PEDIDO)
         AND T.DIA = EXTRACT(DAY FROM P.DAT_PEDIDO)) AS COD_TEMPO,  -- Código do Tempo
        P.COD_VENDEDOR,                            -- Código do Vendedor
        IP.QTD_ITEM,                               -- Quantidade Vendida
        (IP.VAL_UNITARIO_ITEM * IP.QTD_ITEM) AS VALOR_TOTAL  -- Valor Total da Venda
    FROM 
        PEDIDO P
    JOIN 
        ITEM_PEDIDO IP ON P.COD_PEDIDO = IP.COD_PEDIDO;
    
    COMMIT;
END LOAD_FATO_VENDAS;

EXCEPTION
    WHEN OTHERS THEN
        -- Tratamento de exceções gerais
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao carregar dados em FATO_VENDAS: ' || SQLERRM);
END LOAD_FATO_VENDAS;
/

SHOW ERRORS PROCEDURE LOAD_DIM_TEMPO;
SELECT * FROM ALL_TABLES WHERE TABLE_NAME = 'TEMP';
