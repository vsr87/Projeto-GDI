------ Procedimentos com SQL embutida e parâmetro, função com SQL embutida e parâmetro ou Gatilho ------

----- Procedimentos -----

-- Procedimento para saber o nome do aluno e a academia em que é matriculado a partir de seu CPF 
CREATE OR REPLACE PROCEDURE ConsultarAluno(
    p_CPF_Aluno IN VARCHAR2,
    p_Nome OUT VARCHAR2,
    p_ID_Academia OUT NUMBER
)
AS
BEGIN
    SELECT Nome, ID_Academia
    INTO p_Nome, p_ID_Academia
    FROM Aluno
    WHERE CPF_Aluno = p_CPF_Aluno;
END;

-- Exemplo de aplicação --
/
DECLARE
    v_Nome VARCHAR2(100);
    v_ID_Academia NUMBER;
BEGIN
    ConsultarAluno('12345678', v_Nome, v_ID_Academia);
    DBMS_OUTPUT.PUT_LINE('Nome do aluno: ' || v_Nome);
    DBMS_OUTPUT.PUT_LINE('ID da Academia: ' || v_ID_Academia);
END;
/


-- Procedimento para aumentar o salário de todos os funcionários
CREATE OR REPLACE PROCEDURE AumentarSalario(perc NUMBER)
AS
BEGIN
    UPDATE Funcionarios 
    SET Salario = TO_CHAR(TO_NUMBER(Salario) * (1 + perc / 100));
END;
/

-- Exemplo de aplicação --
BEGIN 
    AumentarSalario(10);
END;
/

------- Função --------

-- Função que retorna a quantidade de Balconistas que trabalham no turno da manha
CREATE OR REPLACE FUNCTION turno_manha RETURN NUMBER IS
    qtd_manha NUMBER;
    horario VARCHAR(10) := 'Manhã';
BEGIN
    SELECT COUNT(*) INTO qtd_manha
    FROM Balconista
    WHERE Turno = horario;
	RETURN qtd_manha;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
END turno_manha;

-- Exemplo de aplicação --
/
DECLARE
    total NUMBER;
BEGIN
    total := turno_manha();
    DBMS_OUTPUT.PUT_LINE('Quantidade de balconistas no turno da manhã: ' || total);
END;
/

----- Gatilho -----

-- Gatilho para verificar se a inserção ou atualização do CPF do funcionário foi feita corretamente
CREATE OR REPLACE TRIGGER VERIFICACAO
AFTER INSERT OR UPDATE OF CPF_FUNC ON FUNCIONARIOS
FOR EACH ROW
BEGIN
    IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('VERIFIQUE SE ATUALIZOU O CPF CORRETAMENTE:');
        DBMS_OUTPUT.PUT_LINE('CPF ANTIGO: ' || :OLD.CPF_FUNC);
        DBMS_OUTPUT.PUT_LINE('CPF NOVO: ' || :NEW.CPF_FUNC);
    END IF;
    
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('VERIFIQUE SE ATUALIZOU O CPF CORRETAMENTE: ' || :NEW.CPF_FUNC);
    END IF;
END;