/*
Заполните таблицы осознанными данными
*/
TRUNCATE TABLE 
dish_categories,
dish_categories_and_dishes,
dish_photos,
dishes,
dishes_and_ingredients,
dishes_and_techniques,
ingredient_photos,
ingredients,
mappings,
non_standart_units,
standart_units,
synonyms,
techniques
RESTART IDENTITY CASCADE;
INSERT INTO ingredients (description, name) VALUES
('Пшеничная мука высшего сорта', 'Мука'),
('Куриное яйцо категории С0', 'Яйцо'),
('Белый свекловичный сахар', 'Сахар'),
('Масло с жирностью 82.5%, несоленое', 'Сливочное масло'),
('Твердый итальянский сыр, выдержка 24 месяца', 'Пармезан'),
('Грудка куриная без кости и кожи', 'Куриное филе'),
('Молодой картофель, сорт "Гала"', 'Картофель'),
('Свежий чеснок, головки среднего размера', 'Чеснок'),
('Морская соль крупного помола', 'Соль'),
('Черный листовой чай', 'Чай'),
('Масло холодного отжима Extra Virgin', 'Оливковое масло'),
('Питьевая очищенная вода', 'Вода');

INSERT INTO standart_units (standart_unit_name) VALUES
('грамм'),
('миллилитр'),
('штука'),
('литр'),
('килограмм');

INSERT INTO non_standart_units (non_standart_unit_name) VALUES
('щепотка'),
('стакан'),
('зубчик'),
('чайная ложка'),
('столовая ложка');
INSERT INTO mappings (non_standart_unit_id, ingredient_id, standart_quantity, standart_unit_id) VALUES
-- Стакан
(2, 1, 160.00, 1), 
(2, 3, 200.00, 1),
(2, 4, 200.00, 1), 
(2, 12, 250.00, 2), 
-- Щепотка
(1, 9, 2.00, 1),
-- Зубчик 
(3, 8, 5.00, 1),    
-- Чайная ложка
(4, 3, 5.00, 1),    
(4, 9, 6.00, 1),     
(4, 10, 2.00, 1),   
(4, 1, 3.00, 1),     
(4, 11, 5.00, 2),    
-- Столовая ложка
(5, 3, 15.00, 1),    
(5, 9, 18.00, 1),    
(5, 10, 6.00, 1),    
(5, 1, 9.00, 1),     
(5, 11, 15.00, 2);   

INSERT INTO dishes (name, total_time, instructions) VALUES
('Бисквит', '01:00:00', 'Смешать яйца, сахар и муку. Выпекать 40 минут.'),
('Жареная курица с картофелем', '00:45:00', 'Обжарить куриное филе на сливочном масле, добавить картофель.'),
('Чай черный', '00:05:00', 'Заварить чай в кипятке, добавить сахар по вкусу.'),
('Куриный суп', '02:00:00', 'Сварить бульон из куриного филе, добавить картофель, чеснок, соль.'),
('Картофельное пюре', '00:30:00', 'Сварить картофель, размять в пюре с добавлением сливочного масла и соли.'),
('Картофель по-деревенски', '00:40:00', 'Нарезать картофель дольками, добавить чеснок, соль, полить сливочным маслом и запечь в духовке.');

INSERT INTO dish_photos (dish_id, photo_path) VALUES
(1, '/images/dishes/biscuit.jpg'),
(2, '/images/dishes/chicken_with_potato.jpg'),
(3, '/images/dishes/black_tea.jpg'),
(4, '/images/dishes/chicken_soup.jpg'),
(5, '/images/dishes/mashed_potato.jpg'),
(6, '/images/dishes/country_style_potato.jpg');

INSERT INTO techniques (technic_name) VALUES
('Варочная панель'),
('Духовой шкаф'),
('Миксер'),
('Чайник электрический'),
('Сковорода'),
('Кастрюля');

INSERT INTO ingredient_photos (ingredient_id, photo_path) VALUES
(1, '/images/ingredients/flour.jpg'),      
(2, '/images/ingredients/egg.jpg'),         
(3, '/images/ingredients/sugar.jpg'),       
(4, '/images/ingredients/butter.jpg'),       
(5, '/images/ingredients/parmesan.jpg'),     
(6, '/images/ingredients/chicken.jpg'),      
(7, '/images/ingredients/potato.jpg'),      
(8, '/images/ingredients/garlic.jpg'),       
(9, '/images/ingredients/salt.jpg'),         
(10, '/images/ingredients/tea.jpg'),         
(11, '/images/ingredients/olive_oil.jpg'),   
(12, '/images/ingredients/water.jpg');       

INSERT INTO synonyms (alt_name, ingredient_id) VALUES
('Мука пшеничная', 1),      
('Куриное яйцо', 2),        
('Сахар-песок', 3),         
('Масло сливочное', 4),    
('Итальянский сыр', 5); 

INSERT INTO dish_categories (name, parent_id, vertical_order, horizontal_order) VALUES
('Супы', NULL, 1, 1),
('Горячие', 1, 2, 1),
('Холодные', 1, 2, 2),
('Второе', NULL, 1, 2),
('Гарнир', 4, 2, 1),
('Основное блюдо', 4, 2, 2),
('Напитки', NULL, 1, 3),
('Горячие напитки', 7, 2, 1),
('Холодные напитки', 7, 2, 2),
('Десерты', NULL, 1, 4);

INSERT INTO dish_categories_and_dishes (category_id, dish_id) VALUES
(10, 1),  
(4, 2),   
(6, 2),   
(7, 3),  
(8, 3),  
(1, 4),   
(2, 4),  
(4, 5),  
(5, 5),  
(4, 6), 
(5, 6);  

INSERT INTO dishes_and_techniques (dish_id, technic_id) VALUES
(1, 2),  
(1, 3),  
(2, 1),  
(2, 5),  
(3, 4),  
(4, 1),  
(4, 6),  
(5, 1),  
(5, 6),  
(6, 2);  

INSERT INTO dishes_and_ingredients (dish_id, ingredient_id, quantity, standart_unit_id) VALUES
(1, 1, 200.00, 1),
(1, 2, 4.00, 3),
(1, 3, 150.00, 1),
(2, 6, 500.00, 1),
(2, 11, 10.00, 2),
(2, 7, 600.00, 1),
(2, 9, 6.00, 1),
(3, 10, 4.00, 1),
(3, 12, 250.00, 2),
(4, 6, 300.00, 1),
(4, 7, 200.00, 1),
(4, 8, 10.00, 1),
(4, 9, 6.00, 1),
(4, 12, 1500.00, 2),
(5, 7, 800.00, 1),
(5, 4, 50.00, 1),
(5, 9, 6.00, 1),
(5, 12, 100.00, 2),
(6, 7, 700.00, 1),
(6, 8, 15.00, 1),
(6, 4, 40.00, 1),
(6, 9, 6.00, 1);
