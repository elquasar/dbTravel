CREATE TABLE RessourceHumaine (
        
        NSS text PRIMARY KEY,
        nom text NOT NULL,
        prenom text,
        date_naissance date
);

CREATE TYPE type_personnel AS ENUM('Accompagnateur');

CREATE TABLE Personnel (
        
        NSS text PRIMARY KEY,
        poste text NOT NULL,
        salaire decimal NOT NULL,
        t type_personnel,
        FOREIGN KEY (NSS) REFERENCES RessourceHumaine(NSS)
);



CREATE TABLE Client (
        
        NSS text PRIMARY KEY,
        num_tel int,
        adresse text NOT NULL,
        FOREIGN KEY (NSS) REFERENCES RessourceHumaine(NSS)
);

CREATE TYPE type_societe AS ENUM('Transport','Hebergement','Equipement');

CREATE TABLE Societe (
        
        SIREN varchar(14) PRIMARY KEY,
        nom text NOT NULL,
        reputation text CHECK (reputation IN ('Bonne','Moyenne','Mauvaise')),
        t type_societe NOT NULL
);

CREATE TABLE CircuitTouristique (
        
        id int PRIMARY KEY,
        type_circuit text NOT NULL,
        date_depart date NOT NULL,
        duree text,
        nb_max int NOT NULL,
        difficulte int CHECK ((difficulte>=1) AND (difficulte<=5))
        
);

CREATE TABLE Etape (
        
        id int PRIMARY KEY,
        nom text NOT NULL,
        numero int,
        lieu text NOT NULL,
        date_debut date NOT NULL,
        date_fin date,
        circuit int,
        FOREIGN KEY (circuit) REFERENCES CircuitTouristique(id)
        
);

CREATE TABLE Activite (

        id int PRIMARY KEY,
        nom text NOT NULL,
        heure text,
        lieu text,
        etape int,
        accompagnateur text,
        FOREIGN KEY (etape) REFERENCES Etape(id),
        FOREIGN KEY (accompagnateur) REFERENCES Personnel(NSS)
);

CREATE TABLE transporte (
        id int PRIMARY KEY,
        Societe varchar(14),
        Etape int,
        prix_par_personne decimal NOT NULL,
        type_transport text NOT NULL CHECK(type_transport IN ('Avion','Bateau','Bus')),
        FOREIGN KEY (Societe) REFERENCES Societe(SIREN),
        FOREIGN KEY (Etape) REFERENCES Etape(id)
);

CREATE TABLE logement (
        
        id int PRIMARY KEY,
        Societe varchar(14),
        Etape int,
        prix_par_personne decimal NOT NULL,
        type_logement text NOT NULL CHECK(type_logement IN ('chambre hote', 'hotel')),
        FOREIGN KEY (Societe) REFERENCES Societe(SIREN),
        FOREIGN KEY (Etape) REFERENCES Etape(id)
      
);

CREATE TABLE location (
        
        id int PRIMARY KEY,
        Societe varchar(14),
        Activite int,
        type_equipement text,
        prix_equipement decimal NOT NULL,
        usure text NOT NULL CHECK(usure IN ('Neuf','très bon','bon','moyen','inutilisable')),
        quantite int NOT NULL,
        FOREIGN KEY (Societe) REFERENCES Societe(SIREN),
        FOREIGN KEY (Activite) REFERENCES Activite(id)
);

CREATE TABLE Reservation (
    
    id int PRIMARY KEY,
    Client text NOT NULL,
    CircuitTouristique int,
    status text NOT NULL CHECK(status IN ('Reservé','Partiellement payé','Payé')),
    date_emission date NOT NULL,
    nombre_personne int NOT NULL,
    FOREIGN KEY (Client) REFERENCES Client(NSS),
    FOREIGN KEY (CircuitTouristique) REFERENCES CircuitTouristique(id)
);


CREATE TABLE Notation (
    id int PRIMARY KEY,
    Client text NOT NULL,
    CircuitTouristique int,
    note int CHECK((note >=1) AND (note<=10)),
    commentaire text,
    FOREIGN KEY (Client) REFERENCES Client(NSS),
    FOREIGN KEY (CircuitTouristique) REFERENCES CircuitTouristique(id)
);

