/*
оформление SQL-скрипта (в стандарте
PostgreSQL), создающего набор таблиц в соответствии с созданными
диаграммами (без наполнения).
*/
DROP TABLE IF EXISTS 
    public.dish_categories,
    public.dishes,
    public.dish_categories_and_dishes,
	public.dish_photos,
	public.dishes_and_techniques,
	public.techniques,
	public.dishes_and_ingredients,
	public.ingredients,
	public.mappings,
	public.ingredient_photos,
	public.synonyms,
	public.standart_units,
	public.non_standart_units	
CASCADE;

CREATE TABLE IF NOT EXISTS public.dish_categories
(
    name varchar(64) NOT NULL CHECK (LENGTH(name) > 0),
    category_id serial,
    parent_id integer,
    vertical_order integer,
    horizontal_order integer,
    PRIMARY KEY (category_id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS public.dishes
(
    dish_id serial,
    name varchar(64) NOT NULL CHECK (LENGTH(name) > 0),
    total_time interval NOT NULL CHECK (total_time > interval '0 seconds'),
    instructions text NOT NULL CHECK (LENGTH(instructions) > 0),
    PRIMARY KEY (dish_id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS public.dish_categories_and_dishes
(
    category_id integer,
    dish_id integer,
    PRIMARY KEY (category_id, dish_id)
);

CREATE TABLE IF NOT EXISTS public.dish_photos
(
    dish_id integer NOT NULL,
    photo_path varchar(64) NOT NULL CHECK (LENGTH(photo_path) > 0),
    photo_id serial,
    PRIMARY KEY (photo_id),
    UNIQUE (photo_path,dish_id)
);

CREATE TABLE IF NOT EXISTS public.dishes_and_techniques
(
    technic_id integer,
    dish_id integer,
    PRIMARY KEY (technic_id, dish_id)
);

CREATE TABLE IF NOT EXISTS public.techniques
(
    technic_name varchar(64) NOT NULL CHECK (LENGTH(technic_name) > 0),
    technic_id serial,
    PRIMARY KEY (technic_id),
    UNIQUE (technic_name)
);

CREATE TABLE IF NOT EXISTS public.dishes_and_ingredients
(
    dish_id integer,
    ingredient_id integer,
    quantity numeric(6, 2) NOT NULL CHECK (quantity > 0),
    standart_unit_id integer NOT NULL,
    PRIMARY KEY (dish_id, ingredient_id)
);

CREATE TABLE IF NOT EXISTS public.ingredients
(
    description text NOT NULL CHECK (LENGTH(description) > 0),
    name varchar(64) NOT NULL CHECK (LENGTH(name) > 0),
    ingredient_id serial,
    PRIMARY KEY (ingredient_id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS public.mappings
(
	mapping_id serial,
    non_standart_unit_id integer,
    ingredient_id integer,
    standart_quantity numeric(6, 2) NOT NULL CHECK (standart_quantity > 0),
    standart_unit_id integer NOT NULL,
    PRIMARY KEY (mapping_id),
    UNIQUE (non_standart_unit_id, ingredient_id, standart_unit_id)
);

CREATE TABLE IF NOT EXISTS public.ingredient_photos
(
    ingredient_id integer NOT NULL,
    photo_path varchar(64) NOT NULL CHECK (LENGTH(photo_path) > 0),
    photo_id serial,
    PRIMARY KEY (photo_id),
    UNIQUE (photo_path, ingredient_id)
);

CREATE TABLE IF NOT EXISTS public.synonyms
(
    alt_name varchar(64) NOT NULL CHECK (LENGTH(alt_name) > 0),
    ingredient_id integer NOT NULL,
    synonym_id serial,
    PRIMARY KEY (synonym_id),
    UNIQUE (alt_name)
);

CREATE TABLE IF NOT EXISTS public.standart_units
(
    standart_unit_id serial,
    standart_unit_name varchar(32) NOT NULL CHECK (LENGTH(standart_unit_name) > 0),
    PRIMARY KEY (standart_unit_id),
    UNIQUE (standart_unit_name)
);

CREATE TABLE IF NOT EXISTS public.non_standart_units
(
    non_standart_unit_id serial,
    non_standart_unit_name varchar(64) NOT NULL CHECK (LENGTH(non_standart_unit_name) > 0),
    PRIMARY KEY (non_standart_unit_id),
    UNIQUE (non_standart_unit_name)
);

ALTER TABLE IF EXISTS public.dish_categories
    ADD FOREIGN KEY (parent_id)
    REFERENCES public.dish_categories (category_id)
	ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.dish_categories_and_dishes
    ADD FOREIGN KEY (category_id)
    REFERENCES public.dish_categories (category_id)
	ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.dish_categories_and_dishes
    ADD FOREIGN KEY (dish_id)
    REFERENCES public.dishes (dish_id)
	ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.dish_photos
    ADD FOREIGN KEY (dish_id)
    REFERENCES public.dishes (dish_id)
	ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.dishes_and_techniques
    ADD FOREIGN KEY (technic_id)
    REFERENCES public.techniques (technic_id)
	ON DELETE CASCADE;

	
ALTER TABLE IF EXISTS public.dishes_and_techniques
    ADD FOREIGN KEY (dish_id)
    REFERENCES public.dishes (dish_id) 
	ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.dishes_and_ingredients
    ADD FOREIGN KEY (dish_id)
    REFERENCES public.dishes (dish_id)
	ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.dishes_and_ingredients
    ADD FOREIGN KEY (ingredient_id)
    REFERENCES public.ingredients (ingredient_id)
	ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.dishes_and_ingredients
    ADD FOREIGN KEY (standart_unit_id)
    REFERENCES public.standart_units (standart_unit_id)
	ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.mappings
    ADD FOREIGN KEY (ingredient_id)
    REFERENCES public.ingredients (ingredient_id)
	ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.mappings
    ADD FOREIGN KEY (non_standart_unit_id)
    REFERENCES public.non_standart_units (non_standart_unit_id)
	ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.mappings
    ADD FOREIGN KEY (standart_unit_id)
    REFERENCES public.standart_units (standart_unit_id)
	ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.ingredient_photos
    ADD FOREIGN KEY (ingredient_id)
    REFERENCES public.ingredients (ingredient_id)
	ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.synonyms
    ADD FOREIGN KEY (ingredient_id)
    REFERENCES public.ingredients (ingredient_id)
	ON DELETE CASCADE;
