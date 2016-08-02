RSpec.feature 'Rich Editor Settings', :js do
  stub_authorization!

  context '#edit' do
    scenario 'have default elements' do
      visit spree.edit_admin_editor_settings_path

      within('legend') do
        expect(page).to have_text 'Rich Editor'
      end
      expect(page).to have_field 'ids', with: 'product_description page_body'
    end
  end

  context 'when changing editors' do
    given(:product) { create(:product) }

    context 'ckeditor' do
      scenario 'will be applied when used' do
        visit spree.edit_admin_editor_settings_path

        select2 'CKEditor', from: 'Rich Editor engine'
        click_button 'Update'

        visit spree.edit_admin_product_path(product)
        expect(page).to have_css '.cke_editor_product_description', match: :one
      end
    end
  end
end
