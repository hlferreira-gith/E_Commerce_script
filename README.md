# E_Commerce_script
Projeto 2 DIO — Banco de Dados MySQL (E-commerce)
Script único MySQL 8.0+ contendo criação do banco e tabelas, carga inicial (seed) e consultas de exemplo. Estrutura contempla clientes PF/PJ, fornecedores, produtos, pedidos, pagamentos e entregas.

Arquivo: projeto_2_DIO.sql
Compatibilidade: MySQL 8.0+
O que está incluído
Criação do banco projeto_2_DIO (utf8mb4, InnoDB)
Tabelas: Cliente, Fornecedor, Produto, Pedido, PedidoProduto, Pagamento, Entrega
Restrições:
Cliente.TipoConta com CHECK ('PF' | 'PJ')
Consistência de documentos: CPF somente para PF, CNPJ somente para PJ
FKs entre tabelas
Correções mínimas para execução:
Pedido.ValorTotal como DECIMAL(10,2)
Inclusão de PedidoProduto.PrecoUnitario
Identificadores com acentuação escapados com crases (ex.: Endereço)
Seed com dados de exemplo
Consultas SQL (relatórios e análises)
Requisitos
MySQL 8.0+ (CHECK constraints ativas a partir do 8.0.16)
Cliente MySQL (mysql)
Como executar
1) Local (MySQL instalado)
2) Consultas incluídas (exemplos)
Pedidos por cliente (contagem)
Produtos e estoque por fornecedor
Fornecedores e seus produtos
Total de pedidos por cliente (inclui quem não tem pedido)
Itens por pedido com preço unitário
Clientes cujo nome inicia com 'A'
Faturamento mensal (mês/ano)
Produtos com baixo estoque
Clientes com mais de 2 pedidos
Pedidos com valor acima da média
Fornecedores e seus produtos (LEFT JOIN)
Formas de pagamento por cliente
Todas as consultas estão no final do arquivo projeto_2_DIO.sql e podem ser executadas após o seed.

# *Observações*
Tipo BOOLEAN no MySQL mapeia para TINYINT(1). Valores usados: 0/1.
O script recria o banco (DROP DATABASE IF EXISTS). Use com cautela em ambientes com dados.
Licença
MIT — ajuste o autor/ano conforme necessário.
