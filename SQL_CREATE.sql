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
        
        SIREN varchar(9) PRIMARY KEY,
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
        Societe varchar(9),
        Etape int,
        prix_par_personne decimal NOT NULL,
        type_transport text NOT NULL CHECK(type_transport IN ('Avion','Bateau','Bus')),
        FOREIGN KEY (Societe) REFERENCES Societe(SIREN),
        FOREIGN KEY (Etape) REFERENCES Etape(id)
);

CREATE TABLE logement (
        
        id int PRIMARY KEY,
        Societe varchar(9),
        Etape int,
        prix_par_personne decimal NOT NULL,
        type_logement text NOT NULL CHECK(type_logement IN ('chambre hote', 'hotel')),
        FOREIGN KEY (Societe) REFERENCES Societe(SIREN),
        FOREIGN KEY (Etape) REFERENCES Etape(id)
      
);

CREATE TABLE location (
        
        id int PRIMARY KEY,
        Societe varchar(9),
        Activite int,
        type_equipement text,
        prix_equipement decimal NOT NULL,
        usure text NOT NULL CHECK(usure IN ('Neuf','très bon','bon','moyen','inutilisable')),
        FOREIGN KEY (Societe) REFERENCES Societe(SIREN),
        FOREIGN KEY (Activite) REFERENCES Activite(id)
);

CREATE TABLE Reservation (
    
    id int PRIMARY KEY,
    Client text NOT NULL,
    CircuitTouristique int,
    status text NOT NULL,
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



INSERT INTO RessourceHumaine VALUES ('198072722924031','Leprat','Quentin','1998-07-01');
INSERT INTO RessourceHumaine VALUES ('198074722520893','Durand','Antoine','2007-09-01');
INSERT INTO RessourceHumaine VALUES ('598072452892409','Renard','Vincent','1998-08-05');


INSERT INTO Client VALUES ('198074722520893','0689784565','Boulevard de la république');
INSERT INTO Client VALUES ('198074722520893','689784565','Rue des belles femmes');
INSERT INTO Personnel VALUES ('198072722924031','Charge d affaire','5000',NULL);

INSERT INTO CircuitTouristique VALUES ('01','Aquatique','2020-05-30','7 jours','25',5);
INSERT INTO CircuitTouristique VALUES ('02','Montagne','2020-02-12','15 jours','18',3);
INSERT INTO CircuitTouristique VALUES ('03,'Aviation','2020-07-30','7 jours','10',1);



