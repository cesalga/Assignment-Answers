#This is the script for loading data into classes, linking classes and calling the planting and gene linking discovering methods
#Partially inspired in information of the webpage https://parzibyte.me/blog/2019/02/09/leer-escribir-archivos-csv-ruby/
#15 hours inverted in making this script, gene_class.rb, seedstock_class.rb and cross_class.rb

#0. Some preparations

require "./gene_class.rb" #I will need calling to the classes scripts
require "./seedstock_class.rb"
require "./cross_class.rb" 
require 'csv' # I need for opening csv files

tsvgene = "./gene_information.tsv" #I add tsv links to variables
tsvseedstock = "./seed_stock_data.tsv"
tsvcross = "./cross_data.tsv"

#1. Loading data from tsvfiles into classes

genes = [] #I create an array for all the instances of the gene class
CSV.foreach(tsvgene, quote_char: '"', col_sep: "\t", headers: true) do |row| # I iterate all the rows of the tsv with 'CSV.foreach'
  #I use quote_char: '"' for avoiding problems with "" in the tsv file
  #The foreach method undertands that the format of the file is tsv by col_sep: "\t" argument
  #I use headers: true for avoiding having a header instance inside my genes array
  if row[0] =~ /A[Tt]\d[Gg]\d\d\d\d\d/ # I only want gene identifiers with this structure in my gene collection
    genes.push Gene.new(row[0], row[1], row[2]) #I generate one instance for row and I push them inside the array.
  #Each instance will have three attributes (one for each tsv column and therefore for each Gene.new argument)
  else
    puts "The format of #{row[0]} is not correct!" #If there is some crazy gene identifier, I inform of the fact
  end
end

seedstocks = [] #I create an array for all the instances of the seedstock class
CSV.foreach(tsvseedstock, quote_char: '"', col_sep: "\t", headers: true) do |row|
  if row[1] =~ /A[Tt]\d[Gg]\d\d\d\d\d/
    seedstocks.push SeedStock.new(row[0], row[1], row[2], row[3], row[4]) #I generate one instance for row and I push them inside the array.
  #Each instance will have five attributes (one for each tsv column and therefore for each Gene.new argument)
  else
    puts "The format of #{row[1]} is not correct!"
  end
end

crosses = [] #I create an array for all the instances of the crossing class
CSV.foreach(tsvcross, quote_char: '"', col_sep: "\t", headers: true) do |row|
  crosses.push Cross.new(row[0], row[1], row[2], row[3], row[4], row[5])
  #Each instance will have six attributes (one for each tsv column and therefore for each Gene.new argument)
end

#2. Linking classes

# I add both seedstock objects of each cross inside the stock1 and stock2 attributes of the different objects of the cross class 
# First: seedstock 1
crosses.each do |that_cross|
  seedstocks.each do |that_seedstock|
    if that_cross.stock1 == that_seedstock.seed_stock_id #I search and find coincidences in the stock ids
      that_cross.stock1 = that_seedstock #Only if there is a coincidence I establish the link
    end
  end
end

#Second: seedstock 2
crosses.each do |that_cross|
  seedstocks.each do |that_seedstock|
    if that_cross.stock2 == that_seedstock.seed_stock_id
      that_cross.stock2 = that_seedstock
    end
  end
end

# I add gene objects inside the gene_id attribute of the different objects of the seedstock class
seedstocks.each do |that_seedstock|
  genes.each do |that_gene|
    if that_seedstock.gene_id == that_gene.gene_id #I search and find coincidences in the gene ids
      that_seedstock.gene_id = that_gene #Only if there is a coincidence I establish the link
    end
  end
end

#3. Calling methods

#First: planting method (placed in seedstock class)
seedstocks.each do |that_seedstock| #I iterate through my seedstock array for planting 7 grams for each record
  that_seedstock.planting(7) #I call the planting method and I specify the planted amount
end

#Second: gene linking discovering method (placed in cross class)
crosses.each do |that_cross| #I iterate through my crossings array for calculating the chisquare of each cross
  that_cross.discovering_links #I call the method
end