CREATE VIEW vHebergeur
AS SELECT *
FROM Societe
WHERE Societe.t='Hebergement';

CREATE VIEW vEquipementier
AS SELECT *
FROM Societe
WHERE Societe.t='Equipement';


CREATE VIEW vTransporteur
AS SELECT *
FROM Societe
WHERE Societe.t='Transport';


CREATE VIEW vNombreReservation
AS SELECT COUNT(*) AS NombreReservation, to_char(date_emission,'Mon') as Mon
FROM Reservation
WHERE status = 'Payé'
GROUP BY Mon;

CREATE VIEW vCircuitFamous
AS SELECT  circuittouristique, SUM(nombre_personne) AS NbPersonne, extract(year from date_emission) as yyyy,
FROM Reservation
WHERE status = 'Payé'
GROUP BY circuittouristique,yyyy
ORDER BY NbPersonne DESC;


INSERT INTO RessourceHumaine VALUES ('198072722924031','Leprat','Quentin','1998-07-01');
INSERT INTO RessourceHumaine VALUES ('198074722520893','Durand','Antoine','2007-09-01');
INSERT INTO RessourceHumaine VALUES ('598072452892409','Renard','Vincent','1998-08-05');


INSERT INTO Client VALUES ('198074722520893','0689784565','Boulevard de la république');
INSERT INTO Client VALUES ('598072452892409','0658785369','Rue des belles femmes');
INSERT INTO Personnel VALUES ('198072722924031','Charge d affaire','5000','Accompagnateur');

INSERT INTO CircuitTouristique VALUES ('01','Aquatique','2020-05-30','7 jours','25',5);
INSERT INTO CircuitTouristique VALUES ('02','Montagne','2020-02-12','15 jours','18',3);
INSERT INTO CircuitTouristique VALUES ('03','Aviation','2020-07-30','7 jours','10',1);

INSERT INTO Etape VALUES(1,'Fort des Salettes', 05,'Briançon','2020-02-12','2020-02-13',02);
INSERT INTO Etape VALUES (2,'Fort Boyard',3,'Pertuis d antioche','2020-05-30','2020-06-04',1);


INSERT INTO Activite VALUES(1,'Parapente','8h','Fort des Salettes',1,198072722924031);

INSERT INTO Societe VALUES(48170829500037,'ParapenteLOC','Bonne','Equipement');
INSERT INTO Societe VALUES(32212091600208,'AutoBUS','Moyenne','Transport');
INSERT INTO Societe VALUES(30264000800017,'HAUTel','Bonne','Hebergement');


INSERT INTO Transporte VALUES (1,32212091600208,1,25.56,'Bus');
INSERT INTO Logement VALUES (1,30264000800017,1,55,'chambre hote');
INSERT INTO Location VALUES (1,48170829500037,1,'Parapente',65,'très bon',10);
INSERT INTO Location VALUES (2,48170829500037,1,'Casque et système d accroche',35,'moyen',20);


INSERT INTO Reservation VALUES (1,598072452892409,2,'Reservé','2019-12-09',2);
INSERT INTO Reservation VALUES (2,598072452892409,2,'Reservé','2019-12-07',4);
INSERT INTO Reservation VALUES (3,598072452892409,2,'Payé','2019-11-11',7);
INSERT INTO Reservation VALUES (4,598072452892409,2,'Payé','2019-11-11',9);
INSERT INTO Reservation VALUES (5,598072452892409,2,'Payé','2019-12-07',3);


INSERT INTO Reservation VALUES (11,198074722520893,3,'Reservé','2018-12-09',10);
INSERT INTO Reservation VALUES (21,598072452892409,2,'Reservé','2019-12-07',4);
INSERT INTO Reservation VALUES (31,198074722520893,2,'Payé','2017-11-11',7);
INSERT INTO Reservation VALUES (41,198074722520893,3,'Payé','2017-11-11',15);
INSERT INTO Reservation VALUES (51,598072452892409,2,'Payé','2019-12-07',50);

INSERT INTO Notation VALUES(1,198074722520893,3,8,'Un circuit incroyable');