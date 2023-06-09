/* REGRA DE NEGÓCIO

	* EMPRESA PARA TÉCNICO
    
		UMA EMPRESA PODE RECEBER UMA VISITA DE MUITOS TÉCNICOS;
        UM TÉCNICO PODE VISITAR VÁRIAS EMPRESAS;
		À PARTIR DISSO CRIA-SE A TABELA VISITA.
        
        RELAÇÃO N:N.
        
	* EMPRESA PARA TOKEN
    
		UMA EMPRESA POSSUI SOMENTE UM TOKEN;
        UM TOKEN SÓ PODE PERTENCER A UM USUÁRIO.
        
        RELAÇÃO 1:1
        
	* EMPRESA PARA USUÁRIO:
    
		UMA EMPRESA PODE TER MUITOS USUÁRIOS;
		UM USUÁRIO SÓ PODE SER DE UMA EMPRESA.
        
        RELAÇÃO 1:N.
      
	* EMPRESA PARA SETOR
	
		UMA EMPRESA PODE POSSUI MUITOS SETORES;
		UM SETOR SÓ PODE SER DE UMA EMPRESA.
        
        RELAÇÃO 1:N.
    
    * SETOR PARA SENSOR
    
		UM SETOR/LOCAL PODE TER VÁRIOS SENSORES;
		UM SENSOR SÓ PODE ESTAR EM UM SETOR/LOCAL;
        
        RELAÇÃO 0:N.
    
    * SENSOR PARA REGISTRO / DADOS_SENSOR
    
		UM SENSOR PODE TER MUITOS REGISTROS;
		UM REGISTRO SÓ PODE SER DE UM SENSOR;
        
        RELAÇÃO 0:N.

*/

-- CRIANDO O BANCO DE DADOS

	CREATE DATABASE DataCooling1;

-- SELECIONANDO O BANCO DE DADOS

	USE DataCooling1;
    
-- TABELA DO TÉCNICO
		
	CREATE TABLE Tecnico (
    idTecnico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    cpf CHAR(11) NOT NULL
    );
    
-- INSERÇÃO DE REGISTROS NA TABELA DE EMPRESA

	INSERT INTO Tecnico VALUES
		(null, 'Jefferson', 'Dantas', '10230240342'),
		(null, 'Rebecca', 'Barros', '89027467320'),
		(null, 'Patrícia', 'Fernandez', '48117927942');
        
-- EXIBINDO OS DADOS DA TABELA TÉCNICO

	SELECT * FROM Tecnico;
        
-- TABELA DA EMPRESA

	CREATE TABLE Empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
	razaoSocial VARCHAR(45) NOT NULL,
	cnpj CHAR(14) NOT NULL UNIQUE,
	telFixo CHAR(14),
	cep CHAR(9) NOT NULL,
    numero INT NOT NULL
	);
        
-- INSERÇÃO DE REGISTROS NA TABELA DE EMPRESA

	INSERT INTO Empresa VALUES
		(null, 'Elena Datacenter', '01234567890003', null, '08594003', 1200),
		(null, 'Luiza Datacenter', '08924567895783', null, '03891003', 875),
		(null, 'Bambam Datacenter', '01234590174838', null, '05898403', 478);
        
-- EXIBINDO OS DADOS DA TABELA DE EMPRESA

	SELECT * FROM Empresa;
    
-- TABELA DA VISITA (ASSOCIATIVA)

	CREATE TABLE Visita (
    idVisita INT AUTO_INCREMENT,
    fkTecnico INT NOT NULL,
    fkEmpresa INT NOT NULL,
    dtVisita DATE NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    CONSTRAINT fkTecnicoVisita FOREIGN KEY (fkTecnico) REFERENCES Tecnico(idTecnico),
    CONSTRAINT fkEmpresaVisita FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    CONSTRAINT pkCompostaVisita PRIMARY KEY (idVisita, fkTecnico, fkEmpresa)
    ) AUTO_INCREMENT = 1000;
        
-- INSERÇÃO DE REGISTROS NA TABELA DE VISITA

	INSERT INTO Visita VALUES
		(null, 2, 1, '2023-04-21', 'Instalação'),
		(null, 1, 3, '2023-05-04', 'Instalação'),
		(null, 3, 2, '2023-05-02', 'Instalação'),
		(null, 2, 1, '2023-05-25', 'Manutenção'),
		(null, 1, 1, '2023-05-29', 'Manutenção'),
		(null, 1, 2, '2023-06-05', 'Manutenção'),
		(null, 3, 3, '2023-06-06', 'Manutenção');
    
