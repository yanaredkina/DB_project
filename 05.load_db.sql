/* This script loads sample data for the VideoRental database */

USE VideoRental
SET NOCOUNT ON
GO


/* Load Clients table */


INSERT Clients VALUES('Pavarotti','Jose','187 Suffolk Ln.','+72085558097', 0, 0)
INSERT Clients VALUES('Kumar','Hari','90 Wadhurst Rd.','+79505551717', 0.1, -225)
INSERT Clients VALUES('Petersen','Jytte', 'Vinbaltet 34','+79101234564',0, 0)
INSERT Clients VALUES('Perrier','Dominique','25, rue Lauriston','+79064755601',0, 0)
INSERT Clients VALUES('Braunschweiger','Artem','P.O. Box 555','+73075554680', 0, 0)
INSERT Clients VALUES('Cartrain','Pascale','Boulevard Tirou, 255','+79102372220', 0, 0)
INSERT Clients VALUES('Nixon','Liz','89 Jefferson Way Suite 2','+75035553612', 0, 0)
INSERT Clients VALUES('Wong','Liu','55 Grizzly Peak Rd.','+74065555834', 0, -600)
INSERT Clients VALUES('Josephs','Karin','Luisenstr. 48','+79452510312', 0, -300)
INSERT Clients VALUES('Paolino','Miguel','Avda. Azteca 123','+79455902933', 0, 0)
GO



/* Load Movies table */


