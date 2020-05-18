create database universita;

use universita;

create table dipartimento(
  Codice int Primary Key,
  Nome varchar(70) not null
);

insert into dipartimento(Codice, Nome)
  values('010','Informatica e Comunicazione Digitale');

insert into dipartimento(Codice, Nome)
    values('011','Informatica e Tecnoligie per la Produzione Software');

insert into dipartimento(Codice, Nome)
    values('020','Economia e Commercio');

insert into dipartimento(Codice, Nome)
    values('021','Economia aziendale');

insert into dipartimento(Codice, Nome)
    values('030','Mediazione linguistica');

insert into dipartimento(Codice, Nome)
    values('031','Interpreti e Traduttori');

create table sede(
  Codice int Primary Key,
  Indirizzo varchar(100) not null,
  Citta varchar (30) not null
);


insert into sede(Codice, Indirizzo, Citta)
  values('0110', 'Via Leopoldo Latorre, 1','Firenze');

insert into sede(Codice, Indirizzo, Citta)
  values('0220', 'Via Luigi della Ducata, 5','Roma');

insert into sede(Codice, Indirizzo, Citta)
  values('0330', 'Via Leopizzi, 35','Perugia');

  create table sede_dipartimento(
    Codice_sede int not null,
    Codice_dipartimento int not null,
    Note varchar(150),
    Primary Key(Codice_dipartimento,Codice_sede),
    Foreign Key (Codice_sede) references sede(Codice),
    Foreign Key (Codice_dipartimento) references dipartimento(Codice)
  );

  insert into sede_dipartimento(Codice_sede, Codice_dipartimento,Note)
    values('0110','010','null');

  insert into sede_dipartimento(Codice_sede, Codice_dipartimento)
    values('0110','011');

  insert into sede_dipartimento(Codice_sede, Codice_dipartimento)
   values('0220','020');

  insert into sede_dipartimento(Codice_sede, Codice_dipartimento)
    values('0220','021');

  insert into sede_dipartimento(Codice_sede, Codice_dipartimento)
    values('0330','030');

  insert into sede_dipartimento(Codice_sede, Codice_dipartimento)
    values('0330','031');


  create table corso_laurea(
  Codice int Primary Key,
  Nome varchar(50),
  Descrizione varchar(150)
  );

  insert into corso_laurea(Codice, Nome, Descrizione)
    values('01','INF','Informatica');

  insert into corso_laurea(Codice, Nome, Descrizione)
   values('02','ECO','Economia');

  insert into corso_laurea(Codice, Nome, Descrizione)
   values('03','LIN','Lingue');


create table modulo(
Codice int Primary Key,
Nome varchar(30) not null,
Descrizione varchar(150) not null,
CFU int not null
);

insert into modulo(Codice, Nome, Descrizione, CFU)
values('01','Linuaggi di Programmazione','Corso propedutico ai diversi linguaggi di programmazione','9');

insert into modulo(Codice, Nome, Descrizione, CFU)
values('02','Fondamenti di Informatica','Capacità di realizzare una macchina di Touring funzionale','6');

insert into modulo(Codice, Nome, Descrizione, CFU)
values('03','PPM','Progettazione e Produzione multimediale','8');

insert into modulo(Codice, Nome, Descrizione, CFU)
values('04','PPW','Progettazione e Produzione WEB','9');

create table studente(
Matricola int not null,
Corso_laurea int not null,
Nome varchar(30),
Cognome varchar(30),
Data_nascita date,
Codice_fiscale char(16),
Foto blob default null,
Primary Key(Matricola, Corso_laurea), // è possibile usare la stessa matricola per corsi di laurea differenti
Foreign Key (Corso_laurea) references corso_laurea(Codice)
);

insert into studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
values('709332','01','Antonia','Musciacchio','1993/05/05','MSCNTN93E45L049M');

insert into studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
values('709326','01','Selene','Inno','1992/10/27','NNISLN92R67L049W');

insert into studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
values('709345','01','Mattia','Valente','1991/05/13','VLNMTT91E13L049G');

