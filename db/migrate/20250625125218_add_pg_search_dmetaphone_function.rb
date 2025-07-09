class AddPgSearchDmetaphoneFunction < ActiveRecord::Migration[8.0]
  def up
    enable_extension 'unaccent' unless extension_enabled?('unaccent')
    enable_extension 'fuzzystrmatch' unless extension_enabled?('fuzzystrmatch')

    execute <<-SQL
      CREATE OR REPLACE FUNCTION public.pg_search_dmetaphone(text)
      RETURNS text LANGUAGE sql IMMUTABLE STRICT AS $$
        SELECT dmetaphone(unaccent($1))
      $$;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION IF EXISTS public.pg_search_dmetaphone(text);
    SQL
  end
end
