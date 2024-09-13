Create Database Hospital;

USE Hospital;

CREATE TABLE Pacientes (
            PacienteID INT PRIMARY KEY identity,
            Nome VARCHAR(100) NOT NULL,
            DataNascimento DATE NOT NULL,
            Telefone VARCHAR(15),
            Email VARCHAR(100) UNIQUE
        );

        CREATE TABLE Medicos (
            MedicoID INT PRIMARY KEY identity,
            Nome VARCHAR(100) NOT NULL,
            Especialidade VARCHAR(50) NOT NULL
        );

        CREATE TABLE Consultas (
            ConsultaID INT PRIMARY KEY identity,
            PacienteID INT,
            MedicoID INT,
            DataConsulta DATE NOT NULL,
            FOREIGN KEY (PacienteID) REFERENCES Pacientes(PacienteID),
            FOREIGN KEY (MedicoID) REFERENCES Medicos(MedicoID)
        );

        CREATE TABLE Diagnosticos (
            DiagnosticoID INT PRIMARY KEY identity,
            ConsultaID INT,
            Descricao TEXT NOT NULL,
            FOREIGN KEY (ConsultaID) REFERENCES Consultas(ConsultaID)
        );


-- Inserindo pacientes
        INSERT INTO Pacientes (Nome, DataNascimento, Telefone, Email) VALUES
        ('Ana Souza', '1985-06-15', '9876-5432', 'ana.souza@example.com'),
        ('Pedro Santos', '1990-11-23', '9123-4567', 'pedro.santos@example.com'),
        ('Maria Costa', '1978-02-05', '9234-5678', 'maria.costa@example.com');

        -- Inserindo médicos
        INSERT INTO Medicos (Nome, Especialidade) VALUES
        ('Dr. João Lima', 'Cardiologia'),
        ('Dra. Laura Pereira', 'Dermatologia'),
        ('Dr. Roberto Silva', 'Ortopedia');

        -- Inserindo consultas
        INSERT INTO Consultas (PacienteID, MedicoID, DataConsulta) VALUES
        (1, 1, '2024-08-15'),
        (2, 2, '2024-08-16'),
        (1, 3, '2024-08-17');

        -- Inserindo diagnósticos
        INSERT INTO Diagnosticos (ConsultaID, Descricao) VALUES
        (1, 'Hipertensão arterial'),
        (2, 'Eczema'),
        (3, 'Fratura de braço');

--1. Listar todos os pacientes e suas respectivas consultas.
SELECT * FROM Pacientes AS P 
INNER JOIN Consultas AS C ON P.PacienteID = C.PacienteID

--2.  Listar todos os médicos e a quantidade de consultas que realizaram.
SELECT Medicos.Nome, COUNT(Consultas.ConsultaID) as QtdConsultas
FROM Medicos
INNER JOIN Consultas ON Consultas.ConsultaID = Medicos.MedicoID
GROUP BY MEDICOS.Nome;

--3. Mostrar o paciente que fez o maior número de consultas.
SELECT TOP 1 Pacientes.Nome, COUNT(Consultas.ConsultaID) as Qtd_consultas
FROM Pacientes
INNER JOIN Consultas ON Consultas.ConsultaID = Pacientes.PacienteID
GROUP BY Pacientes.Nome
ORDER BY Count(Consultas.ConsultaID) DESC

--4 4. Listar diagnósticos e a data da consulta em que foram registrados.
SELECT Diagnosticos.DiagnosticoID, Consultas.DataConsulta
FROM Diagnosticos
INNER JOIN Consultas ON Consultas.ConsultaID = Diagnosticos.ConsultaID

--5 Encontrar o médico com mais especialidades registradas (no caso, isso será igual a um registro por especialidade).
SELECT TOP 1 Medicos.Nome, count(Medicos.Especialidade) Qtd_especialidade
from Medicos
group by Medicos.Nome
order by COUNT(Medicos.Especialidade) desc

--6 Listar consultas realizadas em um intervalo de datas.
SELECT Consultas.ConsultaID, Consultas.DataConsulta
FROM Consultas
WHERE Consultas.DataConsulta BETWEEN '2024-08-16' AND '2024-08-17'

--7 Mostrar o diagnóstico mais frequente.
SELECT TOP 1 DiagnosticoID, COUNT(Diagnosticos.DiagnosticoID) AS QTD_DIAGNOSTICO
FROM Diagnosticos
GROUP BY Diagnosticos.DiagnosticoID
ORDER BY COUNT(Diagnosticos.DiagnosticoID) DESC

--8 8. Calcular a média de consultas realizadas por paciente.
SELECT AVG(TotalConsultas) as MediaConsultas
FROM (
	SELECT Pacientes.Nome, COUNT(Consultas.ConsultaID) AS TotalConsultas
	from Pacientes
	inner join Consultas on Consultas.PacienteID = Pacientes.PacienteID
	group by Pacientes.Nome
)subquery;
SELECT AVG(TotalConsultas) AS MediaConsultas
FROM (
    SELECT Pacientes.Nome, COUNT(Consultas.ConsultaID) AS TotalConsultas
    FROM Pacientes
    INNER JOIN Consultas ON Consultas.PacienteID = Pacientes.PacienteID
    GROUP BY Pacientes.Nome
) AS subquery;







