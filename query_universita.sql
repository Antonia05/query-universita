/* 1. Mostrare nome e descrizione di tutti i moduli da 9 CFU */
/*PROIEZIONE E SELEZIONE*/
SELECT Nome, descrizione
FROM modulo
WHERE CFU=9;

/* 2. Mostrare matricola, nome e cognome dei docenti che hanno più di 60anni. */
/*PROIEZIONE E SELEZIONE*/
SELECT Matricola, Nome, Cognome
FROM docente
WHERE Data_nascita<'1960/01/01';

/* 3.Mostrare nome, cognome e nome_dipartimento di ogni docente, ordinati dal più giovane al più anziano */
/*FORMA IMPLICITA*/
SELECT d.Nome, d.Cognome, dp.Nome as Nome_dipartimento
FROM docente d, dipartimento dp
WHERE dp.Codice=d.Dipartimento
ORDER BY Data_nascita desc;

/*FORMA ESPLICITA*/
SELECT d.Nome, d.Cognome, dp.Nome as Nome_dipartimento
FROM docente d JOIN dipartimento dp ON dp.Codice=d.Dipartimento
ORDER BY Data_nascita desc;

/* 4.Mostrare città e indirizzo di ogni sede del dipartimento di codice "10" */
/*FORMA IMPLICITA*/
SELECT Citta, Indirizzo
FROM sede s, sede_dipartimento sd
WHERE s.Codice=sd.Codice_sede and sd.Codice_dipartimento='10';

/*FORMA ESPLICITA*/
SELECT Citta, Indirizzo
FROM sede s JOIN sede_dipartimento sd ON s.Codice=sd.Codice_sede
WHERE sd.Codice_dipartimento='10';

/* 5. Mostrare nome del dipartimento, citta e indirizzo di ogni sede di ogni dipartimento,
ordinate alfabeticamente prima per nome dipartimento, poi per nome citta e infine per indirizzo */
/*FORMA IMPLICITA*/
SELECT d.Nome as Nome_dipartimento, s.Citta, s.Indirizzo
FROM dipartimento d, sede s, sede_dipartimento sd
WHERE d.Codice=sd.Codice_dipartimento and sd.Codice_sede=s.Codice
ORDER BY d.Nome, s.Citta, s.Indirizzo;

/*FORMA ESPLICITA*/
SELECT d.Nome as Nome_dipartimento, s.Citta, s.Indirizzo
FROM dipartimento d JOIN sede_dipartimento sd ON d.Codice=sd.Codice_dipartimento JOIN sede s ON sd.Codice_sede=s.Codice
ORDER BY d.Nome, s.Citta, s.Indirizzo;

/* 6. Nome di ogni dipartimento che ha sede a Firenze */
/*FORMA IMPLICITA*/
SELECT d.Nome as Nome_dipartimento, s.Citta
FROM dipartimento d, sede s, sede_dipartimento
WHERE  d.Codice=Codice_dipartimento and Codice_sede=s.Codice and Citta='Firenze';

/*FORMA ESPLICITA*/
SELECT d.Nome as Nome_dipartimento, s.Citta
FROM dipartimento d JOIN sede_dipartimento ON d.Codice=Codice_dipartimento JOIN sede s ON Codice_sede=s.Codice
WHERE s.Citta='Firenze';

/* 7. Mostrare il nome di ogni dipartimento che non ha sede a Roma */
/*FORMA IMPLICITA*/
SELECT d.Nome as Nome_dipartimento
FROM dipartimento d, sede s, sede_dipartimento
WHERE  d.Codice=Codice_dipartimento and Codice_sede=s.Codice and Citta<>'Roma';

/*FORMA ESPLICITA*/
SELECT d.Nome as Nome_dipartimento
FROM dipartimento d JOIN sede_dipartimento ON d.Codice=Codice_dipartimento JOIN sede s ON Codice_sede=s.Codice
WHERE s.Citta<>'Roma';

/* 8. Mostrare media, numero esami sostenuti e totale CFU acquisiti da studenti con matricola '709335' */
/*FORMA IMPLICITA*/
SELECT avg(e.Voto) as media_studi, count(e.Codice_modulo) as numero_esami_sostenuti, sum(m.CFU) as totale_CFU
FROM esame e, modulo m
WHERE e.Codice_modulo=m.Codice and e.Matricola_studente='709335';

/*FORMA ESPLICITA*/
SELECT avg(e.Voto) as media_studi, count(e.Codice_modulo) as numero_esami_sostenuti, sum(m.CFU) as totale_CFU
FROM esame e JOIN modulo m ON e.Codice_modulo=m.Codice
WHERE  e.Matricola_studente='709335';

/* 9.Mostrare nome, cognome, nome del corso di laurea, media e numero degli esami sostenuti dallo studente con matricola '709332' */
/*FORMA IMPLICITA*/
SELECT s.Nome, s.Cognome, cl.Nome as Corso_laurea,avg(e.Voto) as media_studi, count(e.Codice_modulo) as numero_esami_sostenuti
FROM studente s, corso_laurea cl, esame e
WHERE s.Matricola=e.Matricola_studente and s.Corso_laurea=cl.Codice and e.Matricola_studente='709332';

/*FORMA ESPLICITA*/
SELECT s.Nome, s.Cognome, cl.Nome as Corso_laurea,avg(e.Voto) as media_studi, count(e.Codice_modulo) as numero_esami_sostenuti
FROM corso_laurea cl JOIN studente s ON cl.Codice=s.Corso_laurea JOIN esame e ON s.Matricola=e.Matricola_studente
WHERE e.Matricola_studente='709332';

