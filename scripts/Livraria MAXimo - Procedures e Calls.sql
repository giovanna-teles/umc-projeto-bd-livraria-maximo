-- REVISADO

/*Funções: Tabela Gênero*/
DELIMITER $$

/*Inclusão*/
CREATE PROCEDURE InsereGenero(IN pNomeGenero VARCHAR(100))
BEGIN

    IF (SELECT COUNT(*) FROM Genero WHERE Nome = pNomeGenero AND Ativo = TRUE) = 0 THEN
        INSERT INTO Genero (Nome) VALUES (pNomeGenero);
        SELECT 'Gênero inserido com sucesso.' AS Resultado;
    ELSE
        SELECT 'Gênero já existe ou está inativo.' AS Resultado;
    END IF;
END$$

/*Atualização*/
CREATE PROCEDURE AtualizaGenero(IN pIdGenero INT, IN pNovoNome VARCHAR(100))
BEGIN

    IF (SELECT COUNT(*) FROM Genero WHERE ID = pIdGenero AND Ativo = TRUE) > 0 THEN
        UPDATE Genero SET Nome = pNovoNome WHERE ID = pIdGenero;
        SELECT 'Gênero atualizado com sucesso.' AS Resultado;
    ELSE
        SELECT 'Gênero não encontrado ou está inativo.' AS Resultado;
    END IF;
END$$

/*Exclusão lógica*/
CREATE PROCEDURE ExcluiGenero(IN pIdGenero INT)
BEGIN
  
    IF (SELECT COUNT(*) FROM Genero WHERE ID = pIdGenero AND Ativo = TRUE) > 0 THEN
        UPDATE Genero SET Ativo = FALSE WHERE ID = pIdGenero;
        SELECT 'Gênero excluído com sucesso.' AS Resultado;
    ELSE
        SELECT 'Gênero não encontrado ou já está inativo.' AS Resultado;
    END IF;
END$$

DELIMITER ;

/*Funções: Tabela Tipo_livro*/
DELIMITER $$

/*Inclusão*/
CREATE PROCEDURE InsereTipoLivro(IN pNomeTipo VARCHAR(50))
BEGIN
   
    IF (SELECT COUNT(*) FROM Tipo_livro WHERE Nome = pNomeTipo AND Ativo = TRUE) = 0 THEN
        INSERT INTO Tipo_livro (Nome) VALUES (pNomeTipo);
        SELECT 'Tipo de livro inserido com sucesso.' AS Resultado;
    ELSE
        SELECT 'Tipo de livro já existe ou está inativo.' AS Resultado;
    END IF;
END$$

/*Atualização*/
CREATE PROCEDURE AtualizaTipoLivro(IN pIdTipo INT, IN pNovoNome VARCHAR(50))
BEGIN
    
    IF (SELECT COUNT(*) FROM Tipo_livro WHERE ID = pIdTipo AND Ativo = TRUE) > 0 THEN
        UPDATE Tipo_livro SET Nome = pNovoNome WHERE ID = pIdTipo;
        SELECT 'Tipo de livro atualizado com sucesso.' AS Resultado;
    ELSE
        SELECT 'Tipo de livro não encontrado ou está inativo.' AS Resultado;
    END IF;
END$$

/*Exclusão lógica*/
CREATE PROCEDURE ExcluiTipoLivro(IN pIdTipo INT)
BEGIN
  
    IF (SELECT COUNT(*) FROM Tipo_livro WHERE ID = pIdTipo AND Ativo = TRUE) > 0 THEN
        UPDATE Tipo_livro SET Ativo = FALSE WHERE ID = pIdTipo;
        SELECT 'Tipo de livro excluído com sucesso.' AS Resultado;
    ELSE
        SELECT 'Tipo de livro não encontrado ou já está inativo.' AS Resultado;
    END IF;
END$$

DELIMITER ;

/*Funções: Livro*/
DELIMITER $$

