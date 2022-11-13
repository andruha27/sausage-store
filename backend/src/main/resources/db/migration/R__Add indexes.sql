CREATE INDEX IF NOT EXISTS order_id ON public.order_product USING btree (order_id);
CREATE INDEX IF NOT EXISTS product_id ON public.order_product USING btree (product_id);