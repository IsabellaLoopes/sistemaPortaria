GO
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AcessoSeguro')
BEGIN
    CREATE DATABASE AcessoSeguro;
END
GO

GO
USE [AcessoSeguro]
GO

GO
CREATE SCHEMA cadastro
CREATE SCHEMA historico
CREATE SCHEMA sistema
GO

GO
CREATE TABLE [cadastro].[tblAparelho](
	[apa_id] [int] IDENTITY(1,1) NOT NULL,
	[apa_descricao] [varchar](100) NOT NULL,
	[apa_tipoOperacao] [varchar](1) NOT NULL,
	[apa_ip] [varchar](15) NOT NULL,
	[apa_status] [varchar](1) NOT NULL,
	[apa_senha] [varchar](250) NOT NULL,
 CONSTRAINT [PK_men_id] PRIMARY KEY CLUSTERED 
(
	[apa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

GO
ALTER TABLE [cadastro].[tblAparelho] ADD  DEFAULT ('S') FOR [apa_status]
GO

GO
ALTER TABLE [cadastro].[tblAparelho] ADD  DEFAULT ('873d0M3C7RppQbdHsrjoW1==') FOR [apa_senha]
GO

GO
CREATE TABLE [cadastro].[tblMenuUsuario](
	[mua_id] [int] IDENTITY(1,1) NOT NULL,
	[mua_usr_id] [int] NULL,
	[mua_men_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[mua_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

GO
CREATE TABLE [cadastro].[tblPermissaoAparelho](
	[par_id] [int] IDENTITY(1,1) NOT NULL,
	[par_apa_id] [int] NULL,
	[par_pes_id] [int] NULL,
	[par_tipoPessoa] [varchar](1) NULL,
	[par_dataInclusao] [datetime] NULL,
 CONSTRAINT [PK_par_id] PRIMARY KEY CLUSTERED 
(
	[par_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

GO
ALTER TABLE [cadastro].[tblPermissaoAparelho] ADD  DEFAULT (getdate()) FOR [par_dataInclusao]
GO

GO
CREATE TABLE [cadastro].[tblPessoa](
	[pes_id] [int] IDENTITY(1,1) NOT NULL,
	[pes_nome] [varchar](200) NOT NULL,
	[pes_tipo] [varchar](1) NOT NULL,
	[pes_email] [varchar](200) NOT NULL,
	[pes_telefone] [varchar](15) NOT NULL,
	[pes_status] [varchar](1) NOT NULL,
	[pes_cpf] [varchar](14) NOT NULL,
	[pes_usr_id] [int] NULL,
	[pes_codigo] [varchar](20) NULL,
	[pes_documento] [varbinary](max) NULL,
	[pes_foto] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

GO
ALTER TABLE [cadastro].[tblPessoa] ADD  DEFAULT ('N') FOR [pes_status]
GO

GO
CREATE TABLE [cadastro].[tblTipoOperacao](
	[tip_id] [int] IDENTITY(1,1) NOT NULL,
	[tip_descricao] [varchar](50) NOT NULL,
	[tip_sigla] [varchar](1) NOT NULL,
	[tip_status] [varchar](1) NOT NULL
) ON [PRIMARY]
GO

GO
ALTER TABLE [cadastro].[tblTipoOperacao] ADD  DEFAULT ('S') FOR [tip_status]
GO

GO
CREATE TABLE [cadastro].[tblTipoPessoa](
	[tip_id] [int] IDENTITY(1,1) NOT NULL,
	[tip_descricao] [varchar](50) NOT NULL,
	[tip_sigla] [varchar](1) NOT NULL,
	[tip_status] [varchar](1) NOT NULL
) ON [PRIMARY]
GO

GO
ALTER TABLE [cadastro].[tblTipoPessoa] ADD  DEFAULT ('N') FOR [tip_status]
GO

GO
CREATE TABLE [cadastro].[tblUsuario](
	[usr_id] [int] IDENTITY(1,1) NOT NULL,
	[usr_nome] [varchar](200) NOT NULL,
	[usr_tipo] [varchar](1) NOT NULL,
	[usr_email] [varchar](200) NOT NULL,
	[usr_telParticular] [varchar](15) NOT NULL,
	[usr_telCorporativo] [varchar](15) NULL,
	[usr_senha] [varchar](100) NOT NULL,
	[usr_status] [varchar](1) NOT NULL,
	[usr_cpf] [varchar](14) NOT NULL,
	[usr_cnpj] [varchar](18) NULL,
	[usr_apelido] [varchar](50) NULL,
	[usr_primeiroAcesso] [varchar](1) NOT NULL
) ON [PRIMARY]
GO

GO
ALTER TABLE [cadastro].[tblUsuario] ADD  DEFAULT ('N') FOR [usr_status]
GO

GO
ALTER TABLE [cadastro].[tblUsuario] ADD  DEFAULT ('S') FOR [usr_primeiroAcesso]
GO

GO
CREATE TABLE [cadastro].[tblVisita](
	[vis_id] [int] IDENTITY(1,1) NOT NULL,
	[vis_pes_id] [int] NOT NULL,
	[vis_dataEntrada] [datetime] NOT NULL,
	[vis_dataSaida] [datetime] NULL,
	[vis_dataExpiracao] [datetime] NOT NULL,
	[vis_responsavel] [varchar](50) NULL,
	[vis_observacao] [varchar](200) NULL,
	[vis_ets_id] [int] NULL,
 CONSTRAINT [PK_vis_id] PRIMARY KEY CLUSTERED 
(
	[vis_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

GO
ALTER TABLE [cadastro].[tblVisita] ADD  DEFAULT (getdate()) FOR [vis_dataEntrada]
GO

GO
CREATE TABLE [historico].[tblEntradaSaida](
	[ets_id] [int] IDENTITY(1,1) NOT NULL,
	[ets_pes_id] [int] NOT NULL,
	[ets_apaEntrada] [int] NOT NULL,
	[ets_dataEntrada] [datetime] NOT NULL,
	[ets_apaSaida] [int] NULL,
	[ets_dataSaida] [datetime] NULL,
	[ets_observacao] [varchar](200) NULL,
 CONSTRAINT [ets_id] PRIMARY KEY CLUSTERED 
(
	[ets_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

GO
ALTER TABLE [historico].[tblEntradaSaida] ADD  DEFAULT (getdate()) FOR [ets_dataEntrada]
GO

GO
CREATE TABLE [historico].[tblLogAcessoEntradaSaida](
	[aces_id] [int] IDENTITY(1,1) NOT NULL,
	[aces_pes_id] [int] NOT NULL,
	[aces_apa_id] [int] NOT NULL,
	[aces_tipoOperacao] [varchar](1) NOT NULL,
	[aces_situacao] [int] NOT NULL,
	[aces_mensagem] [varchar](200) NOT NULL,
	[aces_dataInclusao] [datetime] NOT NULL,
 CONSTRAINT [PK_aces_id] PRIMARY KEY CLUSTERED 
(
	[aces_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

GO
ALTER TABLE [historico].[tblLogAcessoEntradaSaida] ADD  DEFAULT (getdate()) FOR [aces_dataInclusao]
GO

GO
CREATE TABLE [sistema].[tblMenu](
	[men_id] [int] IDENTITY(1,1) NOT NULL,
	[men_menu] [int] NOT NULL,
	[men_descricao] [varchar](100) NOT NULL,
	[men_status] [varchar](1) NOT NULL,
	[men_url] [varchar](200) NULL,
	[men_icone] [varchar](100) NOT NULL,
 CONSTRAINT [PK_men_id] PRIMARY KEY CLUSTERED 
(
	[men_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

GO
ALTER TABLE [sistema].[tblMenu] ADD  CONSTRAINT [vazio_men_url]  DEFAULT ('') FOR [men_url]
GO

GO
ALTER TABLE [sistema].[tblMenu] ADD  DEFAULT ('') FOR [men_icone]
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[alteraStatusAparelho]
@id INT = 0,
@status VARCHAR(1)
WITH RECOMPILE
AS
-- EXEC cadastro.alteraStatusAparelho @id=?, @status=?
BEGIN
	IF NOT(@id = 0)BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblAparelho WITH(NOLOCK) WHERE apa_id = @id) BEGIN
				UPDATE cadastro.tblAparelho SET apa_status = @status WHERE apa_id = @id
				SELECT 0 AS erro, 'Sucesso ao alterar status!' AS mensagem
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível encontrar aparelho para atualização dos dados!' AS mensagem
		END
	END ELSE BEGIN
		SELECT -1 AS erro, 'Não foi possível encontrar aparelho para atualização dos dados!' AS mensagem
	END
END 
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[alteraStatusPessoa]
@id INT = 0,
@status VARCHAR(1)
WITH RECOMPILE
AS
-- EXEC cadastro.alteraStatusPessoa @id=?, @status=?
BEGIN
	IF NOT(@id = 0)BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_id = @id) BEGIN
				UPDATE cadastro.tblPessoa SET pes_status = @status WHERE pes_id = @id
				SELECT 0 AS erro, 'Sucesso ao alterar status!' AS mensagem
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível encontrar usuário para atualização dos dados!' AS mensagem
		END
	END ELSE BEGIN
		SELECT -1 AS erro, 'Não foi possível encontrar usuário para atualização dos dados!' AS mensagem
	END
END 
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[alteraStatusUsuario]
@id INT = 0,
@status VARCHAR(1)
WITH RECOMPILE
AS
-- EXEC cadastro.alteraStatusUsuario @id=?, @status=?
BEGIN
	IF NOT(@id = 0)BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblUsuario WITH(NOLOCK) WHERE usr_id = @id) BEGIN
				UPDATE cadastro.tblUsuario SET usr_status = @status WHERE usr_id = @id
				SELECT 0 AS erro, 'Sucesso ao alterar status do usuário!' AS mensagem
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível encontrar usuário para atualização dos dados!' AS mensagem
		END
	END ELSE BEGIN
		SELECT -1 AS erro, 'Não foi possível encontrar usuário para atualização dos dados!' AS mensagem
	END
END 
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[atribuirPermissaoMenu]
@idMenu INT,
@idUser VARCHAR(MAX)	
WITH RECOMPILE
AS
-- EXEC cadastro.atribuirPermissaoMenu @idMenu=?, @idUser=?
BEGIN
	DELETE cadastro.tblMenuUsuario WHERE mua_men_id = @idMenu
	
	INSERT INTO cadastro.tblMenuUsuario(mua_men_id, mua_usr_id)
		SELECT @idMenu, CONVERT(INT, value) FROM string_split(@idUser, ',') WHERE value > 0

	SELECT 0 AS erro, 'Sucesso ao atualizar permissão do menu!' AS mensagem
END 
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[atualizarDocumentosPessoa]
@documento VARBINARY(MAX) = NULL,
@foto VARBINARY(MAX) = NULL,
@pessoa INT = 0
WITH RECOMPILE
AS
-- EXEC cadastro.atualizarDocumentosPessoa @documento=?, @foto=?, @pessoa=?
BEGIN
	IF(@documento IS NOT NULL AND @foto IS NOT NULL)BEGIN
		UPDATE cadastro.tblPessoa SET pes_documento = @documento, pes_foto = @foto WHERE pes_id = @pessoa
		SELECT CASE WHEN @@ROWCOUNT > 0 THEN 0 ELSE -1 END AS erro, CASE WHEN @@ROWCOUNT > 0 THEN 'Sucesso ao atualizar os documentos!' ELSE 'Erro ao atualizar os documentos!' END AS mensagem
	END ELSE IF(@documento IS NOT NULL) BEGIN
		UPDATE cadastro.tblPessoa SET pes_documento = @documento WHERE pes_id = @pessoa
		SELECT CASE WHEN @@ROWCOUNT > 0 THEN 0 ELSE -1 END AS erro, CASE WHEN @@ROWCOUNT > 0 THEN 'Sucesso ao atualizar o documento!' ELSE 'Erro ao atualizar os documento!' END AS mensagem
	END ELSE IF(@foto IS NOT NULL) BEGIN
		UPDATE cadastro.tblPessoa SET pes_foto = @foto WHERE pes_id = @pessoa
		SELECT CASE WHEN @@ROWCOUNT > 0 THEN 0 ELSE -1 END AS erro, CASE WHEN @@ROWCOUNT > 0 THEN 'Sucesso ao atualizar a foto!' ELSE 'Erro ao atualizar a foto!' END AS mensagem
	END ELSE BEGIN
		SELECT -1 AS erro, 'Não foi possível atualizar os documento!' AS mensagem
	END
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[alteraStatusMenu]
@id INT = 0,
@status VARCHAR(1)
WITH RECOMPILE
AS
-- EXEC cadastro.alteraStatusMenu @id=?, @status=?
BEGIN
	IF NOT(@id = 0)BEGIN
		IF EXISTS(SELECT * FROM sistema.tblMenu WITH(NOLOCK) WHERE men_id = @id) BEGIN
				UPDATE sistema.tblMenu SET men_status = @status WHERE men_id = @id
				SELECT 0 AS erro, 'Sucesso ao alterar status do menu!' AS mensagem
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível encontrar menu para atualização dos dados!' AS mensagem
		END
	END ELSE BEGIN
		SELECT -1 AS erro, 'Não foi possível encontrar menu para atualização dos dados!' AS mensagem
	END
END 
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[listarAparelho]
@status VARCHAR(1) = '',
@tipoOperacao VARCHAR(1) = '',
@id INT = 0
WITH RECOMPILE
AS
-- EXEC cadastro.listarAparelho @status=?, @tipoOperacao=?, @id=?
BEGIN
	SELECT t0.*, t1.tip_descricao, CASE WHEN t0.apa_status = 'S' THEN 'Ativo' ELSE 'Inativo' END AS apa_statusDesc
	FROM cadastro.tblAparelho t0 WITH(NOLOCK)
	JOIN cadastro.tblTipoOperacao t1 WITH(NOLOCK) ON(t0.apa_tipoOperacao = t1.tip_sigla)
	WHERE (@status = '' OR apa_status = @status)
		AND (@tipoOperacao = '' OR tip_id = @tipoOperacao)
		AND (@id = 0 OR apa_id = @id)
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[listarPermissaoAparelho]
@id INT = 0,
@aparelho INT = 0,
@pessoa INT = 0,
@tipoPessoa INT = 0
WITH RECOMPILE
AS
-- EXEC cadastro.listarPermissaoAparelho @id=?, @aparelho=?, @pessoa=?, @tipoPessoa=?
BEGIN
	SELECT t0.par_id AS id, t1.apa_descricao AS aparelho, t2.tip_descricao AS tipoOperacao,
			COALESCE(t3.pes_nome,'-') AS pessoa, COALESCE(t4.tip_descricao, '-') AS tipoPessoa
	FROM cadastro.tblPermissaoAparelho t0 WITH(NOLOCK)
	JOIN cadastro.tblAparelho t1 WITH(NOLOCK) ON(t0.par_apa_id = t1.apa_id)
	JOIN cadastro.tblTipoOperacao t2 WITH(NOLOCK) ON(t1.apa_tipoOperacao = t2.tip_sigla)
	LEFT JOIN cadastro.tblPessoa t3 WITH(NOLOCK) ON(t0.par_pes_id = t3.pes_id)
	LEFT JOIN cadastro.tblTipoPessoa t4 WITH(NOLOCK) ON(t0.par_tipoPessoa = t4.tip_id)
	WHERE (@aparelho = 0 OR @aparelho = apa_id)
		AND (@pessoa = 0 OR @pessoa = pes_id)
		AND (@tipoPessoa = 0 OR @tipoPessoa = t4.tip_id)
		AND (@id = 0 OR apa_id = @id)
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[listarPermissoesMenu]
@men_id INT
WITH RECOMPILE
AS
-- EXEC cadastro.listarPermissoesMenu @men_id = 1
BEGIN
	SELECT t0.usr_id AS idUsuario, CASE WHEN t1.mua_id IS NULL THEN 'N' ELSE 'S' END AS permissao, t0.usr_status AS statusUsuario
	FROM cadastro.tblUsuario t0 WITH(NOLOCK)
	OUTER APPLY(SELECT t1.mua_id FROM cadastro.tblMenuUsuario t1 WITH(NOLOCK) 
					WHERE t0.usr_id = t1.mua_usr_id AND t1.mua_men_id = @men_id) AS t1
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[listarPessoa]
@nome VARCHAR(200) = '',
@tipo VARCHAR(1) = '',
@status VARCHAR(1) = '',
@cpf VARCHAR(14) = '',
@id INT = 0
WITH RECOMPILE
AS
-- EXEC cadastro.listarPessoa @nome=?, @tipo=?, @status=?, @cpf=?, @id=?
BEGIN
	SELECT t0.pes_id, t0.pes_nome, t0.pes_tipo, t0.pes_email, t0.pes_telefone, t0.pes_status, t0.pes_cpf, t0.pes_usr_id, t0.pes_codigo, 
		t0.pes_documento, t0.pes_foto,
	t1.tip_descricao, CASE WHEN t0.pes_status = 'S' THEN 'Ativo' ELSE 'Inativo' END AS pes_statusDesc,
			CONVERT(VARCHAR, ISNULL(t2.usr_id, '')) AS usr_id, CASE WHEN COALESCE(pes_documento, '') <> '' THEN 'S' ELSE 'N' END AS possuiDoc,
			CASE WHEN COALESCE(pes_foto, '') <> '' THEN 'S' ELSE 'N' END AS possuiFoto
	FROM cadastro.tblPessoa t0 WITH(NOLOCK)
	JOIN cadastro.tblTipoPessoa t1 WITH(NOLOCK) ON(t0.pes_tipo = t1.tip_sigla)
	LEFT JOIN cadastro.tblUsuario t2 WITH(NOLOCK) ON(t0.pes_usr_id = t2.usr_id)
	WHERE (@nome = '' OR pes_nome LIKE '%' + TRIM(@nome) + '%')
		AND (@tipo = '' OR pes_tipo = @tipo)
		AND (@status = '' OR pes_status = @status)
		AND (@cpf = '' OR pes_cpf LIKE '%' + TRIM(@cpf) + '%')
		AND (@id = 0 OR pes_id = @id)
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[listarPessoaMobile]
@id INT = 0
WITH RECOMPILE
AS
-- EXEC cadastro.listarPessoaMobile @id=?
BEGIN
	SELECT t0.*, CASE WHEN t0.pes_status = 'S' THEN 'Ativo' ELSE 'Inativo' END AS pes_statusDesc, CASE WHEN COALESCE(t0.pes_documento, '') <> '' THEN 'S' ELSE 'N' END AS possuiDoc,
					CASE WHEN COALESCE(t0.pes_foto, '') <> '' THEN 'S' ELSE 'N' END AS possuiFoto,
					t1.tip_descricao, 0 AS erro, 'Sucesso ao encontrar usuário!' AS mensagem, '' AS primeiroAcesso,
					ISNULL(usr_cpf, '') AS usr_cpf, ISNULL(usr_telParticular, '') AS usr_telParticular, ISNULL(usr_telCorporativo, '') AS usr_telCorporativo,
					ISNULL(usr_id, 0) AS usr_id, ISNULL(usr_apelido, '') AS usr_apelido, ISNULL(usr_email, '') AS usr_email,
					ISNULL(usr_nome, '') AS usr_nome, ISNULL(usr_status, '') AS usr_status, ISNULL(usr_tipo, '') AS usr_tipo,
					ISNULL(usr_primeiroAcesso, '') AS usr_primeiroAcesso, '' AS usr_senha,
					pes_id, pes_cpf
	FROM cadastro.tblPessoa t0 WITH (NOLOCK) 
	JOIN cadastro.tblTipoPessoa t1 WITH(NOLOCK) ON(t0.pes_tipo = t1.tip_sigla)
	LEFT JOIN cadastro.tblUsuario t2 WITH(NOLOCK) ON(t0.pes_usr_id = t2.usr_id) 
	WHERE pes_id = @id
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[listarQrCodesExistente]
WITH RECOMPILE
AS
-- EXEC cadastro.listarQrCodesExistente
BEGIN
	SELECT CONCAT(pes_id, '/', pes_cpf) AS qrCode FROM cadastro.tblPessoa WITH(NOLOCK)-- WHERE pes_status = 'S'
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[listarTipoPessoa]
@status VARCHAR(1) = ''
WITH RECOMPILE
AS
-- EXEC cadastro.listarTipoPessoa @status=?
BEGIN
	SELECT * FROM cadastro.tblTipoPessoa WITH(NOLOCK)
	WHERE @status = '' OR tip_status = @status
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[listarUsuario]
@nome VARCHAR(200) = '',
@tipo VARCHAR(1) = '',
@status VARCHAR(1) = '',
@cpf VARCHAR(14) = '',
@id INT = 0
WITH RECOMPILE
AS
-- EXEC cadastro.listarUsuario @nome=?, @tipo=?, @status=?, @cpf=?, @id=?
BEGIN
	SELECT t0.*, t1.tip_descricao, CASE WHEN t0.usr_status = 'S' THEN 'Ativo' ELSE 'Inativo' END AS usr_statusDesc
	FROM cadastro.tblUsuario t0 WITH(NOLOCK)
	JOIN cadastro.tblTipoPessoa t1 WITH(NOLOCK) ON(t0.usr_tipo = t1.tip_sigla)
	WHERE (@nome = '' OR usr_nome LIKE '%' + TRIM(@nome) + '%')
		AND (@tipo = '' OR usr_tipo = @tipo)
		AND (@status = '' OR usr_status = @status)
		AND (@cpf = '' OR usr_cpf LIKE '%' + TRIM(@cpf) + '%')
		AND (@id = 0 OR usr_id = @id)
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[listarVisita]
@data DATE,
@tipoPessoa VARCHAR(1) = ''
WITH RECOMPILE
AS
-- EXEC cadastro.listarVisita @data='2023-10-22', @tipoPessoa=''
BEGIN
	SELECT t0.vis_id AS id, t1.pes_nome AS pessoa, t2.tip_descricao AS tipoPessoa, t1.pes_cpf AS cpf, t0.vis_dataEntrada AS dataEntrada,
			t0.vis_dataSaida AS dataSaida, t0.vis_dataExpiracao AS dataExpiracao, COALESCE(t0.vis_responsavel, '-') AS responsavel,
			COALESCE(t0.vis_observacao, '-') AS observacao, CASE WHEN t3.ets_id IS NULL THEN CASE WHEN tip_sigla = 'V' THEN '-' ELSE 'Não vinculado' END ELSE 'Vinculado' END viculado,
			CASE WHEN t0.vis_dataExpiracao > GETDATE() THEN 'N' ELSE 'S' END AS expirado,
			pes_id
	FROM cadastro.tblVisita t0 WITH(NOLOCK)
	JOIN cadastro.tblPessoa t1 WITH(NOLOCK) ON(t0.vis_pes_id = t1.pes_id)
	JOIN cadastro.tblTipoPessoa t2 WITH(NOLOCK) ON(t1.pes_tipo = t2.tip_sigla)
	LEFT JOIN historico.tblEntradaSaida t3 WITH(NOLOCK) ON(t3.ets_id = t0.vis_ets_id)
	WHERE (CONVERT(VARCHAR, t0.vis_dataEntrada, 103) = CONVERT(VARCHAR, @data, 103))
		AND (t1.pes_tipo = @tipoPessoa OR @tipoPessoa = '')
	ORDER BY t0.vis_dataEntrada ASC
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[salvarAparelho]
@id INT = 0,
@descricao VARCHAR(200),
@tipoOperacao VARCHAR(1),
@ip VARCHAR(15),
@status VARCHAR(1) = 'S'
WITH RECOMPILE
AS
-- EXEC cadastro.salvarAparelho @id=?, @descricao=?, @tipoOperacao=?, @ip=?, @status=?
BEGIN
	IF(@id = 0)BEGIN
		IF(TRIM(@ip) NOT IN(SELECT TRIM(apa_ip) FROM cadastro.tblAparelho WITH(NOLOCK))) BEGIN
			INSERT INTO cadastro.tblAparelho(apa_descricao, apa_tipoOperacao, apa_ip, apa_status)
			VALUES(TRIM(@descricao), TRIM(@tipoOperacao), TRIM(@ip), @status)
		
			IF(SCOPE_IDENTITY() > 0)BEGIN
				SELECT 0 AS erro, 'Sucesso ao incluir aparelho!' AS mensagem
			END ELSE BEGIN
				SELECT -1 AS erro, 'Erro ao incluir aparelho!' AS mensagem
			END
		END ELSE BEGIN
			SELECT -1 AS erro, 'Já existe uma aparelho cadastrado com esse IP!' AS mensagem
		END
	END ELSE BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblAparelho WITH(NOLOCK) WHERE apa_id = @id) BEGIN
			IF(@ip NOT IN(SELECT apa_ip FROM cadastro.tblAparelho WITH(NOLOCK) WHERE apa_id <> @id)) BEGIN
				UPDATE cadastro.tblAparelho 
				SET apa_descricao = TRIM(@descricao), apa_tipoOperacao = TRIM(@tipoOperacao), apa_ip = TRIM(@ip)
				WHERE apa_id = @id

				SELECT 0 AS erro, 'Sucesso ao editar aparelho!' AS mensagem
			END ELSE BEGIN
				SELECT -1 AS erro, 'Não foi possível atualizar o aparelho pois o IP informado já está em uso!' AS mensagem
			END
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível encontrar aparelho para atualização dos dados!' AS mensagem
		END
	END
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[salvarPerfil]
@id INT = 0,
@nome VARCHAR(200),
@email VARCHAR(200),
@tel VARCHAR(15)
WITH RECOMPILE
AS
-- EXEC cadastro.salvarPerfil @id=1, @nome='isabella lopes', @email='isabellaoliveira518@gmail.com', @tel='11964725556'
BEGIN
	IF EXISTS(SELECT * FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_id = @id) BEGIN
		IF(@email NOT IN(SELECT pes_email FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_id <> @id)) BEGIN
			UPDATE cadastro.tblPessoa SET pes_nome = @nome, pes_email = TRIM(@email), pes_telefone = @tel WHERE pes_id = @id
			SELECT 0 AS erro, 'Sucesso ao editar pessoa!' AS mensagem
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível atualizar o pessoa pois o E-mail informado já está em uso!' AS mensagem
		END
	END ELSE BEGIN
		SELECT -1 AS erro, 'Não foi possível encontrar pessoa para atulização dos dados!' AS mensagem
	END
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[salvarPermissaoAparelho]
@id INT = 0,
@aparelho INT,
@pessoa INT,
@tipoPessoa VARCHAR(1)
WITH RECOMPILE
AS
-- EXEC cadastro.salvarPermissaoAparelho @id=?, @aparelho=?, @pessoa=?, @tipoPessoa=?
BEGIN
	IF(@id = 0)BEGIN
		IF NOT EXISTS(
			SELECT * FROM cadastro.tblPermissaoAparelho WITH(NOLOCK) 
			WHERE (par_apa_id = @aparelho AND par_pes_id = @pessoa AND par_tipoPessoa = '') 
					OR (par_apa_id = @aparelho AND par_tipoPessoa = @tipoPessoa AND par_pes_id = 0)
		) BEGIN
			INSERT INTO cadastro.tblPermissaoAparelho(par_apa_id, par_pes_id, par_tipoPessoa)
			VALUES(@aparelho, @pessoa, @tipoPessoa)
			IF(SCOPE_IDENTITY() > 0)BEGIN
				SELECT 0 AS erro, 'Sucesso ao incluir permissão!' AS mensagem
			END ELSE BEGIN
				SELECT -1 AS erro, 'Erro ao incluir permissão!' AS mensagem
			END
		END ELSE BEGIN
			SELECT -1 AS erro, 'Já existe uma permissão cadastrado para esse usuário!' AS mensagem
		END
	END ELSE BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblPermissaoAparelho WITH(NOLOCK) WHERE par_id = @id) BEGIN
				DELETE cadastro.tblPermissaoAparelho WHERE par_id = @id
				SELECT 0 AS erro, 'Sucesso ao excluir Permissão!' AS mensagem
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível encontrar aparelho para atualização dos dados!' AS mensagem
		END
	END
END
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[salvarPessoa]
@id INT = 0,
@nome VARCHAR(200),
@tipo VARCHAR(1),
@email VARCHAR(200),
@tel VARCHAR(15),
@status VARCHAR(1) = 'N',
@cpf VARCHAR(14),
@usr_id INT = 0
WITH RECOMPILE
AS
-- EXEC cadastro.salvarPessoa @id=1, @nome='isabella lopes', @tipo='U', @email='isabellaoliveira518@gmail.com', @tel='11964725556', @status='', @cpf='434.655.418-04', @usr_id=0
BEGIN
	IF(@id = 0)BEGIN
		IF(TRIM(@email) NOT IN(SELECT TRIM(pes_email) FROM cadastro.tblPessoa WITH(NOLOCK)) OR TRIM(@cpf) NOT IN(SELECT TRIM(pes_cpf) FROM cadastro.tblPessoa WITH(NOLOCK))) BEGIN
			INSERT INTO cadastro.tblPessoa(pes_nome, pes_tipo, pes_email, pes_telefone, pes_status, pes_cpf, pes_usr_id)
			VALUES(@nome, @tipo, TRIM(@email), @tel, @status, @cpf, @usr_id)
		
			IF(SCOPE_IDENTITY() > 0)BEGIN
				SELECT 0 AS erro, 'Sucesso ao incluir pessoa!' AS mensagem
			END ELSE BEGIN
				SELECT -1 AS erro, 'Erro ao incluir pessoa!' AS mensagem
			END
		END ELSE BEGIN
			SELECT -1 AS erro, 'Já existe uma pessoa cadastrado com esse E-mail/CPF!' AS mensagem
		END
	END ELSE BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_id = @id) BEGIN
			IF NOT EXISTS(SELECT * FROM cadastro.tblPessoa WHERE pes_usr_id = @usr_id AND pes_id <> @id)BEGIN
				IF(@email NOT IN(SELECT pes_email FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_id <> @id)) BEGIN
					UPDATE cadastro.tblPessoa 
					SET pes_nome = @nome, pes_tipo = @tipo, pes_email = TRIM(@email), pes_telefone = @tel,
						pes_cpf = @cpf, pes_usr_id = @usr_id
					WHERE pes_id = @id

					SELECT 0 AS erro, 'Sucesso ao editar pessoa!' AS mensagem
				END ELSE BEGIN
					SELECT -1 AS erro, 'Não foi possível atualizar o pessoa pois o E-mail informado já está em uso!' AS mensagem
				END
			END ELSE BEGIN
				SELECT -1 AS erro, 'Não foi possível atualizar essa pessoa pois o usuário já está vinculado a outra pessoa!' AS mensagem
			END
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível encontrar pessoa para atulização dos dados!' AS mensagem
		END
	END
END 
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[salvarSaidaManual]
@id INT
WITH RECOMPILE
AS
-- EXEC cadastro.salvarSaidaManual @id=4
BEGIN
	IF EXISTS(SELECT * FROM cadastro.tblVisita WITH(NOLOCK) WHERE vis_id = @id)BEGIN
		IF((SELECT vis_dataSaida FROM cadastro.tblVisita WITH(NOLOCK) WHERE vis_id = @id) IS NULL)BEGIN
			UPDATE cadastro.tblVisita SET vis_dataSaida = GETDATE() WHERE vis_id = @id
			IF(@@ROWCOUNT > 0)BEGIN
				SELECT 0 AS erro, 'Sucesso ao registrar saída manual!' AS mensagem
			END ELSE BEGIN
				SELECT -1 AS erro, 'Erro ao registrar saída manual!' AS mensagem
			END
		END ELSE BEGIN
			SELECT -1 AS erro, 'Erro ao registrar saída manual, pois a saída já está processada!' AS mensagem
		END
	END ELSE BEGIN
		SELECT -1 AS erro, 'Não foi possível encontrar visita!' AS mensagem
	END
END 
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[salvarUsuario]
@id INT = 0,
@nome VARCHAR(200),
@tipo VARCHAR(1),
@email VARCHAR(200),
@telParticular VARCHAR(15),
@telCorporativo VARCHAR(15),
@senha VARCHAR(100), -- não tô usando por enquanto
@status VARCHAR(1) = 'N',
@cpf VARCHAR(14),
@cnpj VARCHAR(18) = '',
@apelido VARCHAR(50)
WITH RECOMPILE
AS
-- EXEC cadastro.salvarUsuario @id=?, @nome=?, @tipo=?, @email=?, @telParticular=?, @telCorporativo=?, @senha=?, @status=?, @cpf=?, @cnpj=?, @apelido=?
BEGIN
	IF(@id = 0)BEGIN
		IF(TRIM(@email) NOT IN(SELECT TRIM(usr_email) FROM cadastro.tblUsuario WITH(NOLOCK)) AND TRIM(@cpf) NOT IN(SELECT TRIM(usr_cpf) FROM cadastro.tblUsuario WITH(NOLOCK)) AND TRIM(@cnpj) NOT IN(SELECT TRIM(usr_cnpj) FROM cadastro.tblUsuario WITH(NOLOCK)) AND TRIM(@apelido) NOT IN(SELECT TRIM(usr_apelido) FROM cadastro.tblUsuario WITH(NOLOCK)) AND @cnpj = '') BEGIN
			IF EXISTS(SELECT * FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_cpf = @cpf) BEGIN
				INSERT INTO cadastro.tblUsuario(usr_nome, usr_tipo, usr_email, usr_telParticular, usr_telCorporativo, usr_senha, usr_status, usr_cpf, usr_cnpj, usr_apelido)
				VALUES(@nome, @tipo, TRIM(@email), @telParticular, @telCorporativo, @senha, @status, @cpf, @cnpj, @apelido)
		
				IF(SCOPE_IDENTITY() > 0)BEGIN
					UPDATE tblPessoa SET pes_usr_id = SCOPE_IDENTITY() WHERE pes_cpf = TRIM(@cpf)
					SELECT 0 AS erro, 'Sucesso ao incluir usuário!' AS mensagem
				END ELSE BEGIN
					SELECT -1 AS erro, 'Erro ao incluir usuário!' AS mensagem
				END
			END ELSE BEGIN
				SELECT -1 AS erro, 'Erro ao incluir usuário, pois o CPF não está cadastrado como pessoa!' AS mensagem
			END
		END ELSE BEGIN
			SELECT -1 AS erro, 'Já existe um usuário cadastrado com esse E-mail/CPF/CNPJ/Apelido!' AS mensagem
		END
	END ELSE BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblUsuario WITH(NOLOCK) WHERE usr_id = @id) BEGIN
			IF(TRIM(@email) NOT IN(SELECT TRIM(usr_email) FROM cadastro.tblUsuario WITH(NOLOCK) WHERE usr_id <> @id) AND TRIM(@apelido) NOT IN(SELECT TRIM(ISNULL(usr_apelido,11)) FROM cadastro.tblUsuario WITH(NOLOCK) WHERE usr_id <> @id) AND TRIM(@cpf) NOT IN(SELECT TRIM(usr_cpf) FROM cadastro.tblUsuario WITH(NOLOCK) WHERE usr_id <> @id) AND (TRIM(@cnpj) NOT IN(SELECT TRIM(usr_cnpj) FROM cadastro.tblUsuario WITH(NOLOCK) WHERE usr_id <> @id) OR @cnpj = '')) BEGIN
				IF NOT EXISTS(SELECT * FROM cadastro.tblPessoa WHERE pes_usr_id = @id AND pes_cpf <> TRIM(@cpf))BEGIN
					UPDATE cadastro.tblUsuario 
					SET usr_nome = @nome, usr_tipo = @tipo, usr_email = TRIM(@email), usr_telParticular = @telParticular,
						usr_telCorporativo = @telCorporativo, usr_cpf = @cpf, usr_cnpj = @cnpj, usr_apelido = TRIM(@apelido)
					WHERE usr_id = @id

					UPDATE tblPessoa SET pes_usr_id = @id WHERE pes_cpf = TRIM(@cpf)
					SELECT 0 AS erro, 'Sucesso ao editar usuário!' AS mensagem
				END ELSE BEGIN
					SELECT -1 AS erro, 'Não foi possível editar esse usuário pois a pessoa já está vinculada a outro usuário!' AS mensagem
				END
			END ELSE BEGIN
				SELECT -1 AS erro, 'Não foi possível atualizar o usuário pois o E-mail/Usuário/CPF/CNPJ informado já está em uso!' AS mensagem
			END
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível encontrar usuário para atulização dos dados!' AS mensagem
		END
	END
END 
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[salvarVisita]
@id INT = 0,
@cpf VARCHAR(14),
@dataExpiracao DATETIME,
@responsavel VARCHAR(50),
@observacao VARCHAR(200)
WITH RECOMPILE
AS
-- EXEC cadastro.salvarVisita @id=?, @cpf=?, @dataExpiracao=?, @responsavel=?, @observacao=?
BEGIN
	DECLARE @pessoa INT = 0
	IF(@id = 0)BEGIN
		IF EXISTS(SELECT pes_id FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_cpf = @cpf)BEGIN
			IF NOT EXISTS(
				SELECT * FROM cadastro.tblVisita t0 WITH(NOLOCK) 
				JOIN cadastro.tblPessoa t1 WITH(NOLOCK) ON(t0.vis_pes_id = t1.pes_id)
				WHERE t1.pes_cpf = @cpf 
					AND (t0.vis_dataSaida IS NULL AND GETDATE() <= t0.vis_dataExpiracao)
			) BEGIN
				IF(@dataExpiracao > DATEADD(HOUR, 1, GETDATE()))BEGIN
					SELECT @pessoa = pes_id FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_cpf = @cpf

					INSERT INTO cadastro.tblVisita(vis_pes_id, vis_dataExpiracao, vis_responsavel, vis_observacao)
					VALUES(@pessoa, @dataExpiracao, @responsavel, @observacao)

					IF(SCOPE_IDENTITY() > 0)BEGIN
						SELECT 0 AS erro, 'Sucesso ao incluir visita!' AS mensagem
					END ELSE BEGIN
						SELECT -1 AS erro, 'Erro ao incluir visita!' AS mensagem
					END
				END ELSE BEGIN
					SELECT -1 AS erro, 'Erro ao incluir visita! O tempo mínimo válido para uma visita é 1 hora.' AS mensagem
				END
			END ELSE BEGIN
				SELECT -1 AS erro, 'Já existe uma visita cadastrado para esse usuário!' AS mensagem
			END
		END ELSE BEGIN
			SELECT -1 AS erro, 'Erro ao incluir visita! Pessoa não cadastrada.' AS mensagem
		END
	END ELSE BEGIN
		SELECT -1 AS erro, 'Não foi possível encontrar visita para atualização dos dados.' AS mensagem
		/*IF EXISTS(SELECT * FROM cadastro.tblPermissaoAparelho WITH(NOLOCK) WHERE par_id = @id) BEGIN
				DELETE cadastro.tblPermissaoAparelho WHERE par_id = @id
				SELECT 0 AS erro, 'Sucesso ao excluir Permissão!' AS mensagem
		END ELSE BEGIN
			SELECT -1 AS erro, 'Não foi possível encontrar visita para atualização dos dados!' AS mensagem
		END*/
	END
END 
GO

GO
CREATE OR ALTER PROCEDURE [cadastro].[verificarPessoa]
@cpf VARCHAR(14)
WITH RECOMPILE
AS
-- EXEC cadastro.verificarPessoa @cpf='434.655.418-04'
BEGIN
	SELECT TOP 1 * FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_cpf = @cpf
END
GO

GO
CREATE OR ALTER PROCEDURE [historico].[listarLogAcessoDash]
@data DATE = NULL,
@tipoOperacao VARCHAR(1),
@pessoa INT = -1
WITH RECOMPILE
AS
-- EXEC historico.listarLogAcessoDash @data=NULL, @tipoOperacao='', @pessoa=1
BEGIN
	IF(ISNULL(@data, '') = '')BEGIN
		SET @data = CONVERT(DATE, GETDATE())
	END

	SELECT t0.ets_dataEntrada AS dataEntrada, t1.apa_descricao AS aparelhoEntrada, '' AS codigo, t3.pes_nome AS pessoa,
			COALESCE(t0.ets_observacao, '-') AS observacao, t0.ets_dataSaida AS dataSaida, t2.apa_descricao AS aparelhoSaida, t4.tip_descricao AS tipoPessoa
	FROM historico.tblEntradaSaida t0 WITH(NOLOCK)
	JOIN cadastro.tblAparelho t1 WITH(NOLOCK) ON(t0.ets_apaEntrada = t1.apa_id)
	LEFT JOIN cadastro.tblAparelho t2 WITH(NOLOCK) ON(t0.ets_apaSaida = t2.apa_id)
	JOIN cadastro.tblPessoa t3 WITH(NOLOCK) ON(t0.ets_pes_id = t3.pes_id)
	JOIN cadastro.tblTipoPessoa t4 WITH(NOLOCK) ON(t3.pes_tipo = t4.tip_sigla)
	WHERE (CONVERT(VARCHAR, t0.ets_dataEntrada, 103) = CONVERT(VARCHAR, @data, 103))
		AND ((@tipoOperacao = 'S' AND t0.ets_dataSaida IS NOT NULL) OR (@tipoOperacao = 'E' AND t0.ets_dataSaida IS NULL) OR @tipoOperacao = '')
		AND (@pessoa = -1 OR t0.ets_pes_id = @pessoa)
	ORDER BY t0.ets_dataEntrada DESC
END
GO

GO
CREATE OR ALTER PROCEDURE [historico].[listarLogAcessoEntradaSaida]
@data DATE = NULL,
@aparelho INT = 0,
@pessoa INT = 0,
@tipoPessoa VARCHAR(1) = '',
@situacao INT = -2
WITH RECOMPILE
AS
-- EXEC historico.listarLogAcessoEntradaSaida @data='2023-10-22', @aparelho=?, @pessoa=?, @tipoPessoa=?, @situacao=?
BEGIN
	IF(ISNULL(@data, '') = '')BEGIN
		SET @data = CONVERT(DATE, GETDATE())
	END

	SELECT t0.aces_id AS id, t0.aces_dataInclusao AS dataAcesso, /*codigo,*/ t3.pes_nome AS pessoa, t4.tip_descricao AS tipoPessoa,
			t1.apa_descricao AS aparelho, t2.tip_descricao AS tipoOperacao, CASE WHEN t0.aces_situacao = -1 THEN 'Bloqueado' ELSE 'Liberado' END AS situacao, pes_id,
			t0.aces_mensagem
	FROM historico.tblLogAcessoEntradaSaida t0 WITH(NOLOCK)
	JOIN cadastro.tblAparelho t1 WITH(NOLOCK) ON(t0.aces_apa_id = t1.apa_id)
	JOIN cadastro.tblTipoOperacao t2 WITH(NOLOCK) ON(t1.apa_tipoOperacao = t2.tip_sigla)
	JOIN cadastro.tblPessoa t3 WITH(NOLOCK) ON(t0.aces_pes_id = t3.pes_id)
	JOIN cadastro.tblTipoPessoa t4 WITH(NOLOCK) ON(t3.pes_tipo = t4.tip_sigla)
	WHERE (CONVERT(VARCHAR, t0.aces_dataInclusao, 103) = CONVERT(VARCHAR, @data, 103))
		AND (t0.aces_apa_id = @aparelho OR @aparelho = 0)
		AND (t0.aces_pes_id = @pessoa OR @pessoa = 0)
		AND (t3.pes_tipo = @tipoPessoa OR @tipoPessoa = '')
		AND (t0.aces_situacao = @situacao OR @situacao = -2)
	ORDER BY t0.aces_dataInclusao DESC
END
GO

GO
CREATE OR ALTER PROCEDURE [sistema].[listarMenu]
@nivel INT = -1,
@status VARCHAR(1) = '' 
WITH RECOMPILE
AS
-- EXEC sistema.listarMenu @nivel=-1
BEGIN
	IF(@nivel = -1) BEGIN
		DECLARE @descricaoMenu VARCHAR(100) = ''
		DECLARE @id INT = 0
		DECLARE @menu INT = 0
		DECLARE @statu VARCHAR(1) = ''
		DECLARE @tbMenu TABLE(men_id INT, men_menu INT, men_descricao VARCHAR(100), men_status VARCHAR(1))

		DECLARE crMenu CURSOR FOR
			SELECT men_id, men_menu, men_descricao, men_status FROM tblMenu WITH(NOLOCK) 
				WHERE men_menu = 0 AND (@status = '' OR men_status = @status)
		
		OPEN crMenu
		FETCH NEXT FROM crMenu INTO @id, @menu, @descricaoMenu, @statu
		WHILE @@FETCH_STATUS = 0 BEGIN
			INSERT INTO @tbMenu VALUES(@id, @menu, @descricaoMenu, @statu)
			INSERT INTO @tbMenu 
				SELECT men_id, men_menu, men_descricao, men_status FROM sistema.tblMenu WITH(NOLOCK) WHERE men_menu = @id AND (@status = '' OR men_status = @status)
		FETCH NEXT FROM crMenu INTO @id, @menu, @descricaoMenu, @statu
        END
		CLOSE crMenu  
		DEALLOCATE crMenu

		SELECT * FROM @tbMenu ORDER BY men_descricao
	END ELSE BEGIN
		SELECT * FROM tblMenu WITH(NOLOCK) WHERE men_menu = @nivel ORDER BY men_descricao
	END
END
GO

GO
CREATE OR ALTER PROCEDURE [sistema].[listarMenuUsuario]
@nivel INT = -1,
@status VARCHAR(1) = 'S',
@usuario INT
WITH RECOMPILE
AS
-- EXEC sistema.listarMenuUsuario @usuario=11
BEGIN
	IF(@nivel = -1) BEGIN
		DECLARE @descricaoMenu VARCHAR(100) = ''
		DECLARE @urlMenu VARCHAR(200) = ''
		DECLARE @iconeMenu VARCHAR(100) = ''
		DECLARE @id INT = 0
		DECLARE @menu INT = 0
		DECLARE @statu VARCHAR(1) = ''
		DECLARE @tbMenu TABLE(men_id INT, men_menu INT, men_descricao VARCHAR(100), men_status VARCHAR(1), men_url VARCHAR(200), men_icone VARCHAR(100))

		DECLARE crMenu CURSOR FOR
			SELECT men_id, men_menu, men_descricao, men_status, men_url, men_icone FROM tblMenu WITH(NOLOCK) 
				WHERE men_menu = 0 AND (@status = '' OR men_status = @status)
		
		OPEN crMenu
		FETCH NEXT FROM crMenu INTO @id, @menu, @descricaoMenu, @statu, @urlMenu, @iconeMenu
		WHILE @@FETCH_STATUS = 0 BEGIN
			INSERT INTO @tbMenu VALUES(@id, @menu, @descricaoMenu, @statu, @urlMenu, @iconeMenu)
			INSERT INTO @tbMenu 
				SELECT men_id, men_menu, men_descricao, men_status, men_url, men_icone FROM sistema.tblMenu WITH(NOLOCK) WHERE men_menu = @id AND (@status = '' OR men_status = @status)
		FETCH NEXT FROM crMenu INTO @id, @menu, @descricaoMenu, @statu, @urlMenu, @iconeMenu
        END
		CLOSE crMenu  
		DEALLOCATE crMenu

		SELECT * FROM @tbMenu t0
		JOIN cadastro.tblMenuUsuario t1 WITH(NOLOCK) ON(t0.men_id = t1.mua_men_id)
		WHERE mua_usr_id = @usuario 
		ORDER BY men_descricao

	END ELSE BEGIN
		SELECT * FROM tblMenu WITH(NOLOCK) WHERE men_menu = @nivel ORDER BY men_descricao
	END
END
GO

GO
CREATE OR ALTER PROCEDURE [sistema].[salvarNovaSenha]
@senha VARCHAR(200),
@id INT
WITH RECOMPILE
AS
-- EXEC sistema.salvarNovaSenha @senha=?, @id=?
BEGIN
	UPDATE cadastro.tblUsuario SET usr_senha = @senha WHERE usr_id = @id

	SELECT CASE WHEN @@ROWCOUNT > 0 THEN 0 ELSE -1 END AS erro, 
			CASE WHEN @@ROWCOUNT > 0 THEN 'Sucesso ao alterar senha!' ELSE 'Erro ao alterar senha!' END AS mensagem
END
GO

GO
CREATE OR ALTER PROCEDURE [sistema].[validarQrCode]
@qrCode VARCHAR(MAX),
@aparelho INT = 0
WITH RECOMPILE
AS
-- EXEC sistema.validarQrCode @qrCode='2/147.607.148-04', @aparelho=1
BEGIN
	DECLARE @id INT = 0
	DECLARE @cpf VARCHAR(15) = ''
	DECLARE @erro INT = 0
	DECLARE @mensagem VARCHAR(200) = ''
	DECLARE @tipoPessoa VARCHAR(1) = ''
	DECLARE @idVisita INT = 0
	DECLARE @idTipoPessoa INT = 0

	SELECT TOP 1 @id = CONVERT(INT, value) FROM STRING_SPLIT(@qrCode, '/')
	SELECT @cpf = CONVERT(VARCHAR, value) FROM STRING_SPLIT(@qrCode, '/')

	DECLARE @tipoOperacao VARCHAR(1) = ''
	SELECT @tipoOperacao = apa_tipoOperacao FROM cadastro.tblAparelho WITH(NOLOCK) WHERE apa_id = @aparelho

	DECLARE @nome VARCHAR(200) = ''
	SELECT @nome = pes_nome, @mensagem = pes_nome, @tipoPessoa = pes_tipo FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_id = @id
	SELECT @idTipoPessoa = tip_id FROM cadastro.tblTipoPessoa WITH(NOLOCK) WHERE tip_sigla = @tipoPessoa

	IF EXISTS(SELECT * FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_id = @id AND pes_cpf = @cpf) BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_id = @id AND ISNULL(pes_status, 'N') = 'S') BEGIN
			IF EXISTS(SELECT * FROM cadastro.tblPessoa WITH(NOLOCK) WHERE pes_id = @id AND COALESCE(pes_documento, '') <> '' AND COALESCE(pes_foto, '') <> '') BEGIN
				IF EXISTS(SELECT * FROM cadastro.tblAparelho WITH(NOLOCK) WHERE apa_id = @aparelho AND ISNULL(apa_status, 'N') = 'S') BEGIN
					IF(@tipoPessoa = 'V') BEGIN
						IF(@tipoOperacao = 'E')BEGIN
							SELECT @idVisita = vis_id FROM cadastro.tblVisita WITH(NOLOCK) WHERE vis_pes_id = @id AND vis_dataSaida IS NULL AND GETDATE() < vis_dataExpiracao
						END ELSE BEGIN
							SELECT @idVisita = vis_id FROM cadastro.tblVisita WITH(NOLOCK) WHERE vis_pes_id = @id --AND vis_dataSaida IS NULL
						END

						IF(@idVisita = 0)BEGIN
							SELECT @erro = -1, @mensagem = 'Não foi possível encontrar uma visita válida!'
						END
					END

					IF(@erro = 0) BEGIN
						IF EXISTS(SELECT * FROM cadastro.tblPermissaoAparelho WITH(NOLOCK) WHERE (par_pes_id = @id OR par_tipoPessoa = @idTipoPessoa) AND par_apa_id = @aparelho) BEGIN
						
							IF(@tipoOperacao = 'E')BEGIN
								IF EXISTS(SELECT * FROM historico.tblEntradaSaida WITH(NOLOCK) WHERE ets_pes_id = @id AND CONVERT(VARCHAR, ets_dataEntrada, 103) = CONVERT(VARCHAR, GETDATE(), 103) AND ets_dataSaida IS NULL) BEGIN
									SELECT @erro = -1, @mensagem = 'Entrada já registrada!'
								END ELSE BEGIN
									INSERT INTO historico.tblEntradaSaida(ets_pes_id, ets_apaEntrada, ets_dataEntrada)
									VALUES(@id, @aparelho, GETDATE())
								END
							END

							IF(@tipoOperacao = 'S')BEGIN
								IF EXISTS(SELECT * FROM historico.tblEntradaSaida WITH(NOLOCK) WHERE ets_pes_id = @id AND CONVERT(VARCHAR, ets_dataEntrada, 103) = CONVERT(VARCHAR, GETDATE(), 103) AND ets_dataSaida IS NULL) BEGIN
									UPDATE historico.tblEntradaSaida SET ets_apaSaida = @aparelho, ets_dataSaida = GETDATE() WHERE ets_pes_id = @id AND CONVERT(VARCHAR, ets_dataEntrada, 103) = CONVERT(VARCHAR, GETDATE(), 103) AND ets_dataSaida IS NULL
								END ELSE BEGIN
									SELECT @erro = -1, @mensagem = 'Não existe entrada registrada!'
								END

								IF(@tipoPessoa = 'V')BEGIN
									UPDATE cadastro.tblVisita SET vis_dataSaida = GETDATE() WHERE vis_pes_id = @id AND vis_dataSaida IS NULL
								END
							END

						END ELSE BEGIN
							SELECT @erro = -1, @mensagem = 'Pessoa não possui permissão!'
						END
					END
				END ELSE BEGIN
					SELECT @erro = -1, @mensagem = 'Aparelho Inativo!'
				END	
			END ELSE BEGIN
				SELECT @erro = -1, @mensagem = 'Pessoa está com cadastro pendente!'
			END
		END ELSE BEGIN
			SELECT @erro = -1, @mensagem = 'Pessoa inativa!'
		END
	END ELSE BEGIN
		SELECT @erro = -1, @mensagem = 'Pessoa não cadastrada!'
	END

	INSERT INTO historico.tblLogAcessoEntradaSaida(aces_pes_id, aces_apa_id, aces_tipoOperacao, aces_situacao, aces_mensagem, aces_dataInclusao)
	VALUES(@id, @aparelho, @tipoOperacao, @erro, @mensagem, GETDATE())

	SELECT @erro AS erro, @mensagem AS mensagem
END
GO

GO
CREATE OR ALTER PROCEDURE [sistema].[verificarLoginAparelho]
@aparelho VARCHAR(50),
@senha VARCHAR(100)
WITH RECOMPILE
AS
-- EXEC sistema.verificarLoginAparelho @aparelho=?, @senha=?
BEGIN
	IF EXISTS(SELECT *  FROM cadastro.tblAparelho t0 WITH (NOLOCK) WHERE TRIM(COALESCE(@aparelho,'')) <> '' AND apa_ip = TRIM(@aparelho))BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblAparelho t0 WITH (NOLOCK) WHERE TRIM(COALESCE(@aparelho,'')) <> '' AND apa_ip = TRIM(@aparelho) AND apa_senha = @senha)BEGIN
			IF EXISTS(SELECT * FROM cadastro.tblAparelho t0 WITH (NOLOCK) WHERE TRIM(COALESCE(@aparelho,'')) <> '' AND apa_ip = TRIM(@aparelho) AND COALESCE(apa_status, 'N') = 'S')BEGIN
				SELECT apa_id AS erro, 'Aparelho Liberado!' AS mensagem
				FROM cadastro.tblAparelho t0 WITH(NOLOCK) WHERE TRIM(COALESCE(@aparelho,'')) <> '' AND apa_ip = TRIM(@aparelho)
			END ELSE BEGIN
				SELECT -1 AS erro, 'Aparelho Inativo!' AS mensagem
			END

		END ELSE BEGIN
			SELECT -1 AS erro, 'Senha não confere!' AS mensagem
		END 
	END ELSE BEGIN
		SELECT -1 AS erro, 'Esse aparelho não existe!' AS mensagem
	END
END
GO

GO
CREATE OR ALTER PROCEDURE [sistema].[verificarLoginMobile]
@login VARCHAR(150),
@senha VARCHAR(100),
@cpf VARCHAR(15) = ''
WITH RECOMPILE
AS
-- EXEC sistema.verificarLoginMobile @login='ele@gmail.com', @senha= '5DmRmi6j8m4P8MkWCEp171==', @cpf=?
BEGIN
	DECLARE @idPessoa INT = 0
	DECLARE @statusPessoa VARCHAR(1) = 'N'
	DECLARE @senhaConfere VARCHAR(1) = 'N'
	DECLARE @possuiFoto VARCHAR(1) = 'N'
	DECLARE @possuiDocumento VARCHAR(1) = 'N'
	DECLARE @cpfPessoa VARCHAR(15) = ''

	SELECT @idPessoa = pes_id, @statusPessoa = pes_status, 
			@senhaConfere = CASE WHEN usr_id IS NULL THEN CASE WHEN pes_cpf = @cpf THEN 'S' ELSE 'N' END ELSE CASE WHEN usr_senha = @senha THEN 'S' ELSE 'N' END END,
			@possuiDocumento = CASE WHEN COALESCE(pes_documento, '') <> '' THEN 'S' ELSE 'N' END, 
			@possuiFoto = CASE WHEN COALESCE(pes_foto, '') <> '' THEN 'S' ELSE 'N' END, @cpfPessoa = pes_cpf
	FROM(
		SELECT *, NULL AS usr_id, NULL AS usr_senha 
		FROM cadastro.tblPessoa t0 WITH(NOLOCK) 
		WHERE pes_email = @login AND ISNULL(pes_usr_id,0) = 0
		UNION
		SELECT t1.*, t0.usr_id, t0.usr_senha 
		FROM cadastro.tblUsuario t0 WITH (NOLOCK) 
		JOIN cadastro.tblPessoa t1 WITH(NOLOCK) ON(t0.usr_id = t1.pes_usr_id)
		WHERE COALESCE(@login,'') <> '' AND (t0.usr_apelido = @login OR t0.usr_email = @login OR t0.usr_cpf = @login)
	) AS tbPessoa

	IF(@idPessoa <> 0)BEGIN
		IF(@statusPessoa <> 'N')BEGIN
			IF(@senhaConfere <> 'N')BEGIN
				IF(@possuiDocumento <> 'N' AND @possuiFoto <> 'N') BEGIN

					SELECT t0.*, CASE WHEN t0.pes_status = 'S' THEN 'Ativo' ELSE 'Inativo' END AS pes_statusDesc, CASE WHEN COALESCE(t0.pes_documento, '') <> '' THEN 'S' ELSE 'N' END AS possuiDoc,
					CASE WHEN COALESCE(t0.pes_foto, '') <> '' THEN 'S' ELSE 'N' END AS possuiFoto,
					t1.tip_descricao, 0 AS erro, 'Sucesso ao encontrar usuário!' AS mensagem, '' AS primeiroAcesso,
					ISNULL(usr_cpf, '') AS usr_cpf, ISNULL(usr_telParticular, '') AS usr_telParticular, ISNULL(usr_telCorporativo, '') AS usr_telCorporativo,
					ISNULL(usr_id, 0) AS usr_id, ISNULL(usr_apelido, '') AS usr_apelido, ISNULL(usr_email, '') AS usr_email,
					ISNULL(usr_nome, '') AS usr_nome, ISNULL(usr_status, '') AS usr_status, ISNULL(usr_tipo, '') AS usr_tipo,
					ISNULL(usr_primeiroAcesso, '') AS usr_primeiroAcesso, '' AS usr_senha
					FROM cadastro.tblPessoa t0 WITH (NOLOCK) 
					JOIN cadastro.tblTipoPessoa t1 WITH(NOLOCK) ON(t0.pes_tipo = t1.tip_sigla)
					LEFT JOIN cadastro.tblUsuario t2 WITH(NOLOCK) ON(t0.pes_usr_id = t2.usr_id) 
					WHERE COALESCE(@login,'') <> '' AND  pes_cpf = @cpfPessoa
				
				END ELSE BEGIN
					SELECT -1 AS erro, 'Cadastro incompleto!' AS mensagem, '' AS primeiroAcesso, '' AS usr_cpf, '' AS usr_telParticular,
					'' AS usr_telCorporativo, 0 AS pes_usr_id, '' AS tip_descricao, '' AS pes_telefone, 0 AS usr_id, '' AS usr_apelido, '' AS possuiDoc, '' AS pes_nome, 
					'' AS usr_email, '' AS possuiFoto, '' AS usr_nome, '' AS pes_email, '' AS pes_cpf, '' AS usr_status, '' AS usr_tipo, '' AS usr_primeiroAcesso,
					'' AS pes_tipo, '' AS pes_status, '' AS usr_senha, 0 AS pes_id, '' AS pes_statusDesc
				END

			END ELSE BEGIN
				SELECT -1 AS erro, 'Senha não confere!' AS mensagem, '' AS primeiroAcesso, '' AS usr_cpf, '' AS usr_telParticular,
					'' AS usr_telCorporativo, 0 AS pes_usr_id, '' AS tip_descricao, '' AS pes_telefone, 0 AS usr_id, '' AS usr_apelido, '' AS possuiDoc, '' AS pes_nome, 
					'' AS usr_email, '' AS possuiFoto, '' AS usr_nome, '' AS pes_email, '' AS pes_cpf, '' AS usr_status, '' AS usr_tipo, '' AS usr_primeiroAcesso,
					'' AS pes_tipo, '' AS pes_status, '' AS usr_senha, 0 AS pes_id, '' AS pes_statusDesc
			END 
		END ELSE BEGIN
			SELECT -1 AS erro, 'Pessoa inativa!' AS mensagem, '' AS primeiroAcesso, '' AS usr_cpf, '' AS usr_telParticular,
				'' AS usr_telCorporativo, 0 AS pes_usr_id, '' AS tip_descricao, '' AS pes_telefone, 0 AS usr_id, '' AS usr_apelido, '' AS possuiDoc, '' AS pes_nome, 
				'' AS usr_email, '' AS possuiFoto, '' AS usr_nome, '' AS pes_email, '' AS pes_cpf, '' AS usr_status, '' AS usr_tipo, '' AS usr_primeiroAcesso,
				'' AS pes_tipo, '' AS pes_status, '' AS usr_senha, 0 AS pes_id, '' AS pes_statusDesc
		END 
	END ELSE BEGIN
		SELECT -1 AS erro, 'Essa pessoa não existe!' AS mensagem, '' AS primeiroAcesso, '' AS usr_cpf, '' AS usr_telParticular,
				'' AS usr_telCorporativo, 0 AS pes_usr_id, '' AS tip_descricao, '' AS pes_telefone, 0 AS usr_id, '' AS usr_apelido, '' AS possuiDoc, '' AS pes_nome, 
				'' AS usr_email, '' AS possuiFoto, '' AS usr_nome, '' AS pes_email, '' AS pes_cpf, '' AS usr_status, '' AS usr_tipo, '' AS usr_primeiroAcesso,
				'' AS pes_tipo, '' AS pes_status, '' AS usr_senha, 0 AS pes_id, '' AS pes_statusDesc
	END
END
GO

GO
CREATE OR ALTER PROCEDURE [sistema].[verificarLoginWeb]
@login VARCHAR(150),
@senha VARCHAR(100)
WITH RECOMPILE
AS
-- EXEC sistema.verificarLoginWeb @login='ele@gmail.com', @senha= '5DmRmi6j8m4P8MkWCEp171=='
BEGIN
	IF EXISTS(SELECT *  FROM cadastro.tblUsuario t0 WITH (NOLOCK) WHERE COALESCE(@login,'') <> '' AND (t0.usr_apelido = @login OR t0.usr_email = @login OR t0.usr_cpf = @login))BEGIN
		IF EXISTS(SELECT * FROM cadastro.tblUsuario t0  WITH (NOLOCK) WHERE COALESCE(@login,'') <> '' AND (t0.usr_apelido = @login OR t0.usr_email = @login OR t0.usr_cpf = @login) AND t0.usr_senha = @senha)BEGIN
			IF(EXISTS(SELECT * FROM cadastro.tblUsuario t0 WITH (NOLOCK) 
					JOIN cadastro.tblTipoPessoa t1 WITH(NOLOCK) ON(t0.usr_tipo = t1.tip_sigla) 
					JOIN cadastro.tblPessoa t2 WITH(NOLOCK) ON(t0.usr_id = t2.pes_usr_id AND COALESCE(t2.pes_foto,'') <> '' AND COALESCE(t2.pes_documento, '') <> '')
					WHERE COALESCE(@login,'') <> '' AND (t0.usr_apelido = @login OR t0.usr_email = @login OR t0.usr_cpf = @login) AND t0.usr_senha = @senha)) BEGIN
				
				DECLARE @primeiroAcc VARCHAR(1) = '', @userId INT
				SELECT @primeiroAcc = usr_primeiroAcesso, @userId = usr_id FROM cadastro.tblUsuario WITH(NOLOCK) WHERE usr_apelido = @login OR usr_email = @login OR usr_cpf = @login
				UPDATE cadastro.tblUsuario SET usr_primeiroAcesso = 'N' WHERE usr_id = @userId

				SELECT t0.*, t2.pes_id, t2.pes_nome, t2.pes_tipo, t2.pes_email, t2.pes_telefone, t2.pes_status, t2.pes_cpf, t2.pes_usr_id, t2.pes_codigo,
				CASE WHEN t2.pes_status = 'S' THEN 'Ativo' ELSE 'Inativo' END AS pes_statusDesc, CASE WHEN COALESCE(t2.pes_documento, '') <> '' THEN 'S' ELSE 'N' END AS possuiDoc,
				CASE WHEN COALESCE(t2.pes_foto, '') <> '' THEN 'S' ELSE 'N' END AS possuiFoto,
				t1.tip_descricao, 0 AS erro, 'Sucesso ao encontrar usuário!' AS mensagem, @primeiroAcc AS primeiroAcesso
				FROM cadastro.tblUsuario t0 WITH (NOLOCK) 
					JOIN cadastro.tblTipoPessoa t1 WITH(NOLOCK) ON(t0.usr_tipo = t1.tip_sigla) 
					JOIN cadastro.tblPessoa t2 WITH(NOLOCK) ON(t0.usr_id = t2.pes_usr_id)
				WHERE COALESCE(@login,'') <> ''
				AND (t0.usr_apelido = @login OR t0.usr_email = @login OR t0.usr_cpf = @login)
				AND t0.usr_senha = @senha
				
			END ELSE BEGIN
				SELECT -1 AS erro, 'Cadastro incompleto!' AS mensagem
			END

		END ELSE BEGIN
			SELECT -1 AS erro, 'Senha não confere!' AS mensagem
		END 
	END ELSE BEGIN
		SELECT -1 AS erro, 'Esse usuário não existe!' AS mensagem
	END
END
GO

GO
CREATE OR ALTER PROCEDURE [sistema].[verificarUsuarioSenha]
@usuario VARCHAR(50),
@email VARCHAR(150),
@cpf VARCHAR(15)
WITH RECOMPILE
AS
-- EXEC sistema.verificarUsuarioSenha @usuario='isabella_l', @email='isabellaoliveira518@gmail.com', @cpf='434.655.418-04'
BEGIN
	SELECT * FROM cadastro.tblUsuario WITH(NOLOCK) 
	WHERE TRIM(usr_apelido) = @usuario AND TRIM(usr_email) = @email AND TRIM(usr_cpf) = @cpf 
			AND @usuario <> '' AND @email <> '' AND @cpf <> '' AND usr_status = 'S'
END
GO