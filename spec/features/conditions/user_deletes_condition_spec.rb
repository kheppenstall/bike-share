require './spec/spec_helper'

describe "When user deletes a condition" do
  it "it is removed" do
    @condition = Condition.create(date: "Thu, 01 Jan 2015")

    visit("/conditions/#{@condition.id}")

    click_on "Delete"

    expect(current_path).to eq('/conditions/page/1')
    expect(page).to_not have_content(@condition.date)
  end
end