insert into studente(Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale)
values('709345','02','Simone','Tornese','1991/08/14','TNSSMN91L05F076U');


create table docente(
Matricola int(6),
Dipartimento int not null,
Nome varchar(30) not null,
Cognome varchar(30) not null,
Data_nascita date not null,
Codice_fiscale char(16),
Foto blob default null,
Primary Key(Matricola, Dipartimento), // è possibile che ci siano stesse matricole per dipartimenti diversi
Foreign Key (Dipartimento) references dipartimento(Codice)
);

insert into docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
values('123567','010','Alessandra','Rao','1965/06/02','RAOLSN65H42L049I');

insert into docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
values('123568','011','Francesco','Guarino','1967/06/23','GRNFNC67H34L049I');

insert into docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
values('123568','030','Luca','Perrino','1977/04/13','PRNLCA77C33M043S');

insert into docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
values('123527','020','Nicola','Chieppa','1955/02/16','CHPNCL55B16L219M');

insert into docente(Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale)
values('123512','021','Giuseppe','Ressa','1958/08/27','RSSGPP58M27F205N');


create table esame(
Matricola_studente int not null,
Codice_modulo int NOT null,
Matricola_docente int(6),
Data date,
Voto int not null check(Voto>=18 AND Voto<=30),
Lode char(4),
     check(Lode='' OR Voto=30),
Note varchar(100),
Primary Key(Codice_modulo,Matricola_Studente),
Foreign Key (Matricola_studente)references studente(Matricola),
Foreign Key (Codice_modulo) references modulo(Codice),
Foreign Key (Matricola_docente)references docente(Matricola)
);

insert into esame(Matricola_studente, Codice_modulo, Matricola_docente, Data, Voto)
values ('709332', '01', '123567', '2019/07/18', '30');

insert into esame(Matricola_studente, Codice_modulo, Matricola_docente, Data, Voto)
values ('709326', '02', '123568', '2020/01/21', '30');

insert into esame(Matricola_studente, Codice_modulo, Matricola_docente, Data, Voto, Lode)
values ('709332', '02', '123568', '2019/04/18', '30','Lode');

insert into esame(Matricola_studente, Codice_modulo, Matricola_docente, Data, Voto, Lode)
values ('709332', '03', '123568', '2019/04/18', '30','Lode');

insert into esame(Matricola_studente, Codice_modulo, Matricola_docente, Data, Voto)
values ('709332', '03', '123527', '2019/06/18', '26');

insert into esame(Matricola_studente, Codice_modulo, Matricola_docente, Data, Voto)
values ('709332', '04', '123512', '2020/01/24', '25');


\* 1. Mostrare nome e descrizione di tutti i moduli da 9 CFU *\
SELECT Nome, descrizione
FROM modulo
WHERE CFU=9;

\* 2. Mostrare matricola, nome e cognome dei docenti che hanno più di 60anni. *\
SELECT Matricola, Nome, Cognome
FROM docente
WHERE Data_nascita<'1960/01/01';

\* 3.Mostrare nome, cognome e nome_dipartimento di ogni docente, ordinati dal più giovane al più anziano *\
-FORMA IMPLICITA
SELECT d.Nome, d.Cognome, dp.Nome as Nome_dipartimento
FROM docente d, dipartimento dp
WHERE dp.Codice=d.Dipartimento
ORDER BY Data_nascita desc;
-FORMA ESPLICITA
SELECT d.Nome, d.Cognome, dp.Nome as Nome_dipartimento
FROM docente d JOIN dipartimento dp ON dp.Codice=d.Dipartimento
ORDER BY Data_nascita desc;

