# Create Publishers
paste_magazine = Publisher.create(name: 'Paste Magazine')
publishers_weekly = Publisher.create(name: 'Publishers Weekly')
graywolf_press = Publisher.create(name: 'Graywolf Press')
mcsweeneys = Publisher.create(name: 'McSweeney\'s')

# Create Authors
joel_hartse = Author.create(first_name: 'Joel', last_name: 'Hartse')
hannah_p_templer = Author.create(first_name: 'Hannah', last_name: 'Templer', middle_name: 'P.')
marguerite_z_duras = Author.create(first_name: 'Marguerite', last_name: 'Duras', middle_name: ' Z.')
kingsley_amis = Author.create(first_name: 'Kingsley', last_name: 'Amis')
fannie_peters_flagg = Author.create(first_name: 'Fannie', last_name: 'Flagg', middle_name: 'Peters')
camille_byron_paglia = Author.create(first_name: 'Camille', last_name: 'Paglia', middle_name: 'Byron')
rainer_steel_rilke = Author.create(first_name: 'Rainer', last_name: 'Rilke', middle_name: 'Steel')

# Create Books
american_elf = Book.create(
  title: 'American Elf',
  isbn_13: '978-1-891830-85-3',
  list_price: 1000,
  publication_year: 2004,
  publisher: paste_magazine,
  edition: 'Book 2',
  image_url: 'american_elf.jpeg'
)
cosmoknights = Book.create(
  title: 'Cosmoknights',
  isbn_13: '978-1-60309-454-2',
  list_price: 2000,
  publication_year: 2019,
  publisher: publishers_weekly,
  edition: 'Book 1',
  image_url: 'cosmoknights.jpg'
)
essex_county = Book.create(
  title: 'Essex County',
  isbn_13: '978-1-60309-038-4',
  list_price: 500,
  publication_year: 1990,
  publisher: graywolf_press,
  image_url: 'essex_county.jpg'
)
hey_mister_vol_1 = Book.create(
  title: 'Hey, Mister (Vol 1)',
  isbn_13: '978-1-891830-02-0',
  list_price: 1200,
  publication_year: 2000,
  publisher: graywolf_press,
  edition: 'After School Special',
  image_url: 'hey_mister.jpeg'
)
underwater_welder = Book.create(
  title: 'The Underwater Welder',
  isbn_13: '978-1-60309-398-9',
  list_price: 3000,
  publication_year: 2022,
  publisher: mcsweeneys,
  image_url: 'the_underwater_welder.png'
)

# Associate Authors with Books
american_elf.authors << [joel_hartse, hannah_p_templer, marguerite_z_duras]
cosmoknights.authors << kingsley_amis
essex_county.authors << kingsley_amis
hey_mister_vol_1.authors << [hannah_p_templer, fannie_peters_flagg, camille_byron_paglia]
underwater_welder.authors << rainer_steel_rilke
