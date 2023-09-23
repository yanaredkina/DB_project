                        /* ТЕСТИРОВАНИЕ ОБЪЕКТОВ БАЗЫ ДАННЫХ VideoRental */



/****************************************** начало *******************************************************/
                /* Просмотр исходных таблиц (какая информация содержится в каждой таблице) */


--- В таблице Clients содержится информация о клиентах видеопроката
USE VideoRental
GO
SELECT TOP 5 *
FROM Clients
GO

--- В таблице Movies содержится информация о фильмах

USE VideoRental
GO
SELECT TOP 5 *
FROM Movies
GO

--- В таблице Tapes содержится информация о кассетах, на которых записаны фильмы

USE VideoRental
GO
SELECT TOP 5 *
FROM Tapes
GO

--- В таблице Tariffs содержится информация о тарифах видеопроката

USE VideoRental
GO
SELECT TOP 5 *
FROM Tariffs
GO

--- В таблице Proposals содержится информация о предложениях клиентов на обновление каталога кассет

USE VideoRental
GO
SELECT TOP 5 *
FROM Proposals
GO

--- В таблице Rental содержится информация об операциях видеопроката (выдача и возврат кассет)

USE VideoRental
GO
SELECT TOP 5 *
FROM Rental
GO




/********************************************************************************************************/
                        /* Проверка работы созданных ограничений целостности */


--- На таблице Clients созданы 2 Default ограничения: на колонках Discount и Balance значения по умолчанию = 0

USE VideoRental
GO
INSERT Clients(LastName, FirstName, Address, Phone_no)
        VALUES('Smith', 'Nick', '1st Yellow Av. 3', '+73023902873')
GO
SELECT * 
FROM Clients
WHERE ClientID = @@IDENTITY
GO


--- На таблице Tapes создано 1 Default ограничение: на колонке Available значение по умолчанию = 1 (1 - кассета доступна, 0 - кассета не доступна)
USE VideoRental
GO
INSERT Tapes(MovieID, Type, DateManufacture, TariffID)
        VALUES(5, 'DVD', '2020-10-13', 'Tariff2')
GO
SELECT * 
FROM Tapes
WHERE TapeID = @@IDENTITY
GO

--- На таблице Clients создано 1 Chek ограничение, которое проверяет, что номер телефона клиента задан в нужном формате (начинается с +7 и далее 10 цифр)

USE VideoRental
GO
INSERT Clients(LastName, FirstName, Address, Phone_no)
        VALUES('Black', 'Lora', 'Traflet st, 123', '23902873') -- будет ошибка!
GO  

--- На таблице Tariffs создано 1 Chek ограничение, которое проверяет, что штраф за просрочку возврата кассеты меньше, чем сумма стоимости самого проката (за день)

USE VideoRental
GO
INSERT Tariffs(TariffID, PricePerDay, DepositAmount, FinePerDay)
        VALUES('Tariff3', 60, 1500, 65) -- будет ошибка!
GO  

--- На таблице Rental создано 3 Chek ограничения: два проверют, чтобы даты предполагаемого возврата кассеты и фактического возврата были позже даты выдачи кассеты

USE VideoRental
GO
INSERT Rental(ClientID, TapeID, OutDate, DueDate, Deposit, RentPrice, ReturnDate, Fine)
        VALUES(10, 44, '2021-12-05', '2021-12-01', '1', 200, NULL, NULL) -- будет ошибка!
GO 

--- и еще одно chek ограничение на таблице Rental проверяет, чтобы стоимость аренды была числом положительным

USE VideoRental
GO
INSERT Rental(ClientID, TapeID, OutDate, DueDate, Deposit, RentPrice, ReturnDate, Fine)
        VALUES(10, 44, '2021-12-05', '2021-12-10', '1', -200, NULL, NULL) -- будет ошибка!
GO 




/********************************************************************************************************/
                        /* Просмотр созданных представлений */


