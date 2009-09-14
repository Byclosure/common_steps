module RecordHelper
  def record_singular_name(record_name)
    record_name.gsub('_', ' ').downcase.singularize
  end

  def record_name_to_class(record_name)
    klass_name = record_singular_name(record_name).gsub(/\s/, "_").classify
    klass = klass_name.constantize
    klass.nil? ? raise("Couldn't found any class for record with name `#{record_name}', tried with `#{klass_name}'") : klass
  end
  
  # leo = Artist.create!(:name => "Leo")
  # Paiting.belongs_to :artist
  # Paintings:
  # | title | artist_name |
  # | Mona  | Leo         |
  # will associate leo to the paiting with title Mona 
  
  def recordize!(record_name, table, &block)
    record_class = record_name_to_class(record_name)
    table.headers.each do |header|
      rh = record_class.columns_hash[header]
      if rh.nil? # artist_name case 
        association = record_class.reflect_on_all_associations.detect {|a| header =~ /^#{a.name}/ }
        raise("Association: `#{header}' not found on #{record_class}") if association.nil?
        
        find_attrs = header.match(/^#{association.name}(.*)$/)[1]
        association_class = association.klass
        table.map_column!(header) { |value| association_class.send("find_by#{find_attrs}", value) }
        table.map_headers!(header => association.name)
      else
        table.map_column!(header) {|value| rh.type_cast(value) }
      end
    end
  end
  
  def str_to_num(str)
    case str
    when "a" then 1
    when "an" then 1
    when "no" then 0
    else str.to_i
    end
  end
  
  # I should go to the show page of paiting with a name of "Bello", and belonging to an artist with a name "foo"
=begin
  def attr_from_name(class_record, attr_name)
    case attr_name
    when /^belonging to (a|an) (\w+) with (a|an) (.*)$/
      _, association_str, _, conditions_str = $~.captures
      association_name = association_str.gsub(/\s/, "_").downcase.to_sym
      association = reflect_on_association(association_name)
  
      raise("Association `#{association_name}' not found on #{record_class}") if association.nil?
      raise("Association `#{association_name}' isn't belongs_to(is a #{association.macro})") unless association.belongs_to?
      
      association
      association_record = find_record(association.klass, conditions_str)
      
    else
      attr_name
    end
    
    if record_class.columns_hash[attr_name] # record_class.has_column?(attr_name)
    elsif
    end
    if column_attr.nil? # artist_name case 
      association = record_class.reflect_on_all_associations.detect {|a| header =~ /^#{a.name}/ }
      raise("Association: `#{header}' not found on #{record_class}") if association.nil?
      
      find_attrs = header.match(/^#{association.name}(.*)$/)[1]
      association_class = association.klass
      table.map_column!(header) { |value| association_class.send("find_by#{find_attrs}", value) }
    else
    end
  end
=end
  
  def value_from_str(value_str)
    instance_eval(value_str)
  end
  
  def conditions_from_str(conditions_str)
    record_conds = conditions_str.gsub(", and", ",").gsub(" and", ",").split(", ")
    conds = record_conds.map {|rc| rc.gsub(" => ", " of ").split(" of ") }

#    conds.inject({}) do |base, (attr_name, value_str)|
#      base[attr_from_name(class_record, attr_name)] = value_from_str(value_str)
#      base
#    end

    conds.inject({}) {|base, (attr, value_str)| base[attr] = instance_eval(value_str); base}
  end

  def find_record(record_class, record_conditions)
    conditions = conditions_from_str(record_conditions)
    record = record_class.find(:first, :conditions => conditions)
    record.nil? ? raise("Couldn't found any record for `#{record_class}' with conditions: `#{conditions.inspect}'") : record
  end
  
  def record_class_to_path(record_class)
    "/#{record_class.name.underscore.pluralize}"
  end
end