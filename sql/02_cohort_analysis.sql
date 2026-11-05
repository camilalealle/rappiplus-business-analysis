-- RappiPlus | Cohort Retention Analysis
-- Database: PostgreSQL
-- Sources: public.users, public.user_activity
-- Registration cohorts: January–May 2025
-- Purpose: Measure user activity on D7, D14, D21 and D28 by registration month.
-- Retention reflects activity at each specific interval, not continuous usage.

WITH user_cohorts AS (
    SELECT
        id_usuario,
        DATE_TRUNC('month', fecha_registro::date)::date AS cohort_month
    FROM public.users
),

cohort_activity AS (
    SELECT
        u.cohort_month,
        a.dias_despues_registro,
        COUNT(DISTINCT a.id_usuario) AS evaluated_users,
        COUNT(DISTINCT CASE
            WHEN a.activo = 1 THEN a.id_usuario
        END) AS active_users
    FROM user_cohorts u
    INNER JOIN public.user_activity a
        ON u.id_usuario = a.id_usuario
    GROUP BY
        u.cohort_month,
        a.dias_despues_registro
)

SELECT
    cohort_month,
    dias_despues_registro,
    evaluated_users,
    active_users,
    ROUND(
        active_users * 100.0 / NULLIF(evaluated_users, 0),
        2
    ) AS retention_pct
FROM cohort_activity
ORDER BY
    cohort_month,
    dias_despues_registro;
