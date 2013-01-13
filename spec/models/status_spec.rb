require "spec_helper"

describe Status do
  describe "object equality" do
    specify {Status::DRAFT.should === Status::DRAFT}
    specify {Status.new(0, 'Draft').should_not === Status::DRAFT}
  end
end