--- Представление MoviesCatalogForClients создано как каталог для клиентов видеопроката. Оно включает в себя колонки 3 таблиц:
--- вся информация о фильме из таблицы Movies, ID и тип кассеты и ее доступность для аренды из таблицы Tapes, а также основная информация о тарифе из таблицы Tariffs
USE VideoRental
GO
SELECT * FROM MoviesCatalogForClients


--- Представление CostReportForManagement создано как отчет для менеджеров/бухгалтеров/руководства. 
--- Содержит информацю про денежные расчеты, цены и балансы. Включает две таблицы: Renral и Clients.
USE VideoRental
GO
SELECT * FROM CostReportForManagement


--- Представление ActivityReportForManagement создано как отчет для руководства. Включает топ-5 самых популярных фильма, которые берут в прокате.
--- Выводит название и ID фильма из таблицы Movies и общее количество, сколько этот фильм арендовали из таблицы Rental.
USE VideoRental
GO
SELECT * FROM ActivityReportForManagement

--- Представление ProposalReportForManagement создано как отчет для руководства. 
--- Выводит информацию о предложениях от постоянных клиентов на пополнение каталога новыми фильмами из таблицы Proposals (без учета тех, которые уже были по просьбам добавлены).
USE VideoRental
GO
SELECT * FROM ProposalReportForManagement




/********************************************************************************************************/
                        /* Проверка работы созданных триггеров (на таблице Rental) */


                        
--- В момент выдачи кассеты клиенту, т.е. когда происходит операция INSERT новой записи в таблице Rental, срабатывают два триггера:
--- триггер TR_Tapes_NotAvailable устанавливает в таблице Tapes на колонке Available статус '0' (т.е. недоступна) для кассеты, которую выдали в прокат;
--- триггер TR_Client_Balance_credit минусует баланс клиента (колонка Balance в таблице Clients), арендовавшего кассету, на стоимость аренды (поле RentPrice из таблицы Rental).
--- Отрицательный баланс показывает, что у клиента есть задолженность за пользование кассеты.

USE VideoRental
GO

SELECT TapeID, Available -- проверяем что изначально кассета с ID 40 доступна (статус = 1)
FROM Tapes
WHERE TapeID = 40
GO


SELECT ClientID, Balance -- проверяем что изначально у клиента с ID 9 баланс -300 (уже что-то в аренде)
FROM Clients
WHERE ClientID = 9
GO


INSERT Rental(ClientID, TapeID, OutDate, DueDate, Deposit, RentPrice, ReturnDate, Fine)
        VALUES(9, 40, '2021-12-06', '2021-12-10', '1', 200, NULL, NULL)
GO 
SELECT * 
FROM Rental 
WHERE RentalID = @@IDENTITY
GO

SELECT TapeID, Available -- теперь будет статус 0 (кассета недоступна)
FROM Tapes
WHERE TapeID = 40
GO

SELECT ClientID, Balance -- теперь будет -500 (задолженность клиента возрасла)
FROM Clients
WHERE ClientID = 9
GO




--- В момент возврата кассеты, т.е. когда проиходит UPDATE таблицы Rental и проставляется дата фактического возврата, срабатывают два аналогичных триггера:
--- триггер TR_Tapes_Available устанавливает в таблице Tapes на колонке Available статус '1' (т.е. доступна) для кассеты, которую вернули;
--- триггер TR_Client_Balance_debit плюсует баланс клиента на оплаченную стоимость проката (колонка Balance в таблице Clients).


USE VideoRental
GO
UPDATE Rental
SET ReturnDate = '2021-12-10', Fine = 0
WHERE ClientID = 9 AND TapeID = 40
GO 

SELECT TapeID, Available -- теперь будет статус 1 (кассета доступна)
FROM Tapes
WHERE TapeID = 40
GO

SELECT ClientID, Balance -- теперь снова будет -300
FROM Clients
WHERE ClientID = 9
GO





/********************************************************************************************************/
                        /* Проверка работы созданных хранимых процедур */
                        
                        

