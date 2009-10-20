require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require "common_steps/helpers/record_helper"

class Artist; end
class MagnificArtist; end
module Admin
  class Painting; end
end
describe RecordHelper, "with Artist, MagnificArtist, ::Admin::Painting defined" do
  before do
    @env = Object.new
    @env.extend(RecordHelper)
  end
  
  it { @env.should respond_to(:recordize!) }
  
  it { @env.should respond_to(:record_singular_name) }
  it "#record_singular_name('aRtIsTs') should == 'artist'" do
    @env.record_singular_name('aRtIsTs').should == 'artist'
  end  
  it "#record_singular_name('ArTiSt') should == 'artist'" do
    @env.record_singular_name('ArTiSt').should == 'artist'
  end
  it "#record_singular_name('ReCiPe iNgReDiEnTs') should == 'recipe ingredient'" do
    @env.record_singular_name('ReCiPe iNgReDiEnTs').should == 'recipe_ingredient'
  end
  
  it { @env.should respond_to(:record_name_to_class) }
  it "#record_name_to_class('ArTiSt') should == Artist" do
    @env.record_name_to_class('ArTiSt').should == Artist
  end
  it "#record_name_to_class('aRtIsTs') should == Artist" do
    @env.record_name_to_class('aRtIsTs').should == Artist
  end
  it "#record_name_to_class('magnific artist') should == MagnificArtist" do
    @env.record_name_to_class('magnific artist').should == MagnificArtist
  end
  it "#record_name_to_class('magnific artists') should == MagnificArtist" do
    @env.record_name_to_class('magnific artists').should == MagnificArtist
  end
  
  it { @env.should respond_to(:str_to_num) }
  it "#str_to_num('a') should == 1" do
    @env.str_to_num('a').should == 1
  end
  it "#str_to_num('an') should == 1" do
    @env.str_to_num('an').should == 1
  end
  it "#str_to_num('no') should == 0" do
    @env.str_to_num('no').should == 0
  end
  it "#str_to_num(something_else) should hit something_else with #to_i" do
    something_else = mock("something_else")
    something_else.should_receive(:to_i).once.with(no_args)
    @env.str_to_num(something_else)
  end
  
  it { @env.should respond_to(:conditions_from_str) }
  it "#conditions_from_str(\"name of 'foo'\") should == {'name' => 'foo'}" do
    @env.conditions_from_str("name of 'foo'").should == {"name" => "foo"}
  end
  it "#conditions_from_str(\"name => 'foo'\") should == {'name' => 'foo'}" do
    @env.conditions_from_str("name => 'foo'").should == {"name" => "foo"}
  end
  it "#conditions_from_str(\"age of 23\") should == {'age' => 23}" do
    @env.conditions_from_str("age of 23").should == {"age" => 23}
  end
  it "#conditions_from_str(\"age => 23\") should == {'age' => 23}" do
    @env.conditions_from_str("age => 23").should == {"age" => 23}
  end
  it "#conditions_from_str(\"lame of true\") should == {'lame' => true}" do
    @env.conditions_from_str("lame of true").should == {"lame" => true}
  end
  it "#conditions_from_str(\"lame => true\")" do
    @env.conditions_from_str("lame => true").should == {"lame" => true}
  end
  it "#conditions_from_str(\"full name => meth\"), with #meth defined and returning 'bar', should == {'full_name'=>'bar'}" do
    @env.should_receive(:meth).and_return('bar')
    @env.conditions_from_str("full name => meth").should == {"full_name" => 'bar'}
  end
  it "#conditions_from_str(\"full_name of meth\"), with #meth defined and returning 'bar', should == {'full_name'=>'bar'}" do
    @env.should_receive(:meth).and_return('bar')
    @env.conditions_from_str("full_name of meth").should == {"full_name" => 'bar'}
  end
  it "#conditions_from_str(\"date => Date.today\") should == {'date' => #{Date.today}}" do
    @env.conditions_from_str("date => Date.today").should == {"date" => Date.today}
  end
  it "#conditions_from_str(\"date of Date.today\") should == {'date' => #{Date.today}}" do
    @env.conditions_from_str("date => Date.today").should == {"date" => Date.today}
  end
  
  it "#conditions_from_str(\"name of 'boo' and age of 23\") should == {'name' => 'boo', 'age' => 23}" do
    @env.conditions_from_str("name of 'boo' and age of 23").should == {"name" => "boo", "age" => 23}
  end
  it "#conditions_from_str(\"name of 'boo', age => 23, internal => true\") should == {'name' => 'boo', 'age' => 23, 'internal' => true}" do
    @env.conditions_from_str("name of 'boo', age => 23, internal => true").should == {"name" => "boo", "age" => 23, "internal" => true}
  end
  it "#conditions_from_str(\"name => 'boo', age of 23, and internal of true\") should == {'name' => 'boo', 'age' => 23, 'internal' => true}" do
    @env.conditions_from_str("name => 'boo', age of 23, and internal of true").should == {"name" => "boo", "age" => 23, "internal" => true}
  end
  it "#conditions_from_str(\"name => meth, age of 23, and internal of true\"), with #meth defined and returning 'bar', should == {'name'=>'bar','age'=>23,'internal'=>true}" do
    @env.should_receive(:meth).and_return('bar')
    @env.conditions_from_str("name => meth, age of 23, and internal of true").should == {"name"=>"bar", "age"=>23, "internal"=>true}
  end
  
  it { @env.should respond_to(:find_record) }
  describe "find_record(Artist, \"'name of 'Foo', internal => true\")" do
    it "should hit Artist with #find(:all, :conditions => {'name' => 'Foo', internal => true}) and return mock('artist')" do
      artist = mock("artist")
      Artist.should_receive(:find).with(:first, :conditions => {'name' => 'Foo', "internal" => true}).and_return(artist)
      @env.find_record(Artist, "name of 'Foo', internal => true")
    end
  end
  describe "when Artist.find(:first, :conditions => {'name' => 'Bar'}) return nil find_record(Artist, \"name => 'Bar'\") should raise error" do
    it do
      Artist.should_receive(:find).with(:first, :conditions => {'name' => 'Bar'}).and_return(nil)
      lambda do
        @env.find_record(Artist, "name => 'Bar'")
      end.should raise_error("Couldn't found any record for `Artist' with conditions: `{\"name\"=>\"Bar\"}'")
    end
  end
  
  it { @env.should respond_to(:record_class_to_path) }
  it "#record_class_to_path(Artist) should == '/artists'" do
    @env.record_class_to_path(Artist).should == '/artists'
  end
  it "#record_class_to_path(MagnificArtist) should == '/magnific_artist'" do
    @env.record_class_to_path(MagnificArtist).should == '/magnific_artists'
  end
  it "#record_class_to_path(::Admin::Painting) should == '/admin/paintings'" do
    @env.record_class_to_path(::Admin::Painting).should == '/admin/paintings'
  end
end