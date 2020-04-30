create database Universita;

use Universita;

create table Dipartimento(
	     Codice int Primary key,
	     Nome varchar (70) not null
);

insert into Dipartimento(Codice, Nome)
	     values ("010", "Informatica e Comunicazione Digitale");

insert into Dipartimento(Codice, Nome)
	     values ("011", "Informatica e Tecnologie per la Produzione Software");

insert into Dipartimento(Codice, Nome)
	     values ("020", "Economia e Commercio");

insert into Dipartimento(Codice, Nome)
	     values ("021", "Economia Aziendale");

insert into Dipartimento(Codice, Nome)
	     values ("030", "Mediazione Linguistica");

insert into Dipartimento(Codice, Nome)
	     values ("031", "Interpreti e Traduttori");


create table Sede(
	     Codice int Primary key,
	     Indirizzo varchar (100) not null,
	     Citta varchar (30) not null
);

insert into Sede(Codice, Indirizzo, Citta)
	     values ("0110", "Via Leopoldo Latorre, 1", "Firenze");

insert into Sede(Codice, Indirizzo, Citta)
	     values ("0220", "Via Luigi Della Ducata, 5", "Roma");

insert into Sede(Codice, Indirizzo, Citta)
	     values ("0330", "Via Leopizzi, 35", "Perugia");


create table Sede_Dipartimento(
       Codice_Sede int,
       Codice_Dipartimento int,
       Note varchar (150),
       Primary Key (Codice_Dipartimento, Codice_Sede),
       Foreign key (Codice_Sede) references Sede (Codice),
       Foreign key (Codice_Dipartimento) references Dipartimento (Codice)
);

insert into Sede_Dipartimento(Codice_Sede, Codice_Dipartimento)
       values ("0110", "010");

insert into Sede_Dipartimento(Codice_Sede, Codice_Dipartimento)
       values ("0110", "011");

insert into Sede_Dipartimento(Codice_Sede, Codice_Dipartimento)
       values ("0220", "020");

insert into Sede_Dipartimento(Codice_Sede, Codice_Dipartimento)
       values ("0220", "021");

insert into Sede_Dipartimento(Codice_Sede, Codice_Dipartimento)
       values ("0330", "030");

insert into Sede_Dipartimento(Codice_Sede, Codice_Dipartimento)
       values ("0330", "031");


create table Corso_laurea(
       Codice int Primary key,
       Nome varchar (50),
       Descrizione varchar (150)
);

insert into Corso_laurea(Codice, Nome, Descrizione)
       values ("01", "INF", "Informatica");

insert into Corso_laurea(Codice, Nome, Descrizione)
       values ("02", "ECO", "Economia");

insert into Corso_laurea(Codice, Nome, Descrizione)
       values ("03", "LING", "Lingue");


create table Modulo(
       Codice int Primary key,
       Nome varchar (30) not null,
       Descrizione varchar (150),
       CFU int not null
);

insert into Modulo(Codice, Nome, Descrizione, CFU)
       values ("01","Linguaggi di Programmazione","Corso propedeutico ai diversi linguaggi di programmazione","9");

insert into Modulo(Codice, Nome, Descrizione, CFU)
       values ("02","Fondamenti d'Informatica","Capacità di realizzare una macchina di Turing funzionale","6");


create table Studente(
       Matricola int (6),
       Corso_laurea int not null,
       Nome varchar (30),
       Cognome varchar (30),
       Data_nascita date not null,
       Codice_fiscale char (16),
       Foto blob default null,
       Primary key (Matricola, Corso_laurea),  //  è possibile usare la stessa matricola per corsi di laurea differenti
       Foreign key (Corso_laurea) references Corso_laurea (Codice)
);

insert into Studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
	     values ("709332","01","Antonia","Musciacchio","1993/05/05/","MSCNTN93E45L049M");

insert into Studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("709326","01","Selene","Inno","1992/10/27","NNISLN92R67L049W");

insert into Studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("709345","01","Mattia","Valente","1991/05/13","VLNMTT91E13L049G");


create table Docente(
       Matricola int (6),
       Dipartimento int not null,
       Nome varchar (30) not null,
       Cognome varchar (30) not null,
       Data_nascita date not null,
       Codice_fiscale char (16),
       Foto blob default null,
       Primary key (Matricola, Dipartimento), //  è possibile ci sia una stessa matricola per dipartimenti differenti
       Foreign key (Dipartimento) references Dipartimento (Codice)
);

insert into Docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("123567","010","Alessandra","Rao","1965/06/02","RAOLSN65H42L049I");

insert into Docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("123568","011","Francesco","Guarino","1967/06/23","GRNFNC67H34L049I");

insert into Docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("123568","030","Luca","Perrino","1977/04/13","PRNLCA77C33M043S");

create table Esame(
       Matricola_Studente int (6),
       Codice_Modulo int,
       Matricola_Docente int (6) not null,
       Data date,
       Voto int check (Voto>=18 and Voto<=30),
       Lode char (4),
       check (Lode='' or Voto=30),
       Note varchar (100),
       Primary Key (Codice_Modulo, Matricola_Studente),
       Foreign key (Matricola_Studente) references Studente (Matricola)
                                        on delete cascade
                                        on update cascade,
       Foreign key (Codice_Modulo) references Modulo (Codice),
       Foreign key (Matricola_Docente) references Docente (Matricola)
);

insert into Esame(Matricola_Studente, Codice_Modulo, Matricola_Docente, Data, Voto)
       values ("709332","01","123567","2019/07/18","30");

insert into Esame(Matricola_Studente, Codice_Modulo, Matricola_Docente, Data, Voto)
       values ("709326","02","123568","2020/01/21","30");

insert into Esame(Matricola_Studente, Codice_Modulo, Matricola_Docente, Data, Voto, Lode)
       values ("709332","02","123568","2019/04/18","30", "Lode");

insert into Esame(Matricola_Studente, Codice_Modulo, Matricola_Docente, Data, Voto)
       values ("709326","02","123457","2019/07/24","24"); // NOT VALID (stesso studente, stesso esame);


          