/*Inclusão*/
CREATE PROCEDURE InsereLivro(
    IN pISBN DECIMAL(13), 
    IN pTitulo VARCHAR(100), 
    IN pValor DECIMAL(5,2), 
    IN pAno YEAR, 
    IN pClassificacao CHAR(3), 
    IN pSinopse TEXT, 
    IN pPaginas INT, 
    IN pPeso DECIMAL(4,2), 
    IN pDimensoes CHAR(20), 
    IN pQuantidade INT, 
    IN pLocalizacao CHAR(10), 
    IN pIdEditora INT)
BEGIN
 
    IF (SELECT COUNT(*) FROM Livro WHERE ISBN = pISBN AND Ativo = TRUE) = 0 THEN
        INSERT INTO Livro (
            ISBN, 
            Titulo, 
            Valor_un, 
            Ano_Publicacao, 
            Classificacao_Indicativa, 
            Sinopse, 
            N_Pagina, 
            Peso_kg, 
            Dimensoes, 
            Quantidade, 
            Localizacao, 
            id_editora)
        VALUES (
            pISBN, 
            pTitulo, 
            pValor, 
            pAno, 
            pClassificacao, 
            pSinopse, 
            pPaginas, 
            pPeso, 
            pDimensoes, 
            pQuantidade, 
            pLocalizacao, 
            pIdEditora);
        SELECT 'Livro inserido com sucesso.' AS Resultado;
    ELSE
        SELECT 'Livro já existe ou está inativo.' AS Resultado;
    END IF;
END$$

/*Atualização*/
CREATE PROCEDURE AtualizaLivro(IN pISBN DECIMAL(13), IN pNovoTitulo VARCHAR(100))
BEGIN
    IF (SELECT COUNT(*) FROM Livro WHERE ISBN = pISBN AND Ativo = TRUE) > 0 THEN
        UPDATE Livro SET Titulo = pNovoTitulo WHERE ISBN = pISBN;
        SELECT 'Livro atualizado com sucesso.' AS Resultado;
    ELSE
        SELECT 'Livro não encontrado ou está inativo.' AS Resultado;
    END IF;
END$$

/*Exclusão lógica*/
CREATE PROCEDURE ExcluiLivro(IN pISBN DECIMAL(13))
BEGIN
 
    IF (SELECT COUNT(*) FROM Livro WHERE ISBN = pISBN AND Ativo = TRUE) > 0 THEN
        UPDATE Livro SET Ativo = FALSE WHERE ISBN = pISBN;
        SELECT 'Livro excluído com sucesso.' AS Resultado;
    ELSE
        SELECT 'Livro não encontrado ou já está inativo.' AS Resultado;
    END IF;
END$$

DELIMITER ;

/*Funções: Livro_Genero*/
DELIMITER $$

/*Inclusão*/
CREATE PROCEDURE InsereLivroGenero(IN pISBN DECIMAL(13), IN pIdGenero INT)
BEGIN
  
    IF (SELECT COUNT(*) FROM Livro WHERE ISBN = pISBN AND Ativo = TRUE) > 0 AND 
       (SELECT COUNT(*) FROM Genero WHERE ID = pIdGenero AND Ativo = TRUE) > 0 THEN
        INSERT INTO Livro_Genero (ISBN_l, id_gen) VALUES (pISBN, pIdGenero);
        SELECT 'Associação de gênero ao livro inserida com sucesso.' AS Resultado;
    ELSE
        SELECT 'Erro ao associar gênero ao livro. Verifique se os registros estão ativos.' AS Resultado;
    END IF;
END$$

