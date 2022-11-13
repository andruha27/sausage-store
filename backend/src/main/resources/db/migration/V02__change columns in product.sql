ALTER TABLE public.product
    ADD COLUMN name character varying(20) COLLATE pg_catalog."default" NOT NULL;	
ALTER TABLE public.product
    ADD COLUMN picture_url character varying(100) COLLATE pg_catalog."default";