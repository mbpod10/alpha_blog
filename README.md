### Create Project And Skip Git
`rails new alpha_blog --skip-git`
`cd alpha_blog`
`git init`
### Make Sure To Add `.gitignore` file
`git remote add origin https://github.com/mbpod10/alpha_blog.git`
`git add .`
`git commit -m 'first commit`
`git push origin master`

## BACKEND

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
This is preferred becuase it will make things easier when coding with multiple developers
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

- Check Schema File and make sure that the articles table was updated
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

## Create Article MODEL
in `app/models` create a `article.rb` file (Make sure of singular naming convention)
- Every model that we create will inherit from the `app/models/application_record.rb` file so we need to create inheritance
- Make this inheritance in `app/models/article.rb` file:

```rb
class Article < ApplicationRecord
  
end
```
### Enter Rails Databae Console
`rails c`
- Test connection with Article model
- This console uses Active Record as the Object Relational Mapper (a way for Ruby To Communicate With SQL Database)


`Article.create(title: "first article", description: "desc of first article") `

Or we can use variables 
```rb
article = Article.new
article.title = "second article"
article.description = "desc of second art"
article.save()
OR
article = Article.new(title: "third article", description: "desc of third art")
article.save()
exit
```

| Action            |               Active Record                |                                         SQL Equivalent |
| ----------------- | :----------------------------------------: | -----------------------------------------------------: |
| get all articles  |                Article.all                 |                                 SELECT * FROM articles |
| create article    | Article.create(title: "", description: "") | INSERT INTO articles(title, description) VALUES("","") |
| GET by id         |              Article.find(1)               |                    SELECT * FROM articles WHERE id = 1 |
| GET first article |               Article.first                |         SELECT * FROM articles ORDER BY id ASC LIMIT 1 |
| GET last article  |                Article.last                |        SELECT * FROM articles ORDER BY id DESC LIMIT 1 |
| DELETE BY id      |              article.destroy               |                                                      - |

```rb
article = Article.find(3)
article.description = "edited description"
article.save()
```

## Create Constraints And Validations To Articles Table
- We don't want empty titles and descriptions
- Similar to SQL conventions of `NOT NULL`
go to `app/models/article.rb` and create constraints
- CREATE constrains which title and desription should not be null and min/max char lengths

```rb
class Article < ApplicationRecord
  validates :title, presence: true, length:{minimum: 6, maxium: 100}
  validates :description, presence: true, length:{minimum: 10, maxium: 300}
end
```
reload console with `reload!`
```rb
article = Article.new
article.save
=> false
article.errors.full_messages
=> 
["Title can't be blank",
 "Title is too short (minimum is 6 characters)",
 "Description can't be blank",
 "Description is too short (minimum is 10 characters)"]
```

# FRONTEND
