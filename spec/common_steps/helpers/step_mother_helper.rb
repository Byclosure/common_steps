module StepMotherHelper
  def step_should_match(step_string)
    it { @step_mother.should step_match(step_string) }
  end  
  
  def artist_should_count(n, step_string)
    plural_or_singular = n == 1 ? "" : "s" 
    it "should count #{n} Artist#{plural_or_singular} when I call '#{step_string}'" do
      m = @step_mother.step_match(step_string)
      m.invoke(nil)
      Artist.should count(n)
    end
  end  
  
  def artist_should_be(hash, step_string)
    it "should contain #{hash.inspect} when I call '#{step_string}'" do
      m = @step_mother.step_match(step_string)
      m.invoke(nil)
      Artist.should exist_given(hash)
    end
  end
  
  def artist_should_count_and_be(n, hash, step_string)
    artist_should_count(n, step_string)
    artist_should_be(hash, step_string)
  end
  
  def artists_in_table_should_be(table, step_string)
    it "should contain the table #{table.hashes.inspect} when I call '#{step_string}" do  
      m = @step_mother.step_match('the following artists')
      m.invoke(table)
      table.hashes.each do |hash|
        Artist.should exist_given(hash)
      end
    end
  end
end
