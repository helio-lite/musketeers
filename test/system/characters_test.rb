require "application_system_test_case"

class CharactersTest < ApplicationSystemTestCase
  setup do
    @character = characters(:one)
  end

  test "visiting the index" do
    visit characters_url
    assert_selector "h1", text: "Characters"
  end

  test "creating a Character" do
    visit characters_url
    click_on "New Character"

    fill_in "Country", with: @character.country_id
    fill_in "Gun category", with: @character.gun_category_id
    fill_in "Gun type", with: @character.gun_type_id
    fill_in "Motif", with: @character.motif
    fill_in "Name en", with: @character.name_en
    fill_in "Name gun", with: @character.name_gun
    fill_in "Name ja", with: @character.name_ja
    click_on "Create Character"

    assert_text "Character was successfully created"
    click_on "Back"
  end

  test "updating a Character" do
    visit characters_url
    click_on "Edit", match: :first

    fill_in "Country", with: @character.country_id
    fill_in "Gun category", with: @character.gun_category_id
    fill_in "Gun type", with: @character.gun_type_id
    fill_in "Motif", with: @character.motif
    fill_in "Name en", with: @character.name_en
    fill_in "Name gun", with: @character.name_gun
    fill_in "Name ja", with: @character.name_ja
    click_on "Update Character"

    assert_text "Character was successfully updated"
    click_on "Back"
  end

  test "destroying a Character" do
    visit characters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Character was successfully destroyed"
  end
end
