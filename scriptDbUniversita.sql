use Universita;

insert into Sede_Dipartimento(Codice_Sede, Codice_Dipartimento)
       values ("0440", "031");  // NOT VALID  (sede non valida)

insert into Sede_Dipartimento(Codice_Sede, Codice_Dipartimento)
       values ("0330", "060"); // NOT VALID (Dipartimento non valido)


insert into Corso_laurea(Codice, Nome, Descrizione)
       values ("01", "LING", "Lingue");  // Primary key VALID


insert into Modulo(Codice, Nome, Descrizione, CFU)
       values ("02","Linguaggi di Programmazione","Corso propedeutico ai diversi linguaggi di programmazione","9"); // Primary key VALID


insert into Studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("709345","01","Simone","Tornese","1991/08/14","TNSSMN91L05F076U"); // NOT VALID (Stessa matricola, stesso corso)

insert into Studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("709412","05","Sonia","Aleandri","1999/04/24","ANRSNA99L05F06U"); // NOT VALID (il corso non esite)

insert into Studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("709415","2","Sonia","Perchiazzi","1999/06/23","PCZSNA99L040W");  // ERRORE: mi permette di inserire codici fiscali anche inferiori a 16 caratteri


insert into Docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("123568","011","Luca","Perrino","1977/04/13","PRNLCA77C33M043S"); // NOT VALID (stessa matricola, stesso dipartimento)

insert into Docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("123568","230","Luca","Perrino","1977/04/13","PRNLCA77C33M043S"); // NOT VALID (Dipartimento inesistente)

insert into Docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
       values ("1235644","010","Davide","Scarangella","1976/05/13","SGLDVD76C78L043S"); // ERRORE: mi permette d'inserire una Matricola >6


insert into Esame(Matricola_Studente, Codice_Modulo, Matricola_Docente, Data, Voto)
       values ("709326","02","123457","2019/07/24","24"); // NOT VALID (stesso studente, stesso esame)

insert into Esame(Matricola_Studente, Codice_Modulo, Matricola_Docente, Data, Voto, Lode)
       values ("709326","01","123567","2020/04/21","28", "Lode"); // NOT VALID (voto=28)

insert into Esame(Matricola_Studente, Codice_Modulo, Matricola_Docente, Data, Voto)
       values ("709326","02","123457","2020/04/21","14"); // NOT VALID (voto<18)                                  
