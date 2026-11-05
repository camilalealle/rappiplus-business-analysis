-- RappiPlus | Sequential Conversion Funnel
-- Database: PostgreSQL
-- Source: public.events
-- Analysis period: January–June 2025
-- Purpose: Count users completing six funnel events in chronological order.
-- Grain: unique users, with progression across sessions and dates allowed.
-- No maximum elapsed time between events is imposed.
-- The result is a strict sequence completion funnel, not overall purchase conversion.

WITH ordered_events AS (
    SELECT
        id_usuario,
        nombre_evento,
        timestamp_evento::timestamp AS event_time
    FROM public.events
),

first_visits AS (
    SELECT
        id_usuario,
        MIN(event_time) AS first_visit_time
    FROM ordered_events
    WHERE nombre_evento = 'first_visit'
    GROUP BY id_usuario
),

selected_items AS (
    SELECT
        e.id_usuario,
        MIN(e.event_time) AS select_time
    FROM ordered_events e
    JOIN first_visits f
        ON e.id_usuario = f.id_usuario
    WHERE e.nombre_evento = 'select_item'
      AND e.event_time >= f.first_visit_time
    GROUP BY e.id_usuario
),

added_to_cart AS (
    SELECT
        e.id_usuario,
        MIN(e.event_time) AS cart_time
    FROM ordered_events e
    JOIN selected_items s
        ON e.id_usuario = s.id_usuario
    WHERE e.nombre_evento = 'add_to_cart'
      AND e.event_time >= s.select_time
    GROUP BY e.id_usuario
),

started_checkout AS (
    SELECT
        e.id_usuario,
        MIN(e.event_time) AS checkout_time
    FROM ordered_events e
    JOIN added_to_cart c
        ON e.id_usuario = c.id_usuario
    WHERE e.nombre_evento = 'begin_checkout'
      AND e.event_time >= c.cart_time
    GROUP BY e.id_usuario
),

added_payment AS (
    SELECT
        e.id_usuario,
        MIN(e.event_time) AS payment_time
    FROM ordered_events e
    JOIN started_checkout c
        ON e.id_usuario = c.id_usuario
    WHERE e.nombre_evento = 'add_payment_info'
      AND e.event_time >= c.checkout_time
    GROUP BY e.id_usuario
),

purchased AS (
    SELECT
        e.id_usuario,
        MIN(e.event_time) AS purchase_time
    FROM ordered_events e
    JOIN added_payment p
        ON e.id_usuario = p.id_usuario
    WHERE e.nombre_evento = 'purchase'
      AND e.event_time >= p.payment_time
    GROUP BY e.id_usuario
)

SELECT 1 AS stage_order, 'first_visit' AS stage, COUNT(*) AS users
FROM first_visits

UNION ALL
SELECT 2, 'select_item', COUNT(*)
FROM selected_items

UNION ALL
SELECT 3, 'add_to_cart', COUNT(*)
FROM added_to_cart

UNION ALL
SELECT 4, 'begin_checkout', COUNT(*)
FROM started_checkout

UNION ALL
SELECT 5, 'add_payment_info', COUNT(*)
FROM added_payment

UNION ALL
SELECT 6, 'purchase', COUNT(*)
FROM purchased

ORDER BY stage_order;
