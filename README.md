### Create Project And Skip Git
`rails new alpha_blog --skip-git`
`cd alpha_blog`
`git init`
### Make Sure To Add `.gitignore` file
`git remote add origin https://github.com/mbpod10/alpha_blog.git`
`git add .`
`git commit -m 'first commit`
`git push origin master`

## Create Articles Table

`rails generate migration create_articles`

Go to `db/migrate/<MIGRATION_FILE>`

Migration File:
```rb
class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title      
    end
  end
end
```
Run Migration File:
`rails db:migrate`
This command runs all migration files that have not previous been run.

Check the `db/schema.rb` file and make sure that articles was created

## Want To Change Migration File
Simply changing the migration file and running `rails db:migrate` WILL NOT change the schema file.

### ONE WAY:
- Rollback is one option `rails db:rollback` (articles schema will be removed from schema.rb)
- Rune `rails db:migrate` again

### PREFERRED WAY:
`rails generate migration add_timestamps_to_articles`
In NEW Migration File
```rb
class AddTimestampsToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :created_at, :datetime
    add_column :articles, :updated_at, :datetime
  end
end
```
Once again, run `rails db:migrate`

- Check Schema File and make sure that the articles table was update

```rb
# db/schema.rb
ActiveRecord::Schema.define(version: 2021_10_28_170057) do
  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end
end
```