--- Процедура PlanningReturnDate показывает предполагаемую дату возврата определенной кассеты.
--- Параметр: TapeID

USE VideoRental
GO
EXEC PlanningReturnDate 12
GO




--- Процедура  FindMovie осуществляет поиск по каталогу фильмов. Если фильм в каталоге присутствует будет выведена также информация о кассете и ее доступности для аренды
--- Параметр: название фильма

USE VideoRental
GO
EXEC FindMovie 'Schindlers List'
GO




--- Процедура IsRegularClient проверяет, является ли клиент постоянным или нет.
--- Параметр: ClientID

USE VideoRental
GO
EXEC IsRegularClient 1 
GO

-----------
USE VideoRental
GO        
EXEC IsRegularClient 2
GO





--- Процедура AddProposal регистрирует предложение от постоянных клиентов на обновление каталога фильма (т.е. происходит добавление новой записи в таблицу Proposals).
--- Дата заявки регистрируется как текущая (колонка DateOfProposal).
--- Параметры: ClientID, название фильма


USE VideoRental
GO
EXEC AddProposal 1, 'Queens Gambit' -- не будет добавлено, т.к. клиент не является постоянным  
GO

-----------
USE VideoRental
GO
EXEC AddProposal 2, 'Jurassic Park' -- клиент постоянный, предложение будет добавлено
GO
SELECT * 
FROM Proposals 
WHERE ProposalID = @@IDENTITY
GO





--- Процедура RentTape оформляет операцию выдачи кассеты. Вначале проверяется, что выбранная кассета в наличии (статус '1' в поле Available таблицы Tapes).
--- Затем в таблицу Rental добавляется новая запись со статусом '1' в поле Deposit (залог получен) и с автоматическим вычислением стоимости аренды в зависимости от:
    -- количества дней проката (колонки OutDate и DueDate таблицы Rental);
    -- тарифа (данные из таблицы Tariffs);
    -- наличия у клиента скидки (колонка Discount таблицы Clients).
--- После оформления операции выдачи (т.е. после добавления новой записи в таблицу Rental) срабатывают триггеры на обновление статуса кассеты и баланса клиента.
--- Параметры: ClientID, TapeID, дата выдачи, дата возврата (предполагаемая).


USE VideoRental
GO
SELECT TapeID, Available
FROM Tapes
WHERE TapeID = 12              -- проверим, что кассеты с ID=12 нет в наличии (статус '0' колонки Available таблицы Tapes)
GO


EXEC RentTape 5, 12, '2021-12-10', '2021-12-11' -- Не будет оформлена выдача этой кассеты другому клиенту, потому что ее нет в наличии 
GO

------------

USE VideoRental
GO

SELECT TapeID, PricePerDay, Available
FROM MoviesCatalogForClients
WHERE TapeID = 27               -- проверим наличие кассеты c ID=27 и узнаем стоимость ее аренды за день 
GO

SELECT ClientID, Discount
FROM Clients
WHERE ClientID = 2               -- проверим наличие скидки у постоянного клиента c ID=2
GO

EXEC RentTape 2, 27, '2021-12-10', '2021-12-13' -- У кассеты с ID=27 тариф 100/в день, кол-во дней проката 3, клиент с ID=2 имеет скидку 10%
GO                                              -- Значит стоимость аренда для него будет: 100*3-0.1*100*3 = 270
SELECT * 
FROM Rental 
WHERE RentalID = @@IDENTITY      -- регистрационный номер (RentalID) присвоен 19
GO







--- Процедура ReturnTape оформляет операцию возврата кассеты. В таблице Rental обновляются поля:
         -- дата фактического возврата кассеты (колонка ReturnDate);
         -- штраф при наличии (колонка Fine);
         -- статус залога устанавливается в '0' - залог возвращен (колонка Deposit)
--- Значение колонки Fine (штраф) вычисляется автоматически на основании количества дней просрочки (таблица Rental) и установленного тарифа за просрочку (таблица Tariffs).
--- После оформления операции возврата (т.е. после обновления записи в таблице Rental) срабатывают триггеры на обновление статуса кассеты и баланса клиента.
--- Параметры: RentalID, дата возврата (фактическая).


