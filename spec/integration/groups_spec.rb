require 'rails_helper'

RSpec.describe 'Categories', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'malik', email: 'malik@mail.com', password: '123456')
      sign_in @user

      @group = Group.create(user: @user, name: 'Apple', icon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNsvAC49r_HLtvqsmnoS-jtyhkwxfdJcHcFOTUW308-OUe17WmjKVPQTe542hUx9ZVpQE&usqp=CAU')
      visit groups_path
    end

    it 'renders name of group' do
      expect(page).to have_content(@group.name)
    end

    it 'renders icon of group' do
      find("img[src='#{@group.icon}']")
    end

    it 'renders total expenses of the group' do
      Entity.create(user: @user, name: 'Expense 1', amount: 10, group_ids: [@group.id])
      visit groups_path
      expect(page).to have_content(@group.entities.sum(:amount))
    end

    it 'redirects to group show page' do
      click_link @group.name
      expect(page).to have_current_path(group_entities_path(@group))
    end

    it 'redirects to create new group page' do
      click_link 'Add New Category'
      expect(page).to have_current_path(new_group_path)
    end
  end
  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'malik', email: 'malik@mail.com', password: '123456')
      sign_in @user

      @group = Group.create(user: @user, name: 'Apple', icon: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png')

      @entity = Entity.create(user: @user, name: 'Movie Ticket', amount: 26, group_ids: [@group.id])
      visit group_path(@group)
    end

    it 'renders name of group' do
      expect(page).to have_content(@group.name)
    end

    it 'renders total expenses of that group' do
      expect(page).to have_content(@group.entities.sum(:amount))
    end

    it 'redirects to categories page' do
      click_link 'Back'
      expect(page).to have_current_path(groups_path)
    end
  end
end
