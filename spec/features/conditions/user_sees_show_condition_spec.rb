require './spec/spec_helper'

describe "when user visits /conditions/:id" do
  before :each do
    @condition = Condition.create(date: "Thu, 01 Jan 2015")
  end

  it "user sees condition" do

    visit("/conditions/#{@condition.id}")


    expect(page).to have_content("#{@condition.date.inspect}")
  end

  it "user sees condition attributes" do
    visit("/conditions/#{@condition.id}")

    expect(page).to have_content("#{@condition.date.inspect}")
  end

  it "user returns to index" do
    visit("/conditions/page/#{@condition.id}")


    expect(current_path).to eq("/conditions/page/1")
  end

  it "user edits a condition" do
    visit("/conditions/#{@condition.id}")

    click_on("Edit")

    expect(current_path).to eq("/conditions/#{@condition.id}/edit")
  end

  it "user deletes a condition" do
    visit("/conditions/#{@condition.id}")

    click_on("Delete")

    expect(current_path).to eq('/conditions/page/1')
  end
end