INSERT Movies VALUES('Gladiator', 'history', '2000-05-01', '02:35:00', 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery')
INSERT Movies VALUES('The Godfather', 'crime', '1972-03-14', '02:55:00', 'The Godfather follows Vito Corleone, Don of the Corleone family, as he passes the mantel to his unwilling son, Michael')
INSERT Movies VALUES('The Shawshank Redemption', 'drama', '1994-08-27', '02:22:00', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency')
INSERT Movies VALUES('Schindlers List', 'history','1993-11-30', '03:15:00', 'In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis')
INSERT Movies VALUES('Pulp Fiction','crime', '1994-05-21', '02:34:00', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption')
INSERT Movies VALUES('Forrest Gump', 'drama', '1994-06-23', '02:22:00', 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart')
INSERT Movies VALUES('The Matrix', 'sci-fi', '1999-03-24', '02:16:00', 'When a beautiful stranger leads computer hacker Neo to a forbidding underworld, he discovers the shocking truth--the life he knows is the elaborate deception of an evil cyber-intelligence')
INSERT Movies VALUES('The Silence of the Lambs', 'thriller', '1991-01-30', '01:58:00', 'A young F.B.I. cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer, a madman who skins his victims')
INSERT Movies VALUES('Interstellar', 'sci-fi', '2014-10-26', '02:49:00', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanitys survival')
INSERT Movies VALUES('Parasite', 'drama', '2019-05-21', '02:12:00', 'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan')
INSERT Movies VALUES('The Prestige', 'mystery', '2006-10-17', '02:10:00', 'After a tragic accident, two stage magicians in 1890s London engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other')
INSERT Movies VALUES('Alien', 'horror', '1979-05-25', '01:57:00', 'After a space merchant vessel receives an unknown transmission as a distress call, one of the crew is attacked by a mysterious life form and they soon realize that its life cycle has merely begun')
INSERT Movies VALUES('The Dark Knight Rises', 'action', '2012-07-16', '02:44:00', 'Eight years after the Jokers reign of anarchy, Batman, with the help of the enigmatic Catwoman, is forced from his exile to save Gotham City from the brutal guerrilla terrorist Bane')
INSERT Movies VALUES('The Wolf of Wall Street', 'biography', '2013-12-09', '03:00:00', 'Based on the true story of Jordan Belfort, from his rise to a wealthy stock-broker living the high life to his fall involving crime, corruption and the federal government')
INSERT Movies VALUES('Braveheart', 'history', '1995-05-18', '02:58:00', 'Scottish warrior William Wallace leads his countrymen in a rebellion to free his homeland from the tyranny of King Edward I of England')
INSERT Movies VALUES('Shutter Island', 'thriller', '2010-02-13', '02:18:00', 'In 1954, a U.S. Marshal investigates the disappearance of a murderer who escaped from a hospital for the criminally insane')
INSERT Movies VALUES('Kill Bill', 'action', '2003-09-29', '01:51:00', 'After awakening from a four-year coma, a former assassin wreaks vengeance on the team of assassins who betrayed her')
INSERT Movies VALUES('12 Years a Slave', 'biography', '2013-08-30', '02:14:00', 'In the antebellum United States, Solomon Northup, a free black man from upstate New York, is abducted and sold into slavery')
INSERT Movies VALUES('Hachi: A Dog''s Tale', 'family', '2009-06-13', '01:33:00', 'A college professor bonds with an abandoned dog he takes into his home')
INSERT Movies VALUES('Inception', 'sci-fi', '2010-07-08', '02:28:00', 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.')
INSERT Movies VALUES('The Intouchables', 'biography', '2011-09-23', '01:52:00', 'After he becomes a quadriplegic from a paragliding accident, an aristocrat hires a young man from the projects to be his caregiver')
INSERT Movies VALUES('Django Unchained', 'western', '2012-12-11', '02:45:00', 'With the help of a German bounty-hunter, a freed slave sets out to rescue his wife from a brutal plantation-owner in Mississippi')
INSERT Movies VALUES('Avengers: Infinity War', 'action', '2018-04-23', '02:29:00', 'The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe')
INSERT Movies VALUES('Capernaum', 'drama', '2018-05-17', '02:06:00', 'While serving a five-year sentence for a violent crime, a 12-year-old boy sues his parents for neglect')
INSERT Movies VALUES('Snatch', 'crime', '2000-09-01', '01:42:00', 'Unscrupulous boxing promoters, violent bookmakers, a Russian gangster, incompetent amateur robbers and supposedly Jewish jewelers fight to track down a priceless stolen diamond')
INSERT Movies VALUES('Green Book', 'drama', '2018-09-11', '02:10:00', 'A working-class Italian-American bouncer becomes the driver of an African-American classical pianist on a tour of venues through the 1960s American South')
INSERT Movies VALUES('Pan''s Labyrinth', 'fantasy', '2006-05-27', '01:58:00', 'In the Falangist Spain of 1944, the bookish young stepdaughter of a sadistic army officer escapes into an eerie but captivating fantasy world')
INSERT Movies VALUES('A Beautiful Mind', 'drama', '2001-12-13', '02:15:00', 'After John Nash, a brilliant but asocial mathematician, accepts secret work in cryptography, his life takes a turn for the nightmarish')
INSERT Movies VALUES('Harry Potter and the Sorcerer''s Stone', 'fantasy', '2001-11-04', '02:32:00', 'An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world')
INSERT Movies VALUES('The Sixth Sense', 'mystery', '1999-08-02', '01:47:00', 'A frightened, withdrawn Philadelphia boy who communicates with spirits seeks the help of a disheartened child psychologist')
GO



/* Load Tariffs table */



INSERT Tariffs VALUES('Tariff1', 50, 1000, 5)
INSERT Tariffs VALUES('Tariff2', 100, 2000, 10)
GO



/* Load Tapes table */


INSERT Tapes VALUES(1, 'VHS', '2000-12-01', 'Tariff2','1')
INSERT Tapes VALUES(2, 'VHS', '1999-11-05', 'Tariff1','1')
INSERT Tapes VALUES(3, 'VHS', '1995-12-10', 'Tariff1','1')
INSERT Tapes VALUES(4, 'VHS', '1998-06-01', 'Tariff2','1')
INSERT Tapes VALUES(5, 'VHS', '1999-12-14', 'Tariff1','0')
INSERT Tapes VALUES(6, 'VHS', '1997-04-03', 'Tariff1','1')
INSERT Tapes VALUES(7, 'VHS', '1999-12-21', 'Tariff2','1')
INSERT Tapes VALUES(8, 'VHS', '2000-12-01', 'Tariff1','1')
INSERT Tapes VALUES(9, 'DVD', '2016-03-10', 'Tariff2','1')
INSERT Tapes VALUES(10, 'DVD', '2020-12-11', 'Tariff1','1')
INSERT Tapes VALUES(11, 'VHS', '2007-02-01', 'Tariff1','1')
INSERT Tapes VALUES(12, 'VHS', '1990-01-31', 'Tariff2', '0')
INSERT Tapes VALUES(13, 'DVD', '2018-05-11', 'Tariff2','1')
INSERT Tapes VALUES(14, 'DVD', '2014-02-09', 'Tariff2','1')
INSERT Tapes VALUES(7, 'DVD', '2005-11-23', 'Tariff1','1')
INSERT Tapes VALUES(15, 'VHS', '1995-07-01', 'Tariff1','1')
INSERT Tapes VALUES(16, 'DVD', '2010-03-15', 'Tariff2','1')
INSERT Tapes VALUES(17, 'VHS', '2003-11-08', 'Tariff1','1')
INSERT Tapes VALUES(17, 'DVD', '2010-12-26', 'Tariff2','1')
INSERT Tapes VALUES(18, 'DVD', '2014-06-10', 'Tariff2','1')
INSERT Tapes VALUES(19, 'VHS', '2009-08-24', 'Tariff1','1')
INSERT Tapes VALUES(20, 'VHS', '2010-09-09', 'Tariff1','1')
INSERT Tapes VALUES(20, 'VHS', '2011-03-29', 'Tariff1','1')
INSERT Tapes VALUES(21, 'VHS', '2011-02-09', 'Tariff2','1')
INSERT Tapes VALUES(22, 'DVD', '2012-10-17', 'Tariff1','1')
INSERT Tapes VALUES(23, 'DVD', '2018-01-05', 'Tariff2','1')
INSERT Tapes VALUES(23, 'DVD', '2020-12-19', 'Tariff2','1')
INSERT Tapes VALUES(24, 'DVD', '2018-09-27', 'Tariff1','1')
INSERT Tapes VALUES(25, 'VHS', '2000-06-16', 'Tariff1','1')
INSERT Tapes VALUES(26, 'DVD', '2019-12-18', 'Tariff1','1')
INSERT Tapes VALUES(27, 'VHS', '2007-07-01', 'Tariff2','1')
INSERT Tapes VALUES(28, 'VHS', '2002-03-21', 'Tariff1','1')
INSERT Tapes VALUES(29, 'VHS', '2001-07-12', 'Tariff2','1')
INSERT Tapes VALUES(29, 'VHS', '2002-12-23', 'Tariff2','1')
INSERT Tapes VALUES(29, 'DVD', '2010-05-03', 'Tariff2','1')
INSERT Tapes VALUES(30, 'VHS', '2000-08-21', 'Tariff1','1')
INSERT Tapes VALUES(1, 'VHS', '2010-09-12', 'Tariff2','1')
INSERT Tapes VALUES(2, 'VHS', '2000-12-11', 'Tariff1','1')
INSERT Tapes VALUES(5, 'VHS', '2001-06-09', 'Tariff1','1')
INSERT Tapes VALUES(6, 'VHS', '2001-10-26', 'Tariff1','1')
INSERT Tapes VALUES(9, 'DVD', '2016-03-17', 'Tariff2', '0')
INSERT Tapes VALUES(10, 'DVD', '2021-12-14', 'Tariff2','1')
INSERT Tapes VALUES(15, 'VHS', '2005-06-19', 'Tariff1','1')
INSERT Tapes VALUES(13, 'DVD', '2017-04-03', 'Tariff1','1')
INSERT Tapes VALUES(12, 'VHS', '1998-12-11', 'Tariff2','1')
INSERT Tapes VALUES(22, 'DVD', '2016-08-26', 'Tariff2','1')
INSERT Tapes VALUES(25, 'VHS', '2007-11-01', 'Tariff1','1')
INSERT Tapes VALUES(14, 'DVD', '2015-02-04', 'Tariff1','1')
INSERT Tapes VALUES(19, 'VHS', '2010-10-19', 'Tariff1','1')
INSERT Tapes VALUES(3, 'VHS', '1998-12-26', 'Tariff2','1')
GO


/* Load Proposals table */


INSERT Proposals VALUES(2, 'Green Book', '2021-01-20', '2021-02-27', 30)
INSERT Proposals VALUES(2, 'Tenet', '2021-04-29', NULL, NULL)
GO


/* Load Rental table */


INSERT Rental VALUES(1, 37, '2021-01-15', '2021-01-20', '0', 500, '2021-01-20', 0)
INSERT Rental VALUES(2,17, '2021-01-18', '2021-01-29', '0', 1100, '2021-01-29', 0)
INSERT Rental VALUES(3,25, '2021-02-01', '2021-02-04', '0', 150, '2021-02-05', 5)
INSERT Rental VALUES(2,20, '2021-02-16', '2021-02-18', '0', 200, '2021-02-18', 0)
INSERT Rental VALUES(4,3, '2021-03-20', '2021-03-27', '0', 350, '2021-03-27', 0)
INSERT Rental VALUES(5,10, '2021-03-25', '2021-03-30', '1', 250, '2021-03-30', 0)
INSERT Rental VALUES(2,47, '2021-04-06', '2021-04-10', '0', 200, '2021-04-10', 0)
INSERT Rental VALUES(6,34, '2021-04-15', '2021-04-21', '0', 600, '2021-04-21', 0)
INSERT Rental VALUES(2,9, '2021-04-26', '2021-04-29', '0', 300, '2021-04-29', 0)
INSERT Rental VALUES(7,35, '2021-05-04', '2021-05-12', '0', 800, '2021-05-14', 20)
INSERT Rental VALUES(2,35, '2021-05-13', '2021-05-18', '0', 500, '2021-05-18', 0)
INSERT Rental VALUES(10,13, '2021-06-03', '2021-06-10', '0', 350, '2021-06-10', 0)
INSERT Rental VALUES(8,41, '2021-07-12', '2021-07-18', '1', 600, NULL, NULL)
INSERT Rental VALUES(9,12, '2021-07-20', '2021-07-23', '1', 300, NULL, NULL)
INSERT Rental VALUES(2,5, '2021-08-01', '2021-08-06', '1', 225, NULL, NULL)
GO



SET NOCOUNT OFF
GO