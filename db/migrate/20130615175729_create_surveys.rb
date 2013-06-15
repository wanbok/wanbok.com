class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.string :user
      t.string :sex
      t.string :age
      (1..15).each {|q| t.integer "q#{q}".to_sym}

      t.timestamps
    end
  end
end