\* 4.Mostrare città e indirizzo di ogni sede del dipartimento di codice "10" *\
-FORMA IMPLICITA
SELECT Citta, Indirizzo
FROM sede s, sede_dipartimento sd
WHERE s.Codice=sd.Codice_sede and sd.Codice_dipartimento='10';
-FORMA ESPLICITA
SELECT Citta, Indirizzo
FROM sede s JOIN sede_dipartimento sd ON s.Codice=sd.Codice_sede
WHERE sd.Codice_dipartimento='10';
\* 5. Mostrare nome del dipartimento, citta e indirizzo di ogni sede di ogni dipartimento,
ordinate alfabeticamente prima per nome dipartimento, poi per nome citta e infine per indirizzo *\
-FORMA IMPLICITA
SELECT d.Nome as Nome_dipartimento, s.Citta, s.Indirizzo
FROM dipartimento d, sede s, sede_dipartimento sd
WHERE d.Codice=sd.Codice_dipartimento and sd.Codice_sede=s.Codice
ORDER BY d.Nome, s.Citta, s.Indirizzo;
-FORMA ESPLICITA
SELECT d.Nome as Nome_dipartimento, s.Citta, s.Indirizzo
FROM dipartimento d JOIN sede_dipartimento sd ON d.Codice=sd.Codice_dipartimento JOIN sede s ON sd.Codice_sede=s.Codice
ORDER BY d.Nome, s.Citta, s.Indirizzo;

\* 6. Nome di ogni dipartimento che ha sede a Firenze *\
-FORMA IMPLICITA
SELECT d.Nome as Nome_dipartimento, s.Citta
FROM dipartimento d, sede s, sede_dipartimento
WHERE  d.Codice=Codice_dipartimento and Codice_sede=s.Codice and Citta='Firenze';
-FORMA ESPLICITA
SELECT d.Nome as Nome_dipartimento, s.Citta
FROM dipartimento d JOIN sede_dipartimento ON d.Codice=Codice_dipartimento JOIN sede s ON Codice_sede=s.Codice
WHERE s.Citta='Firenze';
\* 7. Mostrare il nome di ogni dipartimento che non ha sede a Roma *\
-FORMA IMPLICITA
SELECT d.Nome as Nome_dipartimento, s.Citta
FROM dipartimento d, sede s, sede_dipartimento
WHERE  d.Codice=Codice_dipartimento and Codice_sede=s.Codice and Citta<>'Roma';
-FORMA ESPLICITA
SELECT d.Nome as Nome_dipartimento, s.Citta
FROM dipartimento d JOIN sede_dipartimento ON d.Codice=Codice_dipartimento JOIN sede s ON Codice_sede=s.Codice
WHERE s.Citta<>'Roma';
-FORMA NIDIFICATA da fare

\* 8. Mostrare media, numero esami sostenuti e totale CFU acquisiti da studenti con matricola '709332' *\
-FORMA IMPLICITA
SELECT avg(e.Voto) as media_studi, count(e.Codice_modulo) as numero_esami_sostenuti, sum(m.CFU) as totale_CFU
FROM esame e, modulo m
WHERE e.Codice_modulo=m.Codice and e.Matricola_studente='709332';
-FORMA ESPLICITA
SELECT avg(e.Voto) as media_studi, count(e.Codice_modulo) as numero_esami_sostenuti, sum(m.CFU) as totale_CFU
FROM esame e JOIN modulo m ON e.Codice_modulo=m.Codice
WHERE  e.Matricola_studente='709332';

\* 9.Mostrare nome, cognome, nome del corso di laurea, media e numero degli esami sostenuti dallo studente con matricola '709332' *\
-FORMA IMPLICITA
SELECT s.Nome, s.Cognome, cl.Nome as Corso_laurea,avg(e.Voto) as media_studi, count(e.Codice_modulo) as numero_esami_sostenuti
FROM studente s, corso_laurea cl, esame e
WHERE s.Matricola=e.Matricola_studente and s.Corso_laurea=cl.Codice and e.Matricola_studente='709332';
-FORMA ESPLICITA
SELECT s.Nome, s.Cognome, cl.Nome as Corso_laurea,avg(e.Voto) as media_studi, count(e.Codice_modulo) as numero_esami_sostenuti
FROM corso_laurea cl JOIN studente s ON cl.Codice=s.Corso_laurea JOIN esame e ON s.Matricola=e.Matricola_studente
WHERE e.Matricola_studente='709332';

