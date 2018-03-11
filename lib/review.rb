class Review
  attr_reader :html_url

  def initialize(state:, user:, html_url: nil, **other)
    @state = state
    @user_resource = user
    @html_url = html_url
  end

  def approved?
    state == "approved"
  end

  def changes_requested?
    state == "changes_requested"
  end

  def decisive?
    approved? || changes_requested?
  end

  def user
    User.from_resource(user_resource)
  end

  private

    attr_reader :state, :user_resource
end