/*Atualização*/
CREATE PROCEDURE AtualizaLivroGenero(IN pISBN DECIMAL(13), IN pIdGenero INT)
BEGIN
  
    IF (SELECT COUNT(*) FROM Livro WHERE ISBN = pISBN AND Ativo = TRUE) > 0 AND 
       (SELECT COUNT(*) FROM Genero WHERE ID = pIdGenero AND Ativo = TRUE) > 0 AND 
       (SELECT COUNT(*) FROM Livro_Genero WHERE ISBN_l = pISBN AND id_gen = pIdGenero AND Ativo = TRUE) > 0 THEN
       
        UPDATE Livro_Genero 
        SET Ativo = FALSE 
        WHERE ISBN_l = pISBN 
            AND id_gen = pIdGenero;
      
        INSERT INTO Livro_Genero (ISBN_l, id_gen, Ativo) VALUES (pISBN, pIdGenero, TRUE);
        SELECT 'Associação de livro e gênero atualizada com sucesso.' AS Resultado;
    ELSE
        SELECT 'Livro, gênero ou associação não encontrada ou estão inativos.' AS Resultado;
    END IF;
END$$

/*Exclusão lógica*/
CREATE PROCEDURE ExcluiLivroGenero(IN pISBN DECIMAL(13), IN pIdGenero INT)
BEGIN
  
    IF (SELECT COUNT(*) FROM Livro_Genero WHERE ISBN_l = pISBN AND id_gen = pIdGenero AND Ativo = TRUE) > 0 THEN
        UPDATE Livro_Genero SET Ativo = FALSE WHERE ISBN_l = pISBN AND id_gen = pIdGenero;
        SELECT 'Associação de gênero ao livro excluída com sucesso.' AS Resultado;
    ELSE
        SELECT 'Associação de gênero não encontrada ou já está inativa.' AS Resultado;
    END IF;
END$$

DELIMITER ;

/*Funções: VERSÃO*/
DELIMITER $$

/* Inclusão */
CREATE PROCEDURE InsereVersao(IN pISBN DECIMAL(13), IN pid_tipo_lv INT)
BEGIN
    IF (SELECT COUNT(*) FROM Livro WHERE ISBN = pISBN AND Ativo = TRUE) > 0 THEN
        INSERT INTO Versao (ISBN_lv, id_tipo_lv, Ativo) 
        VALUES (pISBN, pid_tipo_lv, TRUE);
        SELECT 'Versão inserida com sucesso.' AS Resultado;
    ELSE
        SELECT 'Livro não encontrado ou está inativo.' AS Resultado;
    END IF;
END$$

/* Atualização */
CREATE PROCEDURE AtualizaVersao(IN pISBN DECIMAL(13), IN pid_tipo_lv INT, IN pAtivo TINYINT)
BEGIN
    IF (SELECT COUNT(*) FROM Versao WHERE ISBN_lv = pISBN AND id_tipo_lv = pid_tipo_lv) > 0 AND
       (SELECT COUNT(*) FROM Livro WHERE ISBN = pISBN AND Ativo = TRUE) > 0 THEN
        UPDATE Versao 
        SET Ativo = pAtivo
        WHERE ISBN_lv = pISBN 
            AND id_tipo_lv = pid_tipo_lv;
        SELECT 'Versão atualizada com sucesso.' AS Resultado;
    ELSE
        SELECT 'Versão ou livro não encontrados ou estão inativos.' AS Resultado;
    END IF;
END$$

/* Exclusão lógica */
CREATE PROCEDURE ExcluiVersao(IN pISBN DECIMAL(13), IN pid_tipo_lv INT)
BEGIN
    IF (SELECT COUNT(*) FROM Versao WHERE ISBN_lv = pISBN AND id_tipo_lv = pid_tipo_lv AND Ativo = TRUE) > 0 THEN
        UPDATE Versao 
        SET Ativo = FALSE 
        WHERE ISBN_lv = pISBN AND id_tipo_lv = pid_tipo_lv;
        SELECT 'Versão excluída logicamente.' AS Resultado;
    ELSE
        SELECT 'Versão não encontrada ou já está inativa.' AS Resultado;
    END IF;
END$$

DELIMITER ;


/*TABELA:LIVRO_AUTOR*/
DELIMITER $$

