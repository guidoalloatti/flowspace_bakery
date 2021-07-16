feature 'Cooking cookies' do
  scenario 'Cooking a single cookie without waiting' do
    user = create_and_signin
    oven = user.ovens.first

    visit oven_path(oven)

    expect(page).to_not have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'

    click_link_or_button 'Prepare Cookie'
    fill_in 'cookie[fillings]', with: 'Chocolate Chip'
    click_button 'Mix and bake'

    expect(current_path).to eq(oven_path(oven))
  
    expect(page).to have_content 'Chocolate Chip'
    expect(page).to have_content 'Prepare Cookie'

    expect(page).to_not have_content 'Your Cookie is Ready'

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content 'Cookies for sale'
    end
  end

  scenario 'Trying to bake a cookie while oven is full' do
    user = create_and_signin
    oven = user.ovens.first

    oven = FactoryGirl.create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button 'Prepare Cookie'
    fill_in 'cookie[fillings]', with: 'Chocolate Chip'
    click_button 'Mix and bake'

    click_link_or_button  'Prepare Cookie'
    expect(page).to have_content 'Some cookies are already in the oven!'
    expect(current_path).to eq(oven_path(oven))
    expect(page).to_not have_button 'Mix and bake'
  end

  scenario 'Baking a batch of 3 cookies when not ready' do
    user = create_and_signin
    oven = user.ovens.first

    oven = FactoryGirl.create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button 'Prepare Cookie'
    fill_in 'cookie[fillings]', with: 'Chocolate Chip'
    # fill_in 'Batch amount', with: '3'
    find('.primary-button.add-to-batch').click
    # click_button '.fill-oven'
    click_button 'Mix and bake'

    expect(page).to have_content 'Baking a batch of 1 cookie/s... please wait.'
  end

  scenario 'Baking multiple cookies', skip: true do
    user = create_and_signin
    oven = user.ovens.first

    oven = FactoryGirl.create(:oven, user: user)
    visit oven_path(oven)

    3.times do
      click_link_or_button 'Prepare Cookie'
      fill_in 'cookie[fillings]', with: 'Chocolate Chip'
      click_button 'Mix and bake'

      click_button 'Retrieve Cookie'
    end

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content 'Cookies for sale'
    end
  end
end
