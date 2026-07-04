-- Add 'arrived' status between 'delivering' and 'served'
alter type order_status add value if not exists 'arrived' after 'delivering';
