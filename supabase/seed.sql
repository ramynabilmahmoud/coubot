-- ============================================================
-- Coubot – Dummy Data Seed
-- Run this in: Supabase Dashboard → SQL Editor → New Query
-- ============================================================

-- ── 0. Add Arabic name column to categories (run once) ───────
ALTER TABLE categories ADD COLUMN IF NOT EXISTS name_ar TEXT;

-- Update existing categories with Arabic names
UPDATE categories SET name_ar = 'مشروبات' WHERE name = 'Dinks';
UPDATE categories SET name_ar = 'برجر'     WHERE name = 'Burgers';

-- ── 1. Categories ─────────────────────────────────────────────
INSERT INTO categories (name, name_ar, icon_key, media_source) VALUES
  ('Pizza',     'بيتزا',       'pizza',    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&fit=crop'),
  ('Desserts',  'حلويات',      'dessert',  'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=400&fit=crop'),
  ('Salads',    'سلطات',       'salad',    'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&fit=crop'),
  ('Sandwiches','سندويشات',    'sandwich', 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400&fit=crop')
ON CONFLICT (name) DO NOTHING;

-- ── 2. Products ──────────────────────────────────────────────
-- Burgers (category_id = 3 from existing data)
INSERT INTO products (category_id, name, description, price, estimated_time, image_url) VALUES
  (3, 'Classic Smash Burger',  'Double smash patty, cheddar, pickles, special sauce', 75, 12,
   'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&fit=crop'),
  (3, 'BBQ Bacon Burger',      'Smoky BBQ sauce, crispy bacon, caramelized onions',  85, 15,
   'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=400&fit=crop'),
  (3, 'Mushroom Swiss Burger', 'Sautéed mushrooms, Swiss cheese, garlic aioli',       80, 12,
   'https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=400&fit=crop');

-- Drinks (category_id = 1 from existing data)
INSERT INTO products (category_id, name, description, price, estimated_time, image_url) VALUES
  (1, 'Mango Passion Smoothie', 'Fresh mango, passion fruit, coconut milk',           55, 5,
   'https://images.unsplash.com/photo-1546173159-315724a31696?w=400&fit=crop'),
  (1, 'Strawberry Lemonade',   'Fresh strawberries, lemon, mint, sparkling water',   45, 5,
   'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400&fit=crop'),
  (1, 'Iced Matcha Latte',     'Premium matcha, oat milk, honey',                    60, 7,
   'https://images.unsplash.com/photo-1515823662972-da6a2e4d3002?w=400&fit=crop');

-- Pizza (new category — use subquery for id)
INSERT INTO products (category_id, name, description, price, estimated_time, image_url)
SELECT id, 'Margherita Pizza', 'San Marzano tomatoes, fresh mozzarella, basil', 90, 20,
  'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&fit=crop'
FROM categories WHERE name = 'Pizza';
-- (name_ar added via ALTER TABLE + UPDATE above for new categories)

INSERT INTO products (category_id, name, description, price, estimated_time, image_url)
SELECT id, 'Pepperoni Feast', 'Double pepperoni, mozzarella, tomato sauce', 105, 22,
  'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&fit=crop'
FROM categories WHERE name = 'Pizza';

-- Desserts
INSERT INTO products (category_id, name, description, price, estimated_time, image_url)
SELECT id, 'Nutella Lava Cake', 'Warm chocolate lava cake, vanilla ice cream', 55, 10,
  'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=400&fit=crop'
FROM categories WHERE name = 'Desserts';

INSERT INTO products (category_id, name, description, price, estimated_time, image_url)
SELECT id, 'Cheesecake Slice', 'New York style cheesecake, berry compote', 45, 5,
  'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400&fit=crop'
FROM categories WHERE name = 'Desserts';

-- Salads
INSERT INTO products (category_id, name, description, price, estimated_time, image_url)
SELECT id, 'Caesar Salad', 'Romaine, parmesan, croutons, Caesar dressing', 50, 8,
  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&fit=crop'
FROM categories WHERE name = 'Salads';

-- Sandwiches
INSERT INTO products (category_id, name, description, price, estimated_time, image_url)
SELECT id, 'Club Sandwich', 'Triple-decker turkey, bacon, lettuce, tomato', 65, 10,
  'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400&fit=crop'
FROM categories WHERE name = 'Sandwiches';

-- ── 3. Orders for test user ──────────────────────────────────
-- Replace the email below with the actual test account email if different.
DO $$
DECLARE
  v_user_id UUID;
  v_order1  INT;
  v_order2  INT;
  v_order3  INT;
  v_p_burger INT;
  v_p_smash  INT;
  v_p_mango  INT;
  v_p_pizza  INT;
  v_p_lava   INT;
BEGIN
  -- Look up the test user
  SELECT id INTO v_user_id FROM auth.users WHERE email = 'ramynabil680@gmail.com' LIMIT 1;

  IF v_user_id IS NULL THEN
    RAISE NOTICE 'Test user not found — skipping orders insert. Update email in seed.sql.';
    RETURN;
  END IF;

  -- Make sure user row exists in public.users (created on sign-up via trigger)
  INSERT INTO users (id, email, first_name, last_name, role)
  VALUES (v_user_id, 'ramynabil680@gmail.com', 'Ramy', 'Nabil', 'customer')
  ON CONFLICT (id) DO NOTHING;

  -- Product IDs
  SELECT id INTO v_p_burger FROM products WHERE name = 'Chicken Ranch Burger' LIMIT 1;
  SELECT id INTO v_p_smash  FROM products WHERE name = 'Classic Smash Burger'  LIMIT 1;
  SELECT id INTO v_p_mango  FROM products WHERE name = 'Mango Passion Smoothie' LIMIT 1;
  SELECT id INTO v_p_pizza  FROM products WHERE name = 'Pepperoni Feast'        LIMIT 1;
  SELECT id INTO v_p_lava   FROM products WHERE name = 'Nutella Lava Cake'      LIMIT 1;

  -- Order 1: Active (pending)
  INSERT INTO orders (customer_id, status, total_price, notes)
  VALUES (v_user_id, 'pending', 195, NULL)
  RETURNING id INTO v_order1;

  INSERT INTO order_products (order_id, product_id, quantity) VALUES
    (v_order1, v_p_burger, 2),
    (v_order1, v_p_mango,  1);

  -- Order 2: Completed (served)
  INSERT INTO orders (customer_id, status, total_price, notes, created_at)
  VALUES (v_user_id, 'served', 270, 'Great food!', NOW() - INTERVAL '2 days')
  RETURNING id INTO v_order2;

  INSERT INTO order_products (order_id, product_id, quantity) VALUES
    (v_order2, v_p_smash, 2),
    (v_order2, v_p_pizza, 1);

  -- Order 3: Cancelled
  INSERT INTO orders (customer_id, status, total_price, notes, created_at)
  VALUES (v_user_id, 'cancelled', 105, NULL, NOW() - INTERVAL '5 days')
  RETURNING id INTO v_order3;

  INSERT INTO order_products (order_id, product_id, quantity) VALUES
    (v_order3, v_p_lava, 1),
    (v_order3, v_p_mango, 1);

  RAISE NOTICE 'Seed complete. Orders: %, %, %', v_order1, v_order2, v_order3;
END $$;