-- EXIBINDO OS DADOS DA TABELA DE EMPRESA

	SELECT * FROM Visita;
    
-- TABELA DE TOKEN

	CREATE TABLE Token (
		idToken INT AUTO_INCREMENT,
        fkEmpresa INT,
        valor CHAR(30),
        dtCriacao DATETIME,
        CONSTRAINT fkTokenEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
        CONSTRAINT pkCompostaToken PRIMARY KEY (idToken, fkEmpresa),
        UNIQUE KEY (fkEmpresa)
	)AUTO_INCREMENT = 1000;
    
-- INSERÇÃO DE REGISTROS NA TABELA TOKEN

	INSERT INTO Token VALUES
		(null, 1, 'jfgo95ugi3u98htuh983y9fn949hv3', '2023-05-23 10:37:38', '2023-05-23 11:07:38'),
		(null, 2, 'ibgtio894u8goneh984uoin09490k0', '2023-05-30 18:49:12', '2023-05-30 19:19:12'),
		(null, 3, '3iuhguibiu4i839hngon83u8ngois2', '2023-05-27 19:12:53', '2023-05-27 19:42:53');
                
-- EXIBINDO OS REGISTROS DA TABELA TOKEN
	
    SELECT * FROM Token;
    
-- TABELA DE USUÁRIO DA EMPRESA

	CREATE TABLE Usuario (
	idUsuario INT AUTO_INCREMENT,
	fkEmpresa INT,
	nome VARCHAR(45) NOT NULL,
	sobrenome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    fkUsuarioAdmin INT,
	CONSTRAINT fkEmpresaUsuario FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa), -- FOREIGN KEY PARA IDENTIFICAR A EMPRESA QUE POSSUI O USUÁRIO
	CONSTRAINT fkUsuarioAdmin FOREIGN KEY (fkUsuarioAdmin) REFERENCES Usuario(idUsuario), -- FOREIGN KEY PARA IDENTIFICAR QUEM É O USUÁRIO ADMIN
	CONSTRAINT pkCompostaUsuario PRIMARY KEY (idUsuario, fkEmpresa), -- PRIMARY KEY COMPOSTA DOS CAMPOS FK_EMPRESA E ID_USUARIO
    CONSTRAINT chkEmail CHECK (email LIKE '%@%'),
    UNIQUE KEY (email)
	);

-- INSERÇÃO DOS USUÁRIOS ADMINS NA TABELA DE USUÁRIO

	INSERT INTO Usuario VALUES
		(null, 1, 'Elena', 'Kalika', 'admin@elena.datacenter.', 'LeiteComMangaNaoFazMal', null),
		(null, 2, 'Luíza', 'Venoza', 'admin@luiza.datacenter', 'SalonLine', null),
		(null, 3, 'Kleber', 'Bambam', 'admin@bambam.datacenter', '#Kb0123', null);
        
-- INSERÇÃO DE USUÁRIOS NORMAIS NA TABELA DE USUÁRIO

	INSERT INTO Usuario VALUES
		(null, 1, 'Célia', 'Soares', 'celia.soares@elena.datacenter.com', '#CenterData', 1),
		(null, 2, 'Luís', 'Barros', 'luis.barros@luiza.datacenter', 'XampsonMoraes', 2),
		(null, 2, 'Cássio', 'Dias', 'cassio.dias@luiza.datacenter', '51EhPinga', 2),
		(null, 2, 'Yuri', 'Martins', 'yuri.martins@luiza.datacenter', 'PalmeirasNaoTemMundial', 2),
		(null, 3, 'Martha', 'Santos', 'martha.santos@bambam.datacenter', 'Batata123', 3),
		(null, 3, 'Carolina', 'Bambam', 'carolina@bambam.datacenter', '#Cb0123', 3);
        
-- EXIBINDO OS DADOS DA TABELA DE USUÁRIO

	SELECT * FROM Usuario;
    
-- TABELA DOS SETORES

	CREATE TABLE Setor(
    idSetor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    fkEmpresa INT,
    CONSTRAINT fkSetorEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
    );
    
-- INSERÇÃO DE REGISTROS NA TABELA DE SETORES

	INSERT INTO Setor VALUES
		(null, 'Setor A', 1),
		(null, 'Setor B', 1),
		(null, 'Setor 1', 2),
		(null, 'Setor 2', 2),
		(null, 'Setor 3', 2),
		(null, 'Setor 4', 2),
		(null, 'Setor 5', 2),
		(null, 'Setor 1A', 3),
		(null, 'Setor 1B', 3),
		(null, 'Setor 1C', 3),
		(null, 'Setor 1D', 3);
        
