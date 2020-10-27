#script with gene class properties.
#Partially inspired in information of the webpage https://parzibyte.me/blog/2019/02/09/leer-escribir-archivos-csv-ruby/

class Gene
  
  attr_accessor :gene_id, :gene_name, :mut_phen_description, :gene_linkings #I create properties as symbols
  
  def initialize (gene_id, gene_name, mut_phen_description) #I initialize the three properties of the class
    @gene_id = gene_id
    @gene_name = gene_name
    @mut_phen_description = mut_phen_description
    @gene_linkings = [] # I prefer this attribute as array (one gene can be linked with more of one other gene)
  end
  
end