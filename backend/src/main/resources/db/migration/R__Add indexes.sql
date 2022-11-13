CREATE INDEX order_id IF NOT EXISTS ON public.order_product USING btree (order_id);
CREATE INDEX product_id IF NOT EXISTS  ON public.order_product USING btree (product_id);