-- EXIBINDO OS DADOS DA TABELA DOS SETORES

	SELECT * FROM Setor;

-- TABELA DO SENSOR

	CREATE TABLE Sensor(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
	statusSensor VARCHAR(15), CONSTRAINT chkStatusSensor CHECK (statusSensor IN ('Ativo', 'Inativo', 'Manutenção')), -- STATUS DO SENSOR PODENDO TER SOMENTE OS TRÊS VALORES DA CHECK
    fkSetor INT,
    CONSTRAINT fkSetorSensor FOREIGN KEY (fkSetor) REFERENCES Setor(idSetor) -- FOREIGN KEY PARA IDENTIFICAR O SETOR QUE ESTÁ LOCALIZADO O SENSOR
	) AUTO_INCREMENT = 100;

-- INSERÇÃO DE REGISTROS NA TABELA DE SENSOR

	INSERT INTO Sensor VALUES
		(null, 'Ativo', 1),
		(null, 'Ativo', 2),
		(null, 'Ativo', 3),
		(null, 'Inativo', 4),
		(null, 'Ativo', 5),
		(null, 'Manutenção', 6),
		(null, 'Ativo', 7),
		(null, 'Ativo', 8),
		(null, 'Ativo', 9),
		(null, 'Ativo', 10),
		(null, 'Manutenção', 11);

-- EXIBINDO OS DADOS DA TABELA DE SENSOR

	SELECT * FROM Sensor;

-- TABELA DOS REGISTROS(DADOS) DO SENSOR

	CREATE TABLE dadosSensor (
	dataHora DATETIME,
	fkSensor INT,
	temperatura DOUBLE,
	umidade DOUBLE,
	CONSTRAINT fkSensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor), -- FOREIGN KEY PARA IDENTIFICAR O SENSOR QUE CAPTA OS DADOS
	CONSTRAINT pkCompostaDados PRIMARY KEY (dataHora, fkSensor)
	);

-- INSERÇÃO DE REGISTRO NA TABELA DE DADOS_SENSOR

	INSERT INTO dadosSensor VALUES
		('2023-06-02 12:20:53', 100, 24, 50),
		('2023-06-02 12:21:03', 100, 23.5, 50),
		('2023-06-02 12:21:23', 101, 24, 49),
		('2023-06-02 12:21:25', 101, 24, 49),
		('2023-06-02 12:21:06', 102, 26, 51),
		('2023-06-02 12:21:10', 102, 45.1, 47),
		('2023-06-02 12:21:20', 103, 46, 47),
		('2023-06-02 12:21:50', 104, 23.5, 50),
		('2023-06-02 12:21:30', 104, 24, 49),
		('2023-06-02 12:21:32', 105, 24, 49),
		('2023-06-02 12:21:33', 105, null, null),
		('2023-06-02 12:21:34', 106, 29, 59),
		('2023-06-02 12:21:35', 106, 45.1, 47),
		('2023-06-02 12:21:36', 107, 46, 47),
		('2023-06-02 12:21:35', 107, 32.1, 57),
		('2023-06-02 12:21:38', 108, 23.4, 49),
		('2023-06-02 12:21:32', 108, 29.1, 65),
		('2023-06-02 12:21:04', 109, 23.2, 62),
		('2023-06-02 12:21:55', 109, 24.5, 47),
		('2023-06-02 12:21:43', 110, null, null),
		('2023-06-02 12:21:22', 110, null, null);
        
	INSERT INTO dadosSensor VALUES
		(now(), 107, 100, 100);
            
-- EXIBINDO OS DADOS DA TABELA DE DADOS_SENSOR

	SELECT * FROM dadosSensor;

-- EXIBINDO OS DADOS DAS QUATRO TABELAS SEPARADAMENTE
	
		SELECT * FROM Tecnico;

		SELECT * FROM Empresa;
        
		SELECT * FROM Visita;
        
        SELECT * FROM Token;
                
		SELECT * FROM Usuario;
        
        SELECT * FROM Setor;
        
		SELECT * FROM Sensor;
        
		SELECT * FROM dadosSensor;

-- EXIBINDO O CEP DAS EMPRESAS QUE POSSUEM DETERMINADO CNPJ

	SELECT cep FROM Empresa WHERE cnpj = '01234567890002';
    
	SELECT cep FROM Empresa WHERE cnpj IN ('01234567890001', '01234567890003');
    
