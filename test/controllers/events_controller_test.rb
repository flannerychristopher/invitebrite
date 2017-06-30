require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
  end

  test "user responds yes after creating event" do
    log_in_as(@user)
    get new_event_path
    assert_difference '@user.invitations.count', 1 do
      post events_path, params: { event: { title: "event title",
                                           description: "have fun",
                                           location: "my house",
                                           date: "2019-06-30 12:30:00" } }
      end
  end
end
