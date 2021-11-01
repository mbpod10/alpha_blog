### Create Project And Skip Git
`rails new alpha_blog --skip-git`
`cd alpha_blog`
`git init`
### Make Sure To Add `.gitignore` file
`git remote add origin https://github.com/mbpod10/alpha_blog.git`
`git add .`
`git commit -m 'first commit`
`git push origin master`

## BACK END

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
### Enter Rails Database Console
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
# OR
article = Article.new(title: "third article", description: "desc of third art")
article.save()
exit
```

| Action             |               Active Record                |                                         SQL Equivalent |
| ------------------ | :----------------------------------------: | -----------------------------------------------------: |
| get all articles   |                Article.all                 |                                 SELECT * FROM articles |
| create article     | Article.create(title: "", description: "") | INSERT INTO articles(title, description) VALUES("","") |
| GET by id          |              Article.find(1)               |                    SELECT * FROM articles WHERE id = 1 |
| GET first article  |               Article.first                |         SELECT * FROM articles ORDER BY id ASC LIMIT 1 |
| GET last article   |                Article.last                |        SELECT * FROM articles ORDER BY id DESC LIMIT 1 |
| DELETE BY variable |              article.destroy               |                                                      - |

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

# FRONT END
### Create Routes
Start rails servers with `rails s`
in `config/routes.rb` file add the resources
```rb
Rails.application.routes.draw do
  resources :articles, only: [:show]
end
```
check routes with `rails routes --expanded`
```rb
--[ Route 1 ]
Prefix            | article
Verb              | GET
URI               | /articles/:id(.:format)
Controller#Action | articles#show
```
### Create Controller (Show By Id)
In `controllers` folder create a new file called `articles_controller.rb`
CREATE AN INSTANCE VARIABLE WITH the `@` convention

```rb
# app/controllers/articles_controller.rb

class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])   
  end
end
```
ERROR:
```
No template for interactive request
ArticlesController#show is missing a template for request formats: text/html 
NOTE!
Unless told otherwise, Rails expects an action to render a template with the same name,
contained in a folder named after its controller. If this controller is an API responding with 204 (No Content),
which does not require a template, then this error will occur when trying to access it via browser,
since we expect an HTML template to be rendered for such requests. If that's the case, carry on.
```

Now, we need to create a `articles` folder in the `app/views`folder and create a `show.html.erb` inside
- THE `show.html.erb` corresponds to the `show` method in the `app/controllers/articles_controller.rb` file 

go to `http://localhost:3000/articles/1` and the detail page will display the first article of id = 1

```rb
# app/views/articles/show.html.erb

<h1>Show article details</h1>
<p><b>Title:</b> <%= @article.title %></p>
<p><b>Description:</b> <%= @article.description %> </p>
```

### Create Controller (Index)
Now, we want to render all the articles in our database to our front end.

- Go back to `config/routes` and include `index` in the route constraints

```rb
# config/routes.rb

Rails.application.routes.draw do
  resources :articles, only: [:show, :index]
end
```

Like before, we now want to create an `index` method in our ArticlesController and use Active Record to create an instance of all the articles.
```rb
#app/controllers/articles_controller.rb

class ArticlesController < ApplicationController
  def show  
    @article = Article.find(params[:id])   
  end

  def index    
    @articles = Article.all
  end

end
```

Now, we need to create an `index.html.erb` file in `app/views/articles` folder and loop through each article in the instance @articles and render then to the page
```rb
#app/views/articles/index.html.erb

<h1>Article Index Page</h1>
<table>
  <thead>
    <tr>
      <th>ID</th>
      <th>Title</th>
      <th>Description</th>
      <th>Action</th>
    </tr>
  </thead>
  <tbody>
    <% @articles.each do |article| %>
      <tr>        
        <td><%= article.id %></td>
        <td><%= article.title %></td>
        <td> <%= article.description %> </td>
        <td><%= article.created_at %> </td>
      </tr>
    <% end %>           
  </tbody>
</table>
```
go to `http://localhost:3000/articles` and see the rendered html

## FORMS
Add `new` and `create` to `routes.rb`
```rb
# config/routes.rb
Rails.application.routes.draw do

  resources :articles, only: [:show, :index, :new, :create]
end
```
NOTE: These routes are `keyword routes` for rails, in other words, you cannot add any other than
`:index, :new, :create, :show, :edit, :update, :destroy`

Create a `new` method in the `articles_controller.rb` and a new view of `new.html.erb` in the `app/views/articles` controller
Finally go to `http://localhost:3000/articles/new`

## Add New Git Branch
`git checkout -b create-users-table-model`
`>> Switched to a new branch 'create-users-table-model'`
`git branch`
```
* create-users-table-model
master
```
Switch back to master
`git checkout master`
Switch back to `'create-users-table-model'`

## Users
`rails generate migration create_users`
Go To Migration File `db/migrate/<MIGRATION_FILE>`
```rb
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.timestamps
    end
  end
end
```
`rails db:migrate`

Create `user` model in `app/models/users.rb`
```rb
class User < ApplicationRecord 
end
```
`rails c`
`User.create(username: "mbpod10", email: "beep@gmail.com")`

## Commit Work
`git add .`
`git commit -m 'add user`
`git checkout master`
`git merge create-users-table-model`