-- EXIBINDO SENSORES ATIVOS, INATIVOS OU EM MANUTENÇÃO

	SELECT * FROM Sensor WHERE statusSensor = 'Ativo';
    
	SELECT * FROM Sensor WHERE statusSensor = 'Inativo';
    
	SELECT * FROM Sensor WHERE statusSensor = 'Manutenção';
    
-- EXIBINDO OS DADOS DO TÉCNICO, DA VISITA E DA RESPECTIVA EMPRESA

	SELECT * FROM Tecnico
		JOIN Visita ON Visita.fkTecnico = Tecnico.idTecnico
			JOIN Empresa ON Visita.fkEmpresa = Empresa.idEmpresa;

-- EXIBINDO A EMPRESA A QUAL O SENSOR PERTENCE

	SELECT Sensor.idSensor, Empresa.razaoSocial AS nomeEmpresa FROM Sensor
		JOIN Setor ON Sensor.fkSetor = Setor.idSetor
			JOIN Empresa ON Setor.fkEmpresa = Empresa.idEmpresa;

-- EXIBINDO A ALOCAÇÃO DO SENSOR E SEU STATUS DE DETERMINADA EMPRESA

	SELECT Setor.nome AS setorAlocacao, Sensor.statusSensor FROM Sensor 
		JOIN Setor ON Setor.idSetor = Sensor.fkSetor
			JOIN Empresa ON Empresa.idEmpresa = Setor.fkEmpresa
				WHERE fkEmpresa = 1;

-- EXIBINDO OS DADOS DE UM SENSOR COM TEMPERATURA E UMIDADE ACIMA DO IDEAL

	SELECT * FROM dadosSensor WHERE temperatura > 27 OR umidade >= 65;

-- EXIBINDO OS DADOS DE UM SENSOR COM TEMPERATURA E UMIDADE IDEAL

	SELECT * FROM dadosSensor WHERE temperatura >= 23 AND temperatura <= 27 OR umidade > 35 AND umidade < 65;

-- EXIBINDO OS DADOS DE UM SENSOR TEMPERATURA E UMIDADE ABAIXO DO IDEAL

	SELECT * FROM dadosSensor WHERE temperatura < 23 OR umidade <= 35;
    
-- EXIBINDO OS DADOS DAS EMPRESAS JUNTO COM SEUS RESPECTIVOS USUÁRIOS

	SELECT * FROM Empresa 
		JOIN Usuario ON Empresa.idEmpresa = Usuario.fkEmpresa;
		
-- EXIBINDO OS DADOS DAS EMPRESAS JUNTO COM SEUS RESPECTIVOS SENSORES

	SELECT * FROM Empresa
		JOIN Setor ON Empresa.idEmpresa = Setor.fkEmpresa
			JOIN Sensor ON Setor.idSetor = Sensor.fkSetor;

-- EXIBINDO OS DADOS DOS USUÁRIOS JUNTO COM OS SEUS RESPECTIVOS USUÁRIOS ADMINISTRADORES

	SELECT * FROM Usuario AS Usuario
		JOIN Usuario AS Administrador ON Usuario.fkUsuarioAdmin = Administrador.idUsuario;
            
-- EXIBINDO OS DADOS DAS EMPRESAS JUNTO COM SEUS USUÁRIOS E SEUS RESPECTIVOS USUÁRIOS ADMINSTRADORES

	SELECT * FROM Empresa 
		JOIN Usuario AS User ON User.fkEmpresa = Empresa.idEmpresa
			JOIN Usuario AS Admin ON User.fkUsuarioAdmin = Admin.idUsuario;

-- EXIBINDO OS DADOS DOS SENSORES JUNTO COM SEUS RESPECTIVOS REGISTROS

	SELECT * FROM Sensor
		JOIN dadosSensor ON Sensor.idSensor = dadosSensor.fkSensor;
        
-- EXIBINDO OS DADOS DOS SENSORES JUNTO COM SEUS RESPECTIVOS SENSORES

	SELECT * FROM Sensor 
		JOIN Setor ON Sensor.fkSetor = Setor.idSetor;
        
-- EXIBINDO OS DADOS DOS SENSORES JUNTO COM SEUS RESPECTIVOS SETORES E JUNTO COM OS SEUS RESPECTIVOS REGISTROS

	SELECT * FROM Sensor
		JOIN Setor ON Sensor.fkSetor = Setor.idSetor
			JOIN dadosSensor ON dadosSensor.fkSensor = Sensor.idSensor;
            
            