\* 10. Mostrare codice, nome e voto medio di ogni modulo, ordinati dalla media più alta alla più bassa *\
-FORMA IMPLICITA
SELECT e.Codice_modulo, m.Nome as Modulo, avg(e.Voto)
FROM modulo m, esame e
WHERE m.Codice=e.Codice_modulo
GROUP BY Codice_modulo
ORDER BY avg(e.Voto) desc;
-FORMA ESPLICITA
SELECT e.Codice_modulo, m.Nome as Modulo, avg(e.Voto)
FROM modulo m JOIN esame e ON m.Codice=e.Codice_modulo
GROUP BY Codice_modulo
ORDER BY avg(e.Voto) desc;

\* 11. Mostrare nome e cognome del docente, nome e decrizione del modulo per ogni docente ed ogni modulo di cui quel
docente abbia tenuto almeno un esame; il risultato deve includere anche i docenti che non abbiano tenuto alcun esame, in quel caso rappresentati
con un unica tupla in cui nome e descrizione del modulo avranno valore null. *\
SELECT DISTINCT d.Nome, d.Cognome, m.Nome as Modulo, m.descrizione
FROM modulo m, docente d, esame e
WHERE e.Matricola_docente=d.Matricola and e.Codice_modulo=m.Codice; \* da rivedere*\

\* 12. Mostrare matricola, nome, cognome, data di nascita e numero esami sostenuti di ogni studente *\
- FORMA IMPLICITA
SELECT s.Matricola, s.Nome, s.Cognome, s.Data_nascita, count(e.Codice_modulo)as numero_esami_sostenuti
FROM studente s, esame e
WHERE s.Matricola=e.Matricola_studente
GROUP BY s.Matricola;
- FORMA ESPLICITA
SELECT s.Matricola, s.Nome, s.Cognome, s.Data_nascita, count(e.Codice_modulo)as numero_esami_sostenuti
FROM studente s JOIN esame e ON s.Matricola=e.Matricola_studente
GROUP BY s.Matricola;

\* 13. Mostrare matricola, nome, cognome, data di nascita e numero esami sostenuti di ogni studente del CdL di nome 'INF' che abbia media maggiore di 26.*\
-FORMA IMPLICITA
SELECT s.Matricola, s.Nome, s.Cognome, s.Data_nascita, count(e.Codice_modulo)as numero_esami_sostenuti
FROM studente s, esame e, corso_laurea cl
WHERE s.Matricola=e.Matricola_studente and s.Corso_laurea=cl.Codice and cl.Nome='INF'
GROUP BY s.Matricola
HAVING avg(e.Voto)>26;
-FORMA ESPLICITA
SELECT s.Matricola, s.Nome, s.Cognome, s.Data_nascita, count(e.Codice_modulo)as numero_esami_sostenuti
FROM esame e JOIN studente s ON e.Matricola_studente=s.Matricola JOIN corso_laurea cl ON s.Corso_laurea=cl.Codice
WHERE cl.Nome='INF'
GROUP BY s.Matricola
HAVING avg(e.Voto)>26;

\* 14. Mostrare nome, cognome, data di nascita di tutti gli studenti che non hanno superato ancora nessun esame*\

\* 15. Mostrare la matricola di tutti gli studenti che hanno superato almeno un esame e che hanno preso sempre voti maggiori di 26*\

\* 16. Mostrare, per ogni modulo, il numero degli studenti che hanno preso tra 18 e 21, quelli che hanno preso tra 22 e 26 e quelli che
 hanno preso tra 27 e 30 (in un unica interrogazione) *\

\* 17. Mostrare matricola, nome, cognome e voto di ogni studente che ha preso un voto maggiore della media nel modulo 'BDD'*\

\* 18. Mostrare matricola, nome, cognome di ogni studente che ha preso ad almeno tre esami un voto maggiore della media per quel modulo *\