USE VideoRental    -- сделаем возврат кассеты (с просрочкой), выданной в предыдущем примере
GO

SELECT TapeID, FinePerDay
FROM MoviesCatalogForClients
WHERE TapeID = 27               -- узнаем стоимость штрафа за день просрочки аренды у кассеты с c ID=27
GO

EXEC ReturnTape 19, '2021-12-15'  -- просрочка на 2 дня
GO

SELECT *                        -- У кассеты с с ID=27 штраф за просрочку 10/в день, кол-во дней просрочки 2.
FROM Rental                     -- Тогда всего штраф к выплате клиентов составляет: 10*2 = 20
WHERE RentalID = 19
GO








--- Процедура AddTape оформляет операцию добавления в каталог новой кассеты с фильмом из списка заявок от постоянных клиентов.
--- Сначала проверяется, что такого фильма действительно нет в каталоге (по названию фильма).
--- Далее в таблицу Movies добавляется новая запись с полной информацией о фильме, а в таблицу Tapes добавляется новая информация о кассете с этим фильмом;
--- В таблице Proposals делается обновление записи с той заявкой, откуда был взят фильм: указывается дата добавления фильма и MovieID нового фильма в каталоге;
--- Дата добавления фильма (колонка DateOfAddiction в таблице Proposals) регистрируется как текущая.
--- Параметры: название фильма, жанр, дата выхода фильма, продолжительность, описание сюжета, тип кассеты, дата производства кассеты, тариф. 


USE VideoRental
GO

EXEC FindMovie 'Forrest Gump'   -- проверим наличие в каталоге фильма "Форест Гамп"
GO
EXEC AddTape 'Forrest Gump', 'drama', '1994-06-23', '02:22:00', 'Some Discription', 'VHS', '2000-01-01', 'Tariff1' -- пытаемся добавить этот фильм еще раз - процедура не выполнится
GO


------------
USE VideoRental
GO

SELECT * FROM Proposals   -- посмотрим на список заявок и выберем из них для добавления в каталог фильм Tenet ("Довод") из заявки с ID = 2
GO

EXEC AddTape 'Tenet', 'sci-fi', '2020-08-26', '02:30:00', 'Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time', 'DVD', '2021-01-01', 'Tariff2'
GO

SELECT *            -- проверим обновление каталога с фильмами (новый MovieID = 31)
FROM Movies
WHERE Title = 'Tenet'
GO

SELECT *            -- проверим обновление каталога с кассетами
FROM Tapes
WHERE MovieID = 31
GO

SELECT * FROM Proposals    -- проверим, что в таблице заявок (Psoposals) появилась дата добавления фильма (колонка DateOfAddiction) и новый ID фильма (колонка MovieID)
WHERE ProposalID = 2
GO





--- Процедура RemoveTape удаляет из каталога кассету, если она была повреждена клиентом. 
--- При этом залог клиенту не возвращается (после оформления возврата колонка Deposit остается в статусе '1').
--- Из таблицы Tapes полностью удаляется запись с кассетой. Т.к. в таблице Rental существует внешний ключ (TapeID), ссылающийся на таблицу Tapes - в нем будет проставлен NULL.  
--- Параметры: TapeID, ClientID


USE VideoRental  -- пусть операция возврата из предыдущего примера была с испорченной кассетой (RentalID = 19, TapeID = 27, ClientID = 2)
GO

EXEC RemoveTape 27, 2
GO

SELECT *
FROM Tapes
WHERE TapeID = 27    -- запрос ничего не вернет: такой кассеты больше нет в каталоге
GO 

SELECT RentalID, ClientID, TapeID, Deposit  -- колонка TapeID будет пустая, а колонка Deposit будет со значением '1' (залог остается в кассе)
FROM Rental
WHERE ClientID = 2 AND RentalID = 19
GO


/************************************************ конец *************************************************/