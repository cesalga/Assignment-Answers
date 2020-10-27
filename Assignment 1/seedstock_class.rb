#script with seedstock class properties.
#Partially inspired in information of the webpage https://parzibyte.me/blog/2019/02/09/leer-escribir-archivos-csv-ruby/

require 'csv' # I need this for opening csv files

class SeedStock
  
  attr_accessor :seed_stock_id, :gene_id, :last_planted_date, :storage_place, :grams_remaining #I create properties as symbols
  
  def planting(x) #I design the planting method
    newtsvseedstock = "./new_stock_file.tsv" #I have created the file manually with the same header as 'seed_stock_data.tsv'    grams = @grams_remaining.to_i
    grams = @grams_remaining.to_i #I transform string to integer
    grams -= x #I substract x grams of my stock
    if grams <= 0 
      grams = 0 #I avoid negative numbers
      puts "WARNING: we have run out of Seed Stock #{@seed_stock_id}" #I warn about the lack of stock
    else
      puts "We have #{grams} grams of Seed Stock #{@seed_stock_id}" #I inform about the amount of stock
    end
    @grams_remaining = grams.to_s #I transform to string again
    CSV.open(newtsvseedstock, "a", quote_char: '"', col_sep: "\t", headers: true) do |tsvfile| #Is important to use 'a' as argument in order to append a row to "new_stock_file.tsv"
      #With argument col_sep: "\t" I append with tsv format
        tsvfile << [@seed_stock_id, @gene_id.gene_id, @last_planted_date, @storage_place, @grams_remaining]
    end
  end
  
  def initialize (seed_stock_id, gene_id, last_planted_date, storage_place, grams_remaining) #I initialize the five properties of the class
    @seed_stock_id = seed_stock_id
    @gene_id = gene_id
    @last_planted_date = last_planted_date
    @storage_place = storage_place
    @grams_remaining = grams_remaining
    
  end
  
end