/*Inclusão*/
CREATE PROCEDURE InsereLivroAutor(IN pISBN DECIMAL(13), IN pIdAutor INT)
BEGIN
   
    IF (SELECT COUNT(*) FROM Livro WHERE ISBN = pISBN AND Ativo = TRUE) > 0 AND 
       (SELECT COUNT(*) FROM Autor WHERE ID = pIdAutor AND Ativo = TRUE) > 0 THEN
        INSERT INTO Livro_Autor (ISBN_li, id_au) VALUES (pISBN, pIdAutor);
        SELECT 'Associação de autor ao livro inserida com sucesso.' AS Resultado;
    ELSE
        SELECT 'Livro ou autor não encontrado ou estão inativos.' AS Resultado;
    END IF;
END$$

/*Atualização*/
DELIMITER $$

CREATE PROCEDURE AtualizaLivroAutor(IN pISBN DECIMAL(13), IN pIdAutor INT)
BEGIN
    IF (SELECT COUNT(*) FROM Livro WHERE ISBN = pISBN AND Ativo = TRUE) > 0 AND 
       (SELECT COUNT(*) FROM Autor WHERE ID = pIdAutor AND Ativo = TRUE) > 0 THEN

        IF (SELECT COUNT(*) FROM Livro_Autor WHERE ISBN_li = pISBN AND id_au = pIdAutor AND Ativo = TRUE) > 0 THEN
            UPDATE Livro_Autor SET Ativo = FALSE WHERE ISBN_li = pISBN AND id_au = pIdAutor AND Ativo = TRUE;
        END IF;

        INSERT INTO Livro_Autor (ISBN_li, id_au, Ativo) VALUES (pISBN, pIdAutor, TRUE);
        SELECT 'Associação de livro e autor atualizada com sucesso.' AS Resultado;
    ELSE
        SELECT 'Livro, autor ou associação não encontrada ou estão inativos.' AS Resultado;
    END IF;
END$$

DELIMITER ;


/*Exclusão lógica*/
DELIMITER $$

CREATE PROCEDURE ExcluiLivroAutor(IN pISBN DECIMAL(13), IN pIdAutor INT)
BEGIN

    IF (SELECT COUNT(*) FROM Livro_Autor WHERE ISBN_li = pISBN AND id_au = pIdAutor AND Ativo = TRUE) > 0 THEN
   
        UPDATE Livro_Autor SET Ativo = FALSE WHERE ISBN_li = pISBN AND id_au = pIdAutor AND Ativo = TRUE;
        SELECT 'Associação de autor ao livro excluída com sucesso.' AS Resultado;
    ELSE
        SELECT 'Associação não encontrada ou já está inativa.' AS Resultado;
    END IF;
END$$

DELIMITER ;

/*desabilitar o "safe update mode" para a sessão atual*/
SET SQL_SAFE_UPDATES = 0;

/* Funções de Inserção */
CALL InsereGenero('Drama histórico');
CALL InsereTipoLivro('Livro brochura'); 
CALL InsereLivro(9788543104251, 'O Homem do Castelo Alto', 49.90, 1962, 'LIV', 
                 'O livro descreve um mundo alternativo onde os aliados perderam a Segunda Guerra Mundial.', 
                 304, 0.6, '14x21', 5, 'CE-P1-Z', 1);
CALL InsereLivroGenero(9788543104251, 1);
CALL InsereLivroAutor(9788543104251, 1);
CALL InsereVersao(9788543104251, 4);

/* Funções de Atualização */
CALL AtualizaGenero(1, 'Conto');
CALL AtualizaTipoLivro(1, 'Livro de bolso'); 
CALL AtualizaLivro(9788543104251, 'A mulher do Castelo Alto');
CALL AtualizaLivroGenero(9788543104251, 2);
CALL AtualizaLivroAutor(9788543104251, 2);
CALL AtualizaVersao(9788543104251, 4, TRUE);

/* Funções de Exclusão */
CALL ExcluiGenero(2);
CALL ExcluiTipoLivro(3); 
CALL ExcluiLivro(9788543104251); 
CALL ExcluiLivroGenero(9788543104251, 1);
CALL ExcluiLivroAutor(9788543104251, 1);
CALL ExcluiVersao(9788543104251, 4);
