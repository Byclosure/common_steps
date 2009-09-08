Spec::Matchers.define :count do |num|
  match do |collection|
    collection.count == num
  end
  
  failure_message_for_should do |collection|
    "expected #{collection} count to be #{num} instead of #{collection.count}"
  end
  
  failure_message_for_should_not do |collection|
    "expected #{collection} count not to be #{num}"
  end

  description do
    "count should be #{num}"
  end
end