-- projeto_2_DIO.sql
-- Compatível: MySQL 8.0+

DROP DATABASE IF EXISTS `projeto_2_DIO`;
CREATE DATABASE IF NOT EXISTS `projeto_2_DIO`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE `projeto_2_DIO`;

CREATE TABLE `Cliente` (
  `ClienteID` INT PRIMARY KEY,
  `Email` VARCHAR(45),
  `Nome` VARCHAR(100),
  `TipoConta` CHAR(2) CHECK (`TipoConta` IN ('PF', 'PJ')),
  `CPF` VARCHAR(11) NULL,
  `CNPJ` VARCHAR(14) NULL,
  `Telefone` VARCHAR(45),
  `Endereço` VARCHAR(100),
  `Cidade` VARCHAR(15),
  `Estado` CHAR(2),
  `CEP` CHAR(8),
  CONSTRAINT `chk_cliente_tipo` CHECK (
    (`TipoConta` = 'PF' AND `CPF` IS NOT NULL AND `CNPJ` IS NULL) OR
    (`TipoConta` = 'PJ' AND `CNPJ` IS NOT NULL AND `CPF` IS NULL)
  )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Fornecedor` (
  `FornecedorID` INT PRIMARY KEY,
  `Nome` VARCHAR(100) NOT NULL,
  `Endereco` VARCHAR(255),
  `Cidade` VARCHAR(10),
  `Estado` CHAR(2),
  `CNPJ` VARCHAR(14),
  `Email` VARCHAR(40),
  `Telefone` VARCHAR(15)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Produto` (
  `ProdutoID` INT PRIMARY KEY,
  `Nome` VARCHAR(100) NOT NULL,
  `Descricao` TEXT,
  `Preco` DECIMAL(10, 2),
  `Estoque` INT,
  `FornecedorID` INT,
  `Categoria` VARCHAR(45),
  `Marcar` VARCHAR(45),
  FOREIGN KEY (`FornecedorID`) REFERENCES `Fornecedor`(`FornecedorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Pedido` (
  `PedidoID` INT PRIMARY KEY,
  `ClienteID` INT,
  `DataPedido` DATE,
  `ValorTotal` DECIMAL(10,2),
  `StatusPedido` VARCHAR(45),
  FOREIGN KEY (`ClienteID`) REFERENCES `Cliente`(`ClienteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `PedidoProduto` (
  `PedidoID` INT,
  `ProdutoID` INT,
  `Quantidade` INT,
  `PrecoUnitario` DECIMAL(10,2),
  PRIMARY KEY (`PedidoID`, `ProdutoID`),
  FOREIGN KEY (`PedidoID`) REFERENCES `Pedido`(`PedidoID`),
  FOREIGN KEY (`ProdutoID`) REFERENCES `Produto`(`ProdutoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Pagamento` (
  `PagamentoID` INT PRIMARY KEY,
  `ClienteID` INT,
  `FormaPagamento` VARCHAR(50),
  `DataRegistro` DATE,
  `Ativa` BOOLEAN,
  FOREIGN KEY (`ClienteID`) REFERENCES `Cliente`(`ClienteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Entrega` (
  `EntregaID` INT PRIMARY KEY,
  `PedidoID` INT,
  `StatusEntrega` VARCHAR(50),
  `CodigoRastreamento` VARCHAR(100),
  `DataEnvio` DATE,
  `DataEntregaPrevista` DATE,
  `DataEntregaReal` DATE,
  FOREIGN KEY (`PedidoID`) REFERENCES `Pedido`(`PedidoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dados ---------------------------------------------

-- Cliente (PF)
INSERT INTO `Cliente` (`ClienteID`, `Nome`, `TipoConta`, `CPF`, `Email`, `Telefone`, `Endereço`, `Cidade`, `Estado`, `CEP`)
VALUES 
(1, 'João Silva', 'PF', '12345678901', 'joao@email.com', '11987654321', 'Rua A, 123', 'São Paulo', 'SP', '01234567'),
(2, 'Maria Santos', 'PF', '98765432100', 'maria@email.com', '11987654322', 'Av. B, 456', 'Rio de Janeiro', 'RJ', '20123456'),
(3, 'Pedro Oliveira', 'PF', '11122233344', 'pedro@email.com', '21987654323', 'Rua C, 789', 'Belo Horizonte', 'MG', '30123456');

-- Cliente (PJ)
INSERT INTO `Cliente` (`ClienteID`, `Nome`, `TipoConta`, `CNPJ`, `Email`, `Telefone`, `Endereço`, `Cidade`, `Estado`, `CEP`)
VALUES 
(4, 'Empresa XYZ LTDA', 'PJ', '12345678000190', 'contato@empresaxyz.com', '1133334444', 'Av. Principal, 1000', 'São Paulo', 'SP', '01567890'),
(5, 'Tech Solutions SA', 'PJ', '98765432000100', 'vendas@techsolutions.com', '1144445555', 'Rua Tech, 2000', 'Brasília', 'DF', '70123456');

-- Fornecedor
INSERT INTO `Fornecedor` (`FornecedorID`, `Nome`, `Endereco`, `Cidade`, `Estado`, `CNPJ`, `Email`, `Telefone`)
VALUES 
(1, 'Fornecedor Tech', 'Rua dos Fornecedores, 100', 'São Paulo', 'SP', '11122233000100', 'contato@fornecedortech.com', '1122223333'),
(2, 'Distribuidor Brasil', 'Av. Comercial, 500', 'Curitiba', 'PR', '22233344000200', 'vendas@distribuidor.com', '4133334444'),
(3, 'Imports Eletrônicos', 'Rod. BR-116, km 50', 'Salvador', 'BA', '33344455000300', 'imports@eletro.com', '7144445555');

-- Produto
INSERT INTO `Produto` (`ProdutoID`, `Nome`, `Descricao`, `Preco`, `Estoque`, `FornecedorID`, `Categoria`, `Marcar`)
VALUES 
(1, 'Notebook Dell Inspiron', 'Notebook 15 polegadas, Intel i5, 8GB RAM', 3500.00, 15, 1, 'Computadores', 'Dell'),
(2, 'Mouse Logitech Sem Fio', 'Mouse óptico sem fio, alcance 10m', 89.90, 50, 1, 'Periféricos', 'Logitech'),
(3, 'Teclado Mecânico RGB', 'Teclado gaming com switches mecânicos', 450.00, 25, 2, 'Periféricos', 'Corsair'),
(4, 'Monitor LG 24 polegadas', 'Monitor Full HD, IPS, 60Hz', 899.00, 10, 3, 'Monitores', 'LG'),
(5, 'Webcam Logitech HD', 'Webcam 1080p com microfone integrado', 199.90, 30, 1, 'Periféricos', 'Logitech');

-- Pedido
INSERT INTO `Pedido` (`PedidoID`, `ClienteID`, `DataPedido`, `ValorTotal`, `StatusPedido`)
VALUES 
(1, 1, '2025-10-15', 3589.90, 'Entregue'),
(2, 2, '2025-10-20', 450.00, 'Em Processamento'),
(3, 3, '2025-10-25', 899.00, 'Enviado'),
(4, 4, '2025-11-01', 10450.00, 'Entregue'),
(5, 1, '2025-11-15', 1348.90, 'Pendente');

-- PedidoProduto (N:N)
INSERT INTO `PedidoProduto` (`PedidoID`, `ProdutoID`, `Quantidade`, `PrecoUnitario`)
VALUES 
(1, 1, 1, 3500.00),
(1, 2, 1, 89.90),
(2, 3, 1, 450.00),
(3, 4, 1, 899.00),
(4, 1, 2, 3500.00),
(4, 5, 1, 199.90),
(5, 2, 2, 89.90),
(5, 3, 1, 450.00);

-- Pagamento
INSERT INTO `Pagamento` (`PagamentoID`, `ClienteID`, `FormaPagamento`, `DataRegistro`, `Ativa`)
VALUES 
(1, 1, 'Cartão de Crédito', '2025-10-10', 1),
(2, 1, 'PIX', '2025-10-15', 1),
(3, 2, 'Boleto Bancário', '2025-10-18', 1),
(4, 3, 'Cartão de Débito', '2025-10-20', 1),
(5, 4, 'Cartão de Crédito', '2025-10-25', 1),
(6, 4, 'Transferência Bancária', '2025-11-01', 1);

-- Entrega
INSERT INTO `Entrega` (`EntregaID`, `PedidoID`, `StatusEntrega`, `CodigoRastreamento`, `DataEnvio`, `DataEntregaPrevista`, `DataEntregaReal`)
VALUES 
(1, 1, 'Entregue', 'BR123456789BR', '2025-10-16', '2025-10-20', '2025-10-19'),
(2, 2, 'Em Transporte', 'BR987654321BR', '2025-10-21', '2025-10-25', NULL),
(3, 3, 'Enviado', 'BR555666777BR', '2025-10-26', '2025-10-30', NULL),
(4, 4, 'Entregue', 'BR111222333BR', '2025-11-02', '2025-11-05', '2025-11-04'),
(5, 5, 'Pendente', NULL, NULL, '2025-11-20', NULL);

-- Consultas -----------------------------------------

SELECT `ClienteID`, COUNT(*) AS `TotalPedidos`
FROM `Pedido`
GROUP BY `ClienteID`
ORDER BY `TotalPedidos` DESC;

SELECT P.`Nome` AS `Produto`, F.`Nome` AS `Fornecedor`, P.`Estoque`
FROM `Produto` P
JOIN `Fornecedor` F ON P.`FornecedorID` = F.`FornecedorID`
ORDER BY F.`Nome`, P.`Nome`;

SELECT F.`Nome` AS `Fornecedor`, P.`Nome` AS `Produto`
FROM `Fornecedor` F
JOIN `Produto` P ON F.`FornecedorID` = P.`FornecedorID`
ORDER BY F.`Nome`, P.`Nome`;

SELECT 
  c.`ClienteID`,
  c.`Nome`,
  c.`TipoConta`,
  COUNT(p.`PedidoID`) AS `TotalPedidos`
FROM `Cliente` c
LEFT JOIN `Pedido` p ON c.`ClienteID` = p.`ClienteID`
GROUP BY c.`ClienteID`, c.`Nome`, c.`TipoConta`
ORDER BY `TotalPedidos` DESC;

SELECT 
  c.`Nome` AS `Cliente`,
  p.`Nome` AS `Produto`,
  pp.`Quantidade`,
  pp.`PrecoUnitario`,
  pe.`DataPedido`
FROM `Pedido` pe
JOIN `Cliente` c ON pe.`ClienteID` = c.`ClienteID`
JOIN `PedidoProduto` pp ON pe.`PedidoID` = pp.`PedidoID`
JOIN `Produto` p ON pp.`ProdutoID` = p.`ProdutoID`
ORDER BY pe.`DataPedido` DESC, c.`Nome`;

SELECT 
  c.`Nome` AS `Cliente`,
  p.`Nome` AS `Produto`,
  pp.`Quantidade`
FROM `Pedido` pe
JOIN `Cliente` c ON pe.`ClienteID` = c.`ClienteID`
JOIN `PedidoProduto` pp ON pe.`PedidoID` = pp.`PedidoID`
JOIN `Produto` p ON pp.`ProdutoID` = p.`ProdutoID`
WHERE c.`Nome` LIKE 'A%'
ORDER BY c.`Nome`, p.`Nome`;

SELECT 
  MONTH(pe.`DataPedido`) AS `Mes`,
  YEAR(pe.`DataPedido`) AS `Ano`,
  SUM(pe.`ValorTotal`) AS `FaturamentoMensal`
FROM `Pedido` pe
GROUP BY `Mes`, `Ano`
ORDER BY `Ano` DESC, `Mes` DESC;

SELECT 
  p.`ProdutoID`,
  p.`Nome`,
  p.`Estoque`,
  f.`Nome` AS `Fornecedor`
FROM `Produto` p
JOIN `Fornecedor` f ON p.`FornecedorID` = f.`FornecedorID`
WHERE p.`Estoque` < 5
ORDER BY p.`Estoque` ASC;

SELECT 
  c.`ClienteID`,
  c.`Nome`,
  COUNT(p.`PedidoID`) AS `TotalPedidos`
FROM `Cliente` c
JOIN `Pedido` p ON c.`ClienteID` = p.`ClienteID`
GROUP BY c.`ClienteID`, c.`Nome`
HAVING COUNT(p.`PedidoID`) > 2
ORDER BY `TotalPedidos` DESC;

SELECT 
  pe.`PedidoID`,
  c.`Nome` AS `Cliente`,
  pe.`DataPedido`,
  pe.`ValorTotal`
FROM `Pedido` pe
JOIN `Cliente` c ON pe.`ClienteID` = c.`ClienteID`
WHERE pe.`ValorTotal` > (SELECT AVG(`ValorTotal`) FROM `Pedido`)
ORDER BY pe.`ValorTotal` DESC;

SELECT 
  f.`Nome` AS `Fornecedor`,
  p.`Nome` AS `Produto`,
  p.`Estoque`,
  p.`Preco`
FROM `Fornecedor` f
LEFT JOIN `Produto` p ON f.`FornecedorID` = p.`FornecedorID`
ORDER BY f.`Nome`, p.`Nome`;

SELECT 
  c.`ClienteID`,
  c.`Nome`,
  pag.`FormaPagamento`,
  pag.`DataRegistro`
FROM `Cliente` c
JOIN `Pagamento` pag ON c.`ClienteID` = pag.`ClienteID`
ORDER BY c.`Nome`, pag.`DataRegistro` DESC;
