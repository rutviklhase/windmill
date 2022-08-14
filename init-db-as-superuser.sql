DO
$do$
BEGIN
    IF EXISTS (
        select usesuper from pg_user where usename = CURRENT_USER AND usesuper = 't') 
    AND NOT EXISTS (
        SELECT
        FROM   pg_catalog.pg_roles
        WHERE  rolname = 'windmill_user') THEN

        LOCK TABLE pg_catalog.pg_roles;

        CREATE ROLE windmill_user;

        GRANT ALL
        ON ALL TABLES IN SCHEMA public 
        TO windmill_user;

        GRANT ALL PRIVILEGES 
        ON ALL SEQUENCES IN SCHEMA public 
        TO windmill_user;

        ALTER DEFAULT PRIVILEGES 
            FOR ROLE windmill_user
            IN SCHEMA public
            GRANT ALL ON TABLES TO windmill_user;

        ALTER DEFAULT PRIVILEGES 
            FOR ROLE windmill_user
            IN SCHEMA public
            GRANT ALL ON SEQUENCES TO windmill_user;

    END IF;
END
$do$;

DO
$do$
BEGIN
    IF EXISTS (select usesuper from pg_user where usename = CURRENT_USER AND usesuper = 't')
    AND NOT EXISTS (
        SELECT
        FROM   pg_catalog.pg_roles
        WHERE  rolname = 'windmill_admin') THEN
        CREATE ROLE windmill_admin WITH BYPASSRLS;

        GRANT ALL
        ON ALL TABLES IN SCHEMA public 
        TO windmill_admin;

        GRANT ALL PRIVILEGES 
        ON ALL SEQUENCES IN SCHEMA public 
        TO windmill_admin;

        ALTER DEFAULT PRIVILEGES 
            FOR ROLE windmill_admin
            IN SCHEMA public
            GRANT ALL ON TABLES TO windmill_admin;

        ALTER DEFAULT PRIVILEGES 
            FOR ROLE windmill_admin
            IN SCHEMA public
            GRANT ALL ON SEQUENCES TO windmill_admin;
    END IF;
END
$do$;