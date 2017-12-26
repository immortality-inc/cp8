class RecycleNotification
  DEFAULT_CHANNEL = "#reviews"
  DEFAULT_USERNAME = "CP-8"

  def initialize(issue:, comment_body:, channel:)
    @issue = issue
    @comment_body = comment_body
    @channel = channel || DEFAULT_CHANNEL
  end

  def deliver
    client.ping(message, channel: channel, username: DEFAULT_USERNAME)
  end

  private

    attr_reader :issue, :comment_body, :channel

    def message
      <<~TEXT
      #{mentions} #{issue.html_url} ready for re-review

      > #{comment_body.truncate(100)}
      TEXT
    end

    def mentions
      issue.reviewers.map(&:chat_name).join(", ")
    end

    def client
      Cp8.chat_client
    end
end