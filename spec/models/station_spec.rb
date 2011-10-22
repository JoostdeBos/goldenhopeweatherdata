require File.dirname(__FILE__) + '/../spec_helper'

describe Station do
  it "should be valid" do
    Station.new.should be_valid
  end
end
