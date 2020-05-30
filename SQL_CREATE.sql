CREATE TABLE RessourceHumaine (
        
        NSS text PRIMARY KEY,
        nom text NOT NULL,
        prenom text,
        date_naissance date
);

CREATE TABLE Personnel (
        
        NSS text PRIMARY KEY,
        poste text NOT NULL,
        salaire decimal NOT NULL,
        FOREIGN KEY (NSS) REFERENCES RessourceHumaine(NSS)
);

CREATE TABLE Client (
        
        NSS text PRIMARY KEY,
        num_tel int,
        adresse text NOT NULL
        FOREIGN KEY (NSS) REFERENCES RessourceHumaine(NSS)
);

CREATE TABLE Societe (
        
);