# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggerArticlesInsertUpdate < ActiveRecord::Migration[6.1]
  def up
    create_trigger("update_reading_list_document", :generated => true, :compatibility => 1).
        on("articles").
        name("update_reading_list_document").
        before(:insert, :update).
        for_each(:row) do
      <<-SQL_ACTIONS
NEW.reading_list_document := 
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.title, ''))), 'A') ||
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.cached_tag_list, ''))), 'B') ||
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.body_markdown, ''))), 'C') ||
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.cached_user_name, ''))), 'D') ||
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.cached_user_username, ''))), 'D');
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("update_reading_list_document", "articles", :generated => true)
  end
end
