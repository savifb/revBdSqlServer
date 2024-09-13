-- Criação da tabela Alunos
        CREATE TABLE Alunos (
            AlunoID INT PRIMARY KEY IDENTITY(1,1),
            Nome NVARCHAR(100) NOT NULL,
            DataNascimento DATE NOT NULL,
            Email NVARCHAR(100) UNIQUE,
            Telefone NVARCHAR(15)
        );

        -- Criação da tabela Disciplinas
        CREATE TABLE Disciplinas (
            DisciplinaID INT PRIMARY KEY IDENTITY(1,1),
            Nome NVARCHAR(100) NOT NULL,
            CargaHoraria INT NOT NULL
        );

       -- Criação da tabela Professores
        CREATE TABLE Professores (
            ProfessorID INT PRIMARY KEY IDENTITY(1,1),
            Nome NVARCHAR(100) NOT NULL,
            Especialidade NVARCHAR(50)
        );

-- Criação da tabela Turmas
CREATE TABLE Turmas (
TurmaID INT PRIMARY KEY IDENTITY(1,1),
DisciplinaID INT,
ProfessorID INT,
AnoLetivo NVARCHAR(10),
FOREIGN KEY (DisciplinaID) REFERENCES Disciplinas(DisciplinaID),
FOREIGN KEY (ProfessorID) REFERENCES Professores(ProfessorID)
);


-- Criação da tabela Matriculas
CREATE TABLE Matriculas (
MatriculaID INT PRIMARY KEY IDENTITY(1,1),
AlunoID INT,
TurmaID INT,
FOREIGN KEY (AlunoID) REFERENCES Alunos(AlunoID),
FOREIGN KEY (TurmaID) REFERENCES Turmas(TurmaID)
);

-- Criação da tabela Notas
CREATE TABLE Notas (
NotaID INT PRIMARY KEY IDENTITY(1,1),
MatriculaID INT,
Nota DECIMAL(5, 2) NOT NULL,
FOREIGN KEY (MatriculaID) REFERENCES Matriculas(MatriculaID)
);

-- Criação da tabela Faltas
CREATE TABLE Faltas (
FaltaID INT PRIMARY KEY IDENTITY(1,1),
MatriculaID INT,
DataFalta DATE NOT NULL,
FOREIGN KEY (MatriculaID) REFERENCES Matriculas(MatriculaID)
);

-- Inserindo alunos
        INSERT INTO Alunos (Nome, DataNascimento, Email, Telefone) VALUES
        ('João Oliveira', '2000-05-15', 'joao.oliveira@example.com', '9999-8888'),
        ('Maria Santos', '1999-07-20', 'maria.santos@example.com', '9888-7777'),
        ('Carlos Almeida', '2001-11-10', 'carlos.almeida@example.com', '9777-6666');

        -- Inserindo disciplinas
        INSERT INTO Disciplinas (Nome, CargaHoraria) VALUES
        ('Matemática', 60),
        ('Português', 45),
        ('História', 30);

        -- Inserindo professores
        INSERT INTO Professores (Nome, Especialidade) VALUES
        ('Prof. Ana Costa', 'Matemática'),
        ('Prof. João Silva', 'Língua Portuguesa'),
        ('Prof. Paula Lima', 'História');

        -- Inserindo turmas
        INSERT INTO Turmas (DisciplinaID, ProfessorID, AnoLetivo) VALUES
        (1, 1, '2024'),
        (2, 2, '2024'),
        (3, 3, '2024');

        -- Inserindo matrículas
        INSERT INTO Matriculas (AlunoID, TurmaID) VALUES
        (1, 1),
        (2, 2),
        (3, 3),
        (1, 2);

        -- Inserindo notas
        INSERT INTO Notas (MatriculaID, Nota) VALUES
        (1, 8.5),
        (2, 7.0),
        (3, 9.0),
        (4, 6.5);

        -- Inserindo faltas
        INSERT INTO Faltas (MatriculaID, DataFalta) VALUES
        (1, '2024-08-10'),
        (2, '2024-08-12'),
        (4, '2024-08-15');
    

    -- 1. Listar todos os alunos e suas respectivas matrículas.

    SELECT * FROM ALUNOS AS A 
    INNER JOIN MATRICULAS AS M ON A.AlunoID = M.AlunoID;

    --2. 2. Mostrar a média das notas de cada aluno por disciplina.
    SELECT A.Nome, D.Nome, AVG(N.Nota) As MediaNotas
    FROM ALUNOS AS A
    INNER JOIN Matriculas AS M on A.alunoID = M.AlunoID 
    INNER JOIN Turmas AS T on M.TurmaID = T.TurmaID
    INNER JOIN Notas AS N on M.MatriculaID = N.MatriculaID
    INNER JOIN Disciplinas AS D on T.DisciplinaID = D.DisciplinaID
    GROUP BY A.Nome, D.nome

    --3. 3. Listar todos os professores e as disciplinas que lecionam.
    SELECT P.Nome, D.nome
    FROM Professores AS P
    INNER JOIN Turmas AS T on T.ProfessorID = P.ProfessorID
    INNER JOIN Disciplinas AS D on T.DisciplinaID = D.DisciplinaID

    --4 4. Mostrar a quantidade de alunos matriculados em cada turma.
    SELECT T.TurmaID, COUNT(M.AlunoID) AS QtdAlunos
    From Turmas as T
    INNER JOIN Matriculas AS M on T.TurmaID = M.TurmaID
    GROUP BY T.TurmaID
    
    --5. 5. 5. Encontrar o aluno com o maior número de faltas.
    SELECT TOP 1 A.Nome, COUNT(F.MatriculaID) AS QtdFaltas
    FROM Alunos AS A
    INNER JOIN Matriculas AS M on A.AlunoID = M.AlunoID 
    INNER JOIN Faltas AS F on M.Matriculas = F.MatriculaID
    GROUP BY A.Nome 
    ORDER BY QtdFaltas DESC

    --6. 
    SELECT D.Nome, AVG(N.Nota) AS MediaDaDisciplina
    FROM Disciplinas AS D
    