/* 10. Mostrare codice, nome e voto medio di ogni modulo, ordinati dalla media più alta alla più bassa */
/*FORMA IMPLICITA*/
SELECT e.Codice_modulo, m.Nome as Modulo, avg(e.Voto) as voto_medio_del_modulo
FROM modulo m, esame e
WHERE m.Codice=e.Codice_modulo
GROUP BY Codice_modulo
ORDER BY avg(e.Voto) desc;

/*FORMA ESPLICITA*/
SELECT e.Codice_modulo, m.Nome as Modulo, avg(e.Voto) as voto_medio_del_modulo
FROM modulo m JOIN esame e ON m.Codice=e.Codice_modulo
GROUP BY Codice_modulo
ORDER BY avg(e.Voto) desc;

/* 11. Mostrare nome e cognome del docente, nome e decrizione del modulo per ogni docente ed ogni modulo di cui quel
docente abbia tenuto almeno un esame; il risultato deve includere anche i docenti che non abbiano tenuto alcun esame, in quel caso rappresentati
con un unica tupla in cui nome e descrizione del modulo avranno valore null. */
/*FORMA ESPLICITA*/
select d.Nome as Nome_docente, d.Cognome as Cognome_docente, m.Nome as Nome_modulo, m.descrizione as Descrizione_modulo
from modulo m join esame e on m.Codice=e.Codice_modulo right join docente d on e.Matricola_docente=d.Matricola
group by m.Nome, d.Nome;

/* 12. Mostrare matricola, nome, cognome, data di nascita e numero esami sostenuti di ogni studente */
/*FORMA IMPLICITA*/
SELECT s.Matricola, s.Nome, s.Cognome, s.Data_nascita, count(e.Codice_modulo)as numero_esami_sostenuti
FROM studente s, esame e
WHERE s.Matricola=e.Matricola_studente
GROUP BY s.Matricola;

/*FORMA ESPLICITA*/
SELECT s.Matricola, s.Nome, s.Cognome, s.Data_nascita, count(e.Codice_modulo)as numero_esami_sostenuti
FROM studente s JOIN esame e ON s.Matricola=e.Matricola_studente
GROUP BY s.Matricola;

/* 13. Mostrare matricola, nome, cognome, data di nascita e numero esami sostenuti di ogni studente del CdL di nome 'INF' che abbia media maggiore di 26.*/
/*FORMA IMPLICITA*/
SELECT s.Matricola, s.Nome, s.Cognome, s.Data_nascita, count(e.Codice_modulo)as numero_esami_sostenuti
FROM studente s, esame e, corso_laurea cl
WHERE s.Matricola=e.Matricola_studente and s.Corso_laurea=cl.Codice and cl.Nome='INF'
GROUP BY s.Matricola
HAVING avg(e.Voto)>26;

/*FORMA ESPLICITA*/
SELECT s.Matricola, s.Nome, s.Cognome, s.Data_nascita, count(e.Codice_modulo)as numero_esami_sostenuti
FROM esame e JOIN studente s ON e.Matricola_studente=s.Matricola JOIN corso_laurea cl ON s.Corso_laurea=cl.Codice
WHERE cl.Nome='INF'
GROUP BY s.Matricola
HAVING avg(e.Voto)>26;

/* 14. Mostrare nome, cognome, data di nascita di tutti gli studenti che non hanno superato ancora nessun esame*/
/*FORMA NIDIFICATA*/
SELECT DISTINCT Nome, Cognome, Data_nascita
FROM studente
WHERE Matricola not in (select Matricola_studente
from esame);

/* 15. Mostrare la matricola di tutti gli studenti che hanno superato almeno un esame e che hanno preso sempre voti maggiori di 26*/
/*FORMA IMPLICITA*/
SELECT DISTINCT s.Matricola
FROM studente s, esame e
WHERE s.Matricola=e.Matricola_studente and e.Voto>26
HAVING count(e.Codice_modulo)>=1;

/*FORMA NIDIFICATA*/
SELECT DISTINCT s.Matricola
FROM studente s
WHERE s.Matricola in (select Matricola_studente
from esame e
where e.Voto>26
having count(e.Codice_modulo)>=1);

/* 16. Mostrare, per ogni modulo, il numero degli studenti che hanno preso tra 18 e 21, quelli che hanno preso tra 22 e 26 e quelli che
 hanno preso tra 27 e 30 (in un unica interrogazione) */
 /*FORMA ESPLICITA*/
select m.Nome,
sum(case when e.Voto>=18 and e.Voto<=21 then 1 else 0 end) as numero_studenti_tra_18_21,
sum(case when e.Voto>=22 and e.Voto<=26 then 1 else 0 end) as numero_studenti_tra_22_26,
sum(case when e.Voto>=27 and e.Voto<=30 then 1 else 0 end) as numero_studenti_tra_27_30
from modulo m left join esame e on m.Codice=e.Codice_modulo join studente s on e.Matricola_studente=s.Matricola
group by m.Codice;

/* 17. Mostrare matricola, nome, cognome e voto di ogni studente che ha preso un voto maggiore della media nel modulo 'BDD'*/
/*FORMA NIDIFICATA*/
SELECT s.Matricola, s.Nome, s.Cognome, e.Voto
FROM studente s, esame e, modulo m
WHERE s.Matricola=e.Matricola_studente and e.Codice_modulo=m.Codice
      and m.Nome='Basi di Dati'and e.Voto>( select avg(e.voto) from esame e
                                                where e.Codice_modulo='5');


/* 18. Mostrare matricola, nome, cognome di ogni studente che ha preso ad almeno tre esami un voto maggiore della media per quel modulo */
deve stampare matricola 709332,709333,709335
