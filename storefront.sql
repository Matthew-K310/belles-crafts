CREATE TABLE base_products (
    -- unique identifier for the base product
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    -- short_description TEXT,
    -- long_description TEXT,
    category_id VARCHAR(255),
    subcategory_id VARCHAR(255),
    -- status and metadata
    is_featured BOOLEAN DEFAULT FALSE,
    -- tracking and timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create table for product attributes (e.g., Color, Size)
CREATE TABLE attributes (
    attribute_id SERIAL PRIMARY KEY,
    attribute_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Create table for attribute values (e.g., Red, Blue, Small, Large)
CREATE TABLE attribute_values (
    attribute_value_id SERIAL PRIMARY KEY,
    attribute_id INT NOT NULL REFERENCES attributes (attribute_id),
    value VARCHAR(100) NOT NULL,
    -- Ensure that a specific attribute value is unique for a given attribute
    UNIQUE (attribute_id, value)
);

-- 4. Create table for product variants (the actual sellable items with SKU, price,
-- stock)
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
-- You might want a constraint or index to ensure unique combinations of attribute
-- values for a product,
-- but this is best managed through the linking table and potentially application logic.
);

-- 5. Create a joining table to link variants to their specific attribute values
-- A variant is defined by one or more attribute values (e.g., Red AND Large).
CREATE TABLE variant_attribute_values (
    variant_id INT NOT NULL REFERENCES product_variants (variant_id),
    attribute_value_id INT NOT NULL REFERENCES attribute_values (
        attribute_value_id
    ),
    -- The combination of a variant and an attribute value defines part of the variant's
    -- identity
    PRIMARY KEY (variant_id, attribute_value_id)
);

-- Optional: Create indexes for performance on the new tables
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

-- Assuming the schema defined previously is in place.
-- We'll use RETURNING to get the generated IDs for subsequent inserts.

-- 1. Insert the Base Product
INSERT INTO base_products (
    product_name,
    -- short_description,
    -- long_description,
    category_id,
    subcategory_id,
    is_featured
) VALUES (
    'Crocheted Bandana',
    -- '',
    -- '',
    'crocheted',
    'bandanas',
    FALSE
), (
    'Crocheted Scrunchie',
    -- '',
    -- '',
    'crocheted',
    'scrunchies',
    FALSE
), (
    'Painted Boards',
    -- '',
    -- '',
    'crocheted',
    'bandanas',
    FALSE
) RETURNING product_id ;

-- 2. Insert Attributes
-- Correct syntax for inserting multiple rows and returning IDs
INSERT INTO attributes (attribute_name)
VALUES
('Color'), -- Assume attribute_id = 1, used for crocheted item color
('Style')   -- Assume attribute_id = 2, used for crochet patterns
('Design'), -- Assume attribute_id = 3, used for board designs
-- ('Size'), -- Assume attribute_id = 4, used for bag sizes
RETURNING attribute_id, attribute_name ;

--
-- Different yarn types for extra cost
--

-- 3. Insert Attribute Values for Color, Design, Style
-- Link these to the correct attribute_id from Step 2
INSERT INTO attribute_values (attribute_id, value)
VALUES
(1, 'White'),    -- attribute_id for Color (1)
(1, 'Light_Blue'),   -- attribute_id for Color (1)
(1, 'Light_Blue/White'),   -- attribute_id for Color (1)
(1, 'Dark_Blue'),   -- attribute_id for Color (1)
(1, 'Dark_Blue/White'),   -- attribute_id for Color (1)
(1, 'Lilac'),   -- attribute_id for Color (1)
(1, 'Lilac/White'),   -- attribute_id for Color (1)
(1, 'Burgundy'),   -- attribute_id for Color (1)
(1, 'Blue/Yellow/White'), -- attribute_id for Color (1)
(2, 'Flower'), -- attribute_id for Style (2)
(2, 'Light_Blue/White')   -- attribute_id for Style (2)
(2, 'Dark_Blue/White')   -- attribute_id for Style (2)
(2, 'Lilac/White')   -- attribute_id for Style (2)
(3, 'Rose'), -- attribute_id for Design (3)
(3, 'Tulip'), -- attribute_id for Design (3)
(3, 'Sunflower'), -- attribute_id for Design (3)
RETURNING attribute_value_id, value ;

-- 4. Insert Product Variants
-- Correct syntax for inserting multiple rows and returning IDs
-- We will insert the two variants from your example VALUES.
-- Match the columns in INSERT INTO with the values in VALUES.
INSERT INTO product_variants (
product_id,
sku,
base_price,
sale_price,
current_stock,
low_stock_threshold,
is_onsale,
image_url -- Added image_url to the column list
) VALUES
-- White Bandana
(101, 'BANDANA-DOUBLE-WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
-- Off_White Bandana
(101, 'BANDANA-DOUBLE-OFF_WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
-- Light_Blue Bandana
(101, 'BANDANA-DOUBLE-LIGHT_BLUE', 20.00, 12.00, 50, 10, FALSE, NULL),
-- Light_Blue/White Bandana
(101, 'BANDANA-DOUBLE-LIGHT_BLUE/WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
-- Dark_Blue Bandana
(101, 'BANDANA-DOUBLE-DARK_BLUE', 20.00, 12.00, 50, 10, FALSE, NULL),
-- Dark_Blue/White Bandana
(101, 'BANDANA-DOUBLE-DARK_BLUE/WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
-- Lilac Bandana
(101, 'BANDANA-DOUBLE-LILAC', 20.00, 12.00, 50, 10, FALSE, NULL),
-- Lilac/White Bandana
(101, 'BANDANA-DOUBLE-LILAC/WHITE', 20.00, 12.00, 50, 10, FALSE, NULL),
-- Burgundy Bandana
(101, 'BANDANA-DOUBLE-BURGUNDY', 20.00, 12.00, 50, 10, FALSE, NULL),
-- Blue/Yellow/White Bandana
(101, 'BANDANA-DOUBLE-BLUE/YELLOW/WHITE', 20.00, 12.00, 50, 10, FALSE, NULL)
RETURNING variant_id, sku ;

-- 5. Link Variants to Attribute Values (Joining Table)
-- Correct syntax for inserting multiple rows.
-- We need to link each variant_id to the corresponding attribute_value_id(s).
-- Based on the example IDs from Steps 3 and 4:
-- Variant 201 (BANDANA-DOUBLE-BLUE) links to Blue value (ID 12)
-- Variant 202 (BANDANA-DOUBLE-WHITE) links to White value (ID 14)
-- If these variants also have a Design and Style, you'd add those links here too.
-- Assuming they are both 'Classic' Style (ID 31) and 'Floral' Design (ID 21) for example.

INSERT INTO variant_attribute_values (variant_id, attribute_value_id)
VALUES
-- Link BANDANA-DOUBLE-BLUE (variant_id 201) to Blue (attribute_value_id 12)
(201, 12),
-- Link BANDANA-DOUBLE-BLUE (variant_id 201) to Floral (attribute_value_id 21, example)
(201, 21),
-- Link BANDANA-DOUBLE-BLUE (variant_id 201) to Classic (attribute_value_id 31, example)
(201, 31),

-- Link BANDANA-DOUBLE-WHITE (variant_id 202) to White (attribute_value_id 14)
(202, 14),
-- Link BANDANA-DOUBLE-WHITE (variant_id 202) to Floral (attribute_value_id 21, example)
(202, 21),
-- Link BANDANA-DOUBLE-WHITE (variant_id 202) to Classic (attribute_value_id 31, example)
(202, 31) ;
