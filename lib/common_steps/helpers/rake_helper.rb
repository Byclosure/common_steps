module RakeHelper
  def rake(task)
    `cd #{RAILS_ROOT} && RAILS_ENV=#{RAILS_ENV} rake #{task}`
  end
end