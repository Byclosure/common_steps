module NavigationHelper
  def path_to(page_name)
    # TODO: abandon use of perl like stuff
    case page_name
    when /^"(.+)"$/
      $1
    when /^the homepage$/
      '/'
    when /^the (.+) page$/
      "/#{$1}"
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in features/support/paths.rb"
    end
  end
=begin  
    when /^the list of (.+)$/
      send(:"#{$1.gsub(' ', '_')}_path")
    when /^the create (.+) page$/
      send(:"new_#{$1}_path")
    when /^that artists' country page$/ # project-specific
      country_path(@external_artist.country) # project-specific
    when /^the (.+) page$/
      send(:"#{$1.gsub(' ', '_')}_path")
    when /^my (.+) page$/
      send(:"#{$1.gsub(' ', '_')}_user_path", @user)
    when /^the show page of that (.+)$/
      model_name = $1.gsub(' ', '_')
      send(:"#{model_name}_path", instance_variable_get(:"@#{model_name}"))
    when /^the show page of the new (.+)$/
      send(:"#{$1}_path", $1.classify.constantize.find(:last, :order => "created_at"))
    when /^the show page of (.+) with (.+) "([^\"]*)"$/
      value = $3
      field_name = $2
      model_name = $1.gsub(' ', '_')
      send(:"#{model_name}_path", instance_variable_set("@#{model_name}", model_name.classify.constantize.send(:"find_by_#{field_name}", value)))
    when /^the edit page of that (.+)$/
      model_name = $1.gsub(' ', '_')
      send(:"edit_#{model_name}_path", instance_variable_get(:"@#{model_name}"))
    when /^the edit page of the new (.+)$/
      send(:"edit_#{$1}_path", $1.classify.constantize.find(:last, :order => "created_at"))
    when /^the edit page of (.+) with (.+) "([^\"]*)"$/
      send(:"edit_#{$1}_path", instance_variable_set("@#{$1}", $1.classify.constantize.send(:"find_by_#{$2}", $3)))
    when /^the delete page of that (.+) passing its (.+)$/
      field = $2.to_sym
      model_name = $1.gsub(' ', '_')
      model = instance_variable_get(:"@#{model_name}")
      send(:"delete_#{model_name}_path", model, field => model.send(field))
    when /^the delete page of that (.+)$/
      model_name = $1.gsub(' ', '_')
      send(:"delete_#{model_name}_path", instance_variable_get(:"@#{model_name}"))
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in features/support/paths.rb"
    end
  end
=end
end

