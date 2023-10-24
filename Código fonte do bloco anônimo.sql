SET SERVEROUTPUT ON;

DECLARE 
    CURSOR c_sac IS 
     
     SELECT 
  sac.nr_sac, 
  sac.dt_abertura_sac, 
  sac.hr_abertura_sac, 
  sac.tp_sac, 
  produto.cd_produto, 
  produto.ds_produto, 
  produto.vl_perc_lucro, 
  produto.vl_unitario,
  estado.sg_estado,
  estado.nm_estado, 
  cliente.nr_cliente, 
  cliente.nm_cliente,
 
      CASE 
  WHEN sac.tp_sac= 'S' THEN 'SUGESTÃO' 
  WHEN sac.tp_sac= 'D' THEN 'DÚVIDA'
  WHEN sac.tp_sac= 'E' THEN 'ELOGIO'
  ELSE 'CLASSIFICAÇÃO INVÁLIDA'
  END as ds_tipo_classificacao_sac 
  
  FROM mc_sgv_sac sac 
  
  JOIN mc_produto produto ON sac.cd_produto = produto.cd_produto
  JOIN mc_cliente cliente ON sac.nr_cliente = cliente.nr_cliente 
  JOIN mc_end_cli endcliente ON sac.nr_cliente = endcliente.nr_cliente
  JOIN mc_logradouro l ON l.cd_logradouro = endcliente.cd_logradouro_cli
  JOIN mc_bairro b ON b.cd_bairro = l.cd_bairro
  JOIN mc_cidade c ON c.cd_cidade = b.cd_cidade
  JOIN mc_estado estado ON estado.sg_estado = c.sg_estado;
  
  BEGIN
  
       
    FOR linha in c_sac LOOP
    
       DBMS_OUTPUT.PUT_LINE('REGISTROS DA TABELA SAC');
       DBMS_OUTPUT.PUT_LINE('-------------------------');
       DBMS_OUTPUT.PUT_LINE('Número do SAC : ' || linha.nr_sac);
       DBMS_OUTPUT.PUT_LINE('Data de abertura SAC: ' || linha.dt_abertura_sac);
       DBMS_OUTPUT.PUT_LINE('Hora de abertura SAC: ' || linha.hr_abertura_sac);
       DBMS_OUTPUT.PUT_LINE('Tipo de SAC: ' || linha.ds_tipo_classificacao_sac);
       DBMS_OUTPUT.PUT_LINE('Código do produto: ' || linha.cd_produto);
       DBMS_OUTPUT.PUT_LINE('Nome do produto: '|| linha.ds_produto);
       DBMS_OUTPUT.PUT_LINE('Valor unitário do produto:' || linha.vl_unitario);
       DBMS_OUTPUT.PUT_LINE('Número do cliente:' || linha.nr_cliente);
       DBMS_OUTPUT.PUT_LINE('Nome do cliente: '|| linha.nm_cliente);
       DBMS_OUTPUT.PUT_LINE('Estado: '|| linha.sg_estado);
       DBMS_OUTPUT.PUT_LINE('Nome do estado: '|| linha.nm_estado); 
     
      
      INSERT INTO mc_sgv_ocorrencia_sac (nr_ocorrencia_sac, dt_abertura_sac, 
      hr_abertura_sac, ds_tipo_classificacao_sac, cd_produto, ds_produto, vl_unitario_produto, 
      vl_perc_lucro, nr_cliente, nm_cliente, sg_estado, nm_estado) VALUES (
  linha.nr_sac, linha.dt_abertura_sac, 
  linha.hr_abertura_sac, linha.ds_tipo_classificacao_sac, 
  linha.cd_produto, linha.ds_produto, linha.vl_unitario, 
  linha.vl_perc_lucro, linha.nr_cliente, linha.nm_cliente,
  linha.sg_estado, linha.nm_estado);
  

      END LOOP; 
       
       commit;          
  END;
  /
    
 

  
  
  
  
  
  
   

  


