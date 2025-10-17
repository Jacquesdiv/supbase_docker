FROM supabase/postgres:15.14.1.023

COPY custom-entrypoint.sh /usr/local/bin/custom-entrypoint.sh
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

COPY ./sql/webhooks.sql /docker-entrypoint-initdb.d/init-scripts/98-webhooks.sql
COPY ./sql/roles.sql /docker-entrypoint-initdb.d/init-scripts/99-roles.sql
COPY ./sql/jwt.sql /docker-entrypoint-initdb.d/init-scripts/99-jwt.sql

COPY ./sql/_supabase.sql /docker-entrypoint-initdb.d/migrations/97-_supabase.sql
COPY ./sql/realtime.sql /docker-entrypoint-initdb.d/migrations/99-realtime.sql
COPY ./sql/logs.sql /docker-entrypoint-initdb.d/migrations/99-logs.sql
COPY ./sql/pooler.sql /docker-entrypoint-initdb.d/migrations/99-pooler.sql

COPY ./data /var/tmp_data
      
ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]
CMD ["postgres"]