-- Create table for base products
CREATE TABLE base_products (
    -- unique identifier for the base product
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    -- optional description fields
    short_description TEXT,
    long_description TEXT,
    category_id VARCHAR(255),
    subcategory_id VARCHAR(255),
    -- status and metadata
    is_featured BOOLEAN DEFAULT FALSE,
    -- tracking and timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create table for product attributes (e.g., Color, Size)
CREATE TABLE attributes (
    attribute_id SERIAL PRIMARY KEY,
    attribute_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create table for attribute values (e.g., Red, Blue, Small, Large)
CREATE TABLE attribute_values (
    attribute_value_id SERIAL PRIMARY KEY,
    attribute_id INT NOT NULL REFERENCES attributes (attribute_id),
    value VARCHAR(100) NOT NULL,
    -- Ensure that a specific attribute value is unique for a given attribute
    UNIQUE (attribute_id, value)
);

-- Create table for product variants (the actual sellable items with SKU, price, stock)
CREATE TABLE product_variants (
    variant_id SERIAL PRIMARY KEY,
    -- Link back to the base product
    product_id INT NOT NULL REFERENCES base_products (product_id),
    sku VARCHAR(100) UNIQUE NOT NULL,
    -- SKU is unique per variant
    -- pricing info for this variant
    base_price NUMERIC(10, 2) CHECK (base_price >= 0),
    sale_price NUMERIC(10, 2) CHECK (sale_price >= 0),
    -- inventory management for this variant
    current_stock INTEGER CHECK (current_stock >= 0),
    low_stock_threshold INTEGER CHECK (low_stock_threshold >= 0),
    -- variant-specific status (if applicable)
    is_onsale BOOLEAN DEFAULT FALSE,
    -- Optional: variant-specific image
    image_url VARCHAR(255),
    -- tracking and timestamps for the variant
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create a joining table to link variants to their specific attribute values
CREATE TABLE variant_attribute_values (
    variant_id INT NOT NULL REFERENCES product_variants (variant_id),
    attribute_value_id INT NOT NULL REFERENCES attribute_values (
        attribute_value_id
    ),
    -- The combination of a variant and an attribute value defines part of the variant's identity
    PRIMARY KEY (variant_id, attribute_value_id)
);

-- Create indexes for performance on the tables
CREATE INDEX idx_attribute_name ON attributes (attribute_name);
CREATE INDEX idx_attribute_value ON attribute_values (value);
CREATE INDEX idx_product_variant_sku ON product_variants (sku);
CREATE INDEX idx_product_variant_product_id ON product_variants (product_id);
CREATE INDEX idx_variant_attribute_values_variant_id ON variant_attribute_values (
    variant_id
);
CREATE INDEX idx_variant_attribute_values_attribute_value_id ON variant_attribute_values (
    attribute_value_id
);

-- Begin data insertion

-- Insert Base Products
INSERT INTO base_products (
    product_name,
    short_description,
    long_description,
    category_id,
    subcategory_id,
    is_featured
) VALUES
(
    'Crocheted Bandana',
    'Handmade double-crochet bandana in various colors',
    'Soft, comfortable, and versatile bandana crafted with care using double-crochet technique',
    'crocheted',
    'bandana',
    FALSE
),
(
    'Crocheted Scrunchie',
    'Soft double-crochet hair scrunchie',
    'Gentle on hair, stylish accessory made with double-crochet technique',
    'crocheted',
    'scrunchie',
    FALSE
),
(
    'Painted Cutting Board',
    'Artisan wooden cutting board with hand-painted design',
    'Beautiful and functional cutting board featuring unique hand-painted artwork',
    'painted',
    'cutting-board',
    FALSE
)
RETURNING product_id ;

-- Insert Attributes
INSERT INTO attributes (attribute_name)
VALUES
('Color'),        -- Attribute ID 1
('Style'),        -- Attribute ID 2
('Design'),       -- Attribute ID 3
('Material')      -- Attribute ID 4
RETURNING attribute_id, attribute_name ;

-- Insert Attribute Values
INSERT INTO attribute_values (attribute_id, value)
VALUES
-- Colors (Attribute ID 1)
(1, 'White'),
(1, 'Off_White'),
(1, 'Light_Blue'),
(1, 'Light_Blue/White'),
(1, 'Dark_Blue'),
(1, 'Dark_Blue/White'),
(1, 'Lilac'),
(1, 'Lilac/White'),
(1, 'Burgundy'),
(1, 'Blue/Yellow/White'),
(1, 'Maroon'),
(1, 'Black'),

-- Styles (Attribute ID 2)
(2, 'Double Crochet'),

-- Designs (Attribute ID 3)
(3, 'Flower'),
(3, 'Rose'),
(3, 'Tulip'),
(3, 'Sunflower'),

-- Materials (Attribute ID 4)
(4, 'Acacia')
RETURNING attribute_value_id, value ;

-- Insert Product Variants
INSERT INTO product_variants (
product_id,
sku,
base_price,
sale_price,
current_stock,
low_stock_threshold,
is_onsale,
image_url
) VALUES
-- Bandanas
(1, 'BANDANA-DOUBLE-WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
(1, 'BANDANA-DOUBLE-OFF_WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
(1, 'BANDANA-DOUBLE-LIGHT_BLUE', 20.00, 12.00, 50, 10, FALSE, NULL),
(1, 'BANDANA-DOUBLE-LIGHT_BLUE/WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
(1, 'BANDANA-DOUBLE-DARK_BLUE', 20.00, 12.00, 50, 10, FALSE, NULL),
(1, 'BANDANA-DOUBLE-DARK_BLUE/WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
(1, 'BANDANA-DOUBLE-LILAC', 20.00, 12.00, 50, 10, FALSE, NULL),
(1, 'BANDANA-DOUBLE-LILAC/WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
(1, 'BANDANA-DOUBLE-BURGUNDY', 20.00, 12.00, 50, 10, FALSE, NULL),
(1, 'BANDANA-DOUBLE-BLUE/YELLOW/WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),

-- Scrunchies
(2, 'SCRUNCHIE-DOUBLE-OFF_WHITE', 4.00, 2.00, 75, 20, FALSE, NULL),
(2, 'SCRUNCHIE-DOUBLE-LILAC', 4.00, 2.00, 75, 20, FALSE, NULL),
(2, 'SCRUNCHIE-DOUBLE-MAROON', 4.00, 2.00, 75, 20, FALSE, NULL),
(2, 'SCRUNCHIE-DOUBLE-BLACK', 4.00, 2.00, 75, 20, FALSE, NULL),

-- Bags
(3, 'BAG-DOUBLE-FLOWER', 35.00, 28.00, 10, 2, FALSE, NULL),
(3, 'BAG-DOUBLE-LIGHT_BLUE/WHITE', 35.00, 28.00, 10, 2, FALSE, NULL),
(3, 'BAG-DOUBLE-DARK_BLUE/WHITE', 35.00, 28.00, 10, 2, FALSE, NULL),
(3, 'BAG-DOUBLE-LILAC', 35.00, 28.00, 10, 2, FALSE, NULL),

-- Boards
(4, 'BOARD-ROSE', 45.00, 35.00, 10, 3, FALSE, NULL),
(4, 'BOARD-TULIP', 45.00, 35.00, 10, 3, FALSE, NULL),
(4, 'BOARD-SUNFLOWER', 45.00, 35.00, 10, 3, FALSE, NULL)
RETURNING variant_id, sku ;

-- Link Variants to Attribute Values
-- Note: The variant_id and attribute_value_id values will need to be replaced 
-- with the actual IDs returned from previous INSERT statements
INSERT INTO variant_attribute_values (variant_id, attribute_value_id)
VALUES
-- Bandanas (Double Crochet Style + Color)
(1,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Double Crochet' AND attribute_id = 2)),
(1,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'White' AND attribute_id = 1)),

(2,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Double Crochet' AND attribute_id = 2)),
(2,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Off_White' AND attribute_id = 1)),

-- Continue with similar patterns for other variants...

-- Scrunchies (Double Crochet Style + Color)
(11,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Double Crochet' AND attribute_id = 2)),
(11,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Off_White' AND attribute_id = 1)),

-- Bags (Double Crochet Style + Color/Design)
(15,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Double Crochet' AND attribute_id = 2)),
(15,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Flower' AND attribute_id = 3)),

-- Boards (Design)
(19,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Rose' AND attribute_id = 3)),
(20,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Tulip' AND attribute_id = 3)),
(21,
(SELECT attribute_value_id FROM attribute_values WHERE value = 'Sunflower' AND attribute_id = 3)) ;
