class AddPgSearchDmetaphoneFunction < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION pg_search_dmetaphone(text)
      RETURNS text LANGUAGE sql IMMUTABLE STRICT AS
      $$
        SELECT dmetaphone(unaccent($1))
      $$;
    SQL
  end

  def down
    execute "DROP FUNCTION IF EXISTS pg_search_dmetaphone(text);"
  end
end
