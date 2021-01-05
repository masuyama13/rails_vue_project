# frozen_string_literal: true

require "rails_helper"

describe "本管理", type: :system do
  describe "一覧表示機能" do
    before do
      FactoryBot.create(:book)
      visit books_path
    end
    it "本が一覧表示される" do
      expect(page).to have_content "Railsの教科書"
    end
  end

  describe "詳細表示機能" do
    before do
      book_id = FactoryBot.create(:book).id
      visit book_path(book_id)
    end
    it "本が表示される" do
      expect(page).to have_content "Railsの教科書"
    end
  end

  describe "新規登録機能" do
    before do
      visit new_book_path
      fill_in "Title", with: "New Rails Book"
      fill_in "Description", with: "New book."
      click_button "Create Book"
    end
    it "本を新規登録できる" do
      expect(page).to have_content "New Rails Book"
    end
  end

  describe "編集・更新機能" do
    before do
      book_id = FactoryBot.create(:book).id
      visit edit_book_path(book_id)
      fill_in "Description", with: "説明文を追加。"
      click_button "Update Book"
    end
    it "本を更新できる" do
      expect(page).to have_content "説明文を追加。"
    end
  end

  describe "削除機能" do
    before do
      FactoryBot.create(:book)
      visit books_path
      accept_confirm do
        click_link "Destroy"
      end
    end
    it "本を削除できる" do
      expect(page).to have_no_content "Railsの教科書"
    end
  end
end
