#script with crossing class properties.
#Partially inspired in information of the webpage https://parzibyte.me/blog/2019/02/09/leer-escribir-archivos-csv-ruby/

class Cross
  
  attr_accessor :stock1, :stock2, :wild_f2, :p1_phen_f2, :p2_phen_f2, :p1p2_phen_f2 #I create properties as symbols
  
  def square(num) #I calculate a simple method for calculating squares (after I will need it)
    return num * num
  end
  
  def discovering_links #I design the link discovering method
    total_f2 = @wild_f2.to_f + @p1_phen_f2.to_f + @p2_phen_f2.to_f + @p1p2_phen_f2.to_f #I transform strings to floats and calculate the total number of the population
    expec9 = total_f2*9/16 #I calculate the expected numbers of the population following the 9:3:3:1  Mendelian segregation
    expec3 = total_f2*3/16
    expec1 = total_f2/16
    wild_chisquare = square(@wild_f2.to_f - expec9) / expec9 #I calculate a chisquare for each phenotype
    p1_chisquare = square(@p1_phen_f2.to_f - expec3) / expec3
    p2_chisquare = square(@p2_phen_f2.to_f - expec3) / expec3 
    p1p2_chisquare = square(@p1p2_phen_f2.to_f - expec1) / expec1
    chisquare = wild_chisquare + p1_chisquare + p2_chisquare + p1p2_chisquare #I calculate the ultimate chisquare
    if chisquare > 7.815 #I know by literature that deviations are significative (not produced by fate) when chisquare exceeds this number (for 4 phenotypic classes and therefore 3 freedom degrees)
      puts "#{@stock1.gene_id.gene_name} is genetically linked to #{@stock2.gene_id.gene_name} with chisquare score #{chisquare}"
      #I inform that genes are linked only if chisquare of the cross exceeds the previous value
      @stock1.gene_id.gene_linkings << "linked with #{@stock2.gene_id.gene_name}"
      @stock2.gene_id.gene_linkings << "linked with #{@stock1.gene_id.gene_name}"
      #I add the new information as attribute or property of the involved genes
    end
  end
  
  def initialize (stock1, stock2, wild_f2, p1_phen_f2, p2_phen_f2, p1p2_phen_f2) #I initialize the six properties of the class
    @stock1 = stock1
    @stock2 = stock2
    @wild_f2 = wild_f2
    @p1_phen_f2 = p1_phen_f2
    @p2_phen_f2 = p2_phen_f2
    @p1p2_phen_f2 = p1p2_phen_f2
  